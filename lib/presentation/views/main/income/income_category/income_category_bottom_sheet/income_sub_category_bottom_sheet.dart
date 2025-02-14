
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Models & Entities
// Blocs
import '../../../../../../core/constant/images.dart';
import '../../../../../../domain/entities/category/income_category.dart';
import '../../../../../../domain/entities/category/income_sub_category.dart';
import '../../../../../blocs/income/income_sub_category_bloc.dart';
import '../../../../../widgets/alert_card.dart';
// Widgets

import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';

import '../../../../../widgets/income_category/income_sub_category_card.dart';
import '../../../outcome_category/bottom_sheet/sub_categoriy_income_add_bottom_sheet.dart';
import 'income_confirmation_bottom_sheet.dart';
import 'income_sub_category_add_bottom_sheet.dart';
import 'income_sub_category_edit_bottom_sheet.dart';
// Utilities & Constants
class IncomeSubCategoryBottomSheet extends StatefulWidget {
  final IncomeCategory category;

  const IncomeSubCategoryBottomSheet({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  _IncomeSubCategoryBottomSheetState createState() =>
      _IncomeSubCategoryBottomSheetState();
}

class _IncomeSubCategoryBottomSheetState
    extends State<IncomeSubCategoryBottomSheet> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<IncomeSubCategory> _subCategories = [];

  @override
  void initState() {
    super.initState();
    _fetchSubCategories();
  }

  void _fetchSubCategories() {
    context.read<IncomeSubCategoryBloc>().add(GetSubCategories(widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<IncomeSubCategoryBloc, IncomeSubCategoryState>(
      listener: (context, state) {
        if (state is IncomeSubCategoryLoaded) {
          _setSubCategories(state);
        } else if (state is IncomeSubCategoryAdded) {
          _addSubCategory(state);
        } else if (state is IncomeSubCategoryDeleted) {
          _removeSubCategory(state);
        }else if (state is IncomeSubCategoryUpdated) {
          _updateSubCategory(state);
        }else if(state is IncomeSubCategoryEmpty){
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


  void _setSubCategories(IncomeSubCategoryLoaded state) {
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


  void _addSubCategory(IncomeSubCategoryAdded state) {
    _subCategories.add(state.dataAdded);
    // If this is the first item, rebuild the widget to show the list
    if (_subCategories.length == 1) {
      _listKey.currentState?.insertItem(0);
      setState(() {}); // This will trigger a rebuild and show the empty state

    } else {
      _listKey.currentState?.insertItem(_subCategories.length - 1);
    }
  }

  void _removeSubCategory(IncomeSubCategoryDeleted state) {
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
  void _updateSubCategory(IncomeSubCategoryUpdated state) {
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

  Widget _buildSubCategoryCard(BuildContext context, IncomeSubCategory subCategory, int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: IncomeSubCategoryCard(
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
        return SubCategoryIncomeAddBottomSheet(
          onSave: (data) {
            context.read<IncomeSubCategoryBloc>().add(AddSubCategory(data));
          },
          categoryModel: widget.category,
        );
      },
    );
  }

  void _showEditSubCategoryBottomSheet(BuildContext context,
      IncomeSubCategory subCategory, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return IncomeSubCategoryEditBottomSheet(
          incomeSubCategory: subCategory,
          incomeCategory: widget.category,
          onSave: (updatedSubCategory) {
            context
                .read<IncomeSubCategoryBloc>()
                .add(UpdateSubCategory(updatedSubCategory));
          },
        );
      },
    );
  }

  void _showDeleteSubCategoryBottomSheet(BuildContext context,
      IncomeSubCategory subCategory, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return IncomeConfirmationBottomSheet(
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
                .read<IncomeSubCategoryBloc>()
                .add(DeleteSubCategory(subCategory));
          },
        );
      },
    );
  }
}
