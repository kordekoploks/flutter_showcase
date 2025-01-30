import 'package:eshop/presentation/blocs/category/outcome_category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Models & Entities
import 'package:eshop/domain/entities/category/outcome_category.dart';
import 'package:eshop/domain/entities/category/outcome_sub_category.dart';

// Blocs
import '../../../../blocs/outcome_sub_category/outcome_sub_category_bloc.dart';

// Widgets
import '../../../../widgets/alert_card.dart';
import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';
import '../../../../widgets/outcome_category/outcome_sub_category_card.dart';
import '../confirmation_bottom_sheet.dart';
import '../sub_category_add_bottom_sheet.dart';
import 'outcome_sub_category_edit_bottom_sheet.dart';

// Utilities & Constants
import '../../../../../core/constant/images.dart';

class OutcomeSubCategoryBottomSheet extends StatefulWidget {
  final OutcomeCategory category;

  const OutcomeSubCategoryBottomSheet({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  _OutcomeSubCategoryBottomSheetState createState() =>
      _OutcomeSubCategoryBottomSheetState();
}

class _OutcomeSubCategoryBottomSheetState
    extends State<OutcomeSubCategoryBottomSheet> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<OutcomeSubCategory> _subCategories = [];

  @override
  void initState() {
    super.initState();
    _fetchSubCategories();
  }

  void _fetchSubCategories() {
    context.read<OutcomeSubCategoryBloc>().add(GetSubCategories(widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OutcomeSubCategoryBloc, OutcomeSubCategoryState>(
      listener: (context, state) {
        if (state is OutcomeSubCategoryLoaded) {
          _setSubCategories(state);
        } else if (state is OutcomeSubCategoryAdded) {
          _addSubCategory(state);
        } else if (state is OutcomeSubCategoryDeleted) {
          _removeSubCategory(state);
        }else if (state is OutcomeSubCategoryUpdated) {
          _updateSubCategory(state);
        }else if(state is OutcomeSubCategoryEmpty){
          _emptySubCategories();
        }
      },
      child: VWBottomSheet(
        title: "${widget.category.name} Sub Categories",
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAddSubCategoryTile(context),
            const SizedBox(height: 16),
            _buildSubCategoryContent(),
          ],
        ),
      ),
    );
  }


  void _setSubCategories(OutcomeSubCategoryLoaded state) {
    setState(() {
      _subCategories.clear();
      _subCategories.addAll(state.data);
    });
  }


  void _emptySubCategories() {
    setState(() {
      _subCategories.clear();
    });
  }


  void _addSubCategory(OutcomeSubCategoryAdded state) {
    _subCategories.add(state.dataAdded);
    // If this is the first item, rebuild the widget to show the list
    if (_subCategories.length == 1) {
      _listKey.currentState?.insertItem(0);
      setState(() {}); // This will trigger a rebuild and show the empty state

    } else {
      _listKey.currentState?.insertItem(_subCategories.length - 1);
    }
  }

  void _removeSubCategory(OutcomeSubCategoryDeleted state) {
    final index = _subCategories.indexOf(state.dataDeleted);
    if (index >= 0) {
      _listKey.currentState?.removeItem(
        index,
            (context, animation) => _buildSubCategoryCard(
          context,
          state.dataDeleted,
          index,
          animation,
        ),
      );
      _subCategories.removeAt(index);
      if (_subCategories.isEmpty) {
        setState(() {}); // This will trigger a rebuild and show the empty state
      }
    }
  }
  void _updateSubCategory(OutcomeSubCategoryUpdated state) {
    final index = _subCategories.indexWhere(
          (subCategory) => subCategory.id == state.dataUpdated.id,
    );
    if (index >= 0) {
      setState(() {
        _subCategories[index] = state.dataUpdated.copyWith(isUpdated: true);
      });
    }
  }

  Widget _buildSubCategoryContent() {
    if (_subCategories.isEmpty) {
      return _buildEmptyState();
    } else {
      // Use FutureBuilder to ensure AnimatedList is built after setState() is called
      return FutureBuilder(
        future: Future.delayed(Duration.zero), // Delays the build to ensure proper rendering
        builder: (context, snapshot) {
          return SizedBox(
            height: 300,
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _subCategories.length,
              itemBuilder: (context, index, animation) {
                final subCategory = _subCategories[index];
                return _buildSubCategoryCard(
                  context,
                  subCategory,
                  index,
                  animation,
                );
              },
            ),
          );
        },
      );
    }
  }



  Widget _buildEmptyState() {
    return const AlertCard(
      image: kEmpty,
      message: "Categories not found!",
    );
  }

  Widget _buildSubCategoryCard(BuildContext context, OutcomeSubCategory subCategory, int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: OutcomeSubCategoryCard(
        subCategory: subCategory,
        index: index,
        isUpdated: subCategory.isUpdated,
        onEdit: () => _showEditSubCategoryBottomSheet(context, subCategory, index),
        onDelete: () => _showDeleteSubCategoryBottomSheet(context, subCategory, index),
        onAnimationEnd: () {
          setState(() {
            _subCategories[index] = _subCategories[index].copyWith(isUpdated: false);
          });
        },
      ),
    );
  }

  Widget _buildAddSubCategoryTile(BuildContext context) {
    return GestureDetector(
      onTap: () => _showAddSubCategoryBottomSheet(context),
      child: const ListTile(
        title: Text('Add Sub Category'),
        trailing: Icon(Icons.add),
      ),
    );
  }

  void _showAddSubCategoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return OutcomeSubCategoryAddBottomSheet(
          onSave: (data) {
            context.read<OutcomeSubCategoryBloc>().add(AddSubCategory(data));
          },
          categoryModel: widget.category,
        );
      },
    );
  }

  void _showEditSubCategoryBottomSheet(BuildContext context,
      OutcomeSubCategory subCategory, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return OutcomeSubCategoryEditBottomSheet(
          outcomeSubCategory: subCategory,
          outcomeCategory: widget.category,
          onSave: (updatedSubCategory) {
            context
                .read<OutcomeSubCategoryBloc>()
                .add(UpdateSubCategory(updatedSubCategory));
          },
        );
      },
    );
  }

  void _showDeleteSubCategoryBottomSheet(BuildContext context,
      OutcomeSubCategory subCategory, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ConfirmationBottomSheet(
          title: "Delete Sub Category",
          desc: Text.rich(
            TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                const TextSpan(
                    text: "Are you sure you want to delete the subcategory "),
                TextSpan(
                  text: subCategory.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: "?"),
              ],
            ),
          ),
          positiveLabel: "Delete",
          negativeLabel: "Cancel",
          onPositiveClick: () {
            context
                .read<OutcomeSubCategoryBloc>()
                .add(DeleteSubCategory(subCategory));
          },
        );
      },
    );
  }
}
