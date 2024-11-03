import 'package:eshop/domain/entities/category/outcome_sub_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shimmer/shimmer.dart';

import 'package:eshop/data/models/category/outcome_category_model.dart';
import 'package:eshop/presentation/widgets/outcome_category/outcome_category_card.dart';
import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:eshop/core/constant/images.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/util/UuidHelper.dart';
import 'package:eshop/domain/entities/category/outcome_category.dart';
import 'package:eshop/presentation/blocs/category/category_bloc.dart';
import 'package:eshop/presentation/widgets/alert_card.dart';

import '../../../../core/constant/colors.dart';
import 'bottom_sheet/outcome_category_action_bottom_sheet.dart';
import 'bottom_sheet/outcome_category_add_bottom_sheet.dart';
import 'bottom_sheet/outcome_category_edit_bottom_sheet.dart';
import 'bottom_sheet/outcome_sub_category_bottom_sheet.dart';
import 'confirmation_bottom_sheet.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  int _selectedIndex = 0;
  final List<String> _tabTitles = ['Pengeluaran', 'Pendapatan'];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<OutcomeCategory> _data = [];
  final TextEditingController _filterController = TextEditingController();

  // void _onTabTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  //   print('Tab $index clicked');
  // }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    context.read<OutcomeCategoryBloc>().add(const GetCategories());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OutcomeCategoryBloc, OutcomeCategoryState>(
        listener: (context, state) {
          if (state is OutcomeCategoryLoaded) {
            _setData(state);
          } else if (state is OutcomeCategoryAdded) {
            _addSubCategory(state);
          } else if (state is OutcomeCategoryDeleted) {
            _removeSubCategory(state);
          } else if (state is OutcomeCategoryUpdated) {
            _updateSubCategory(state);
          } else if (state is OutcomeCategoryLoading) {
            showToast('LOADING...',duration: Duration(seconds: 2));
          } else if (state is OutcomeCategoryEmpty)
            _emptyData(state);
        },
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showAddCategoryBottomSheet(context),
            label: Text(
              'Add',
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            icon: const Icon(Icons.add, color: Colors.white),
            backgroundColor: vWPrimaryColor,
          ),
          appBar: const VwAppBar(title: 'Kelola Kategori'),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(child: _buildCategoryList(context)),
              ],
            ),
          ),
        ));
  }

  Widget _buildEmptyState() {
    return const AlertCard(
      image: kEmpty,
      message: "Categories not found!",
    );
  }

  void _setData(OutcomeCategoryLoaded state) {
    setState(() {
      _data.clear();
      _data.addAll(state.data);
    });
  }

  void _emptyData(OutcomeCategoryEmpty state) {
    setState(() {
      _data.clear();
    });
  }

  void _addSubCategory(OutcomeCategoryAdded state) {
    _data.add(state.dataAdded);

    // Trigger the animation for the new item

    if (_data.length == 1) {
      _listKey.currentState
          ?.insertItem(0);
      setState(() {}); // This will trigger a rebuild and show the empty state
    } else {
      _listKey.currentState?.insertItem(_data.length - 1);
    }
  }


  void _removeSubCategory(OutcomeCategoryDeleted state) {
    final index = _data.indexOf(state.dataDeleted);
    if (index >= 0) {
      _listKey.currentState?.removeItem(
        index,
            (context, animation) =>
            _buildCategoryItem(
                context,
                state.dataDeleted,
                animation,
                index
            ),
      );
      _data.removeAt(index);
    }
  }

  void _updateSubCategory(OutcomeCategoryUpdated state) {
    final index = _data.indexWhere(
          (subCategory) => subCategory.id == state.dataUpdated.id,
    );
    if (index >= 0) {
      setState(() {
        _data[index] = state.dataUpdated.copyWith(isUpdated: true);
      });
    }
  }

  void _showAddCategoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CategoryAddBottomSheet(
          onSave: (name) {
            final currentState = context
                .read<OutcomeCategoryBloc>()
                .state;
            int position = currentState is OutcomeCategoryLoaded
                ? currentState.data.length + 1
                : 0;

            final newCategory = OutcomeCategoryModel(
              id: UuidHelper.generateNumericUUID(),
              name: name,
              desc: '$name Description here',
              position: position,
              image: '$name Image URL here',
            );

            context.read<OutcomeCategoryBloc>().add(AddCategory(newCategory));
          },
        );
      },
    );
  }

  Widget _buildErrorState(BuildContext context, OutcomeCateogryError state) {
    final imagePath = state.failure is NetworkFailure
        ? 'assets/status_image/no-connection.png'
        : 'assets/status_image/internal-server-error.png';
    final message = state.failure is NetworkFailure
        ? "Network failure\nTry again!"
        : "Categories not found!";

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath),
          const SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center),
          IconButton(
            onPressed: () =>
                context.read<OutcomeCategoryBloc>().add(const GetCategories()),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        _buildFilterTextField(context), // Extracted filter widget
        Expanded(
          child: _buildCategoryListView(
              context), // Extracted RefreshIndicator and AnimatedList logic
        ),
      ],
    );
  }



  Widget _buildFilterTextField(BuildContext context) {
    return TextField(
      controller: _filterController,
      autofocus: false,
      onSubmitted: (val) {
        context.read<OutcomeCategoryBloc>().add(FilterCategories(val));
      },
      onChanged: (val) =>
          setState(() {
            context.read<OutcomeCategoryBloc>().add(FilterCategories(val));
          }),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20, bottom: 22, top: 22),
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(Icons.search),
        ),
        suffixIcon: _filterController.text.isNotEmpty
            ? Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: () {
              setState(() {
                _filterController.clear();
                context
                    .read<OutcomeCategoryBloc>()
                    .add(const FilterCategories(''));
              });
            },
            icon: const Icon(Icons.clear),
          ),
        )
            : null,
        border: const OutlineInputBorder(),
        hintText: "Search",
        fillColor: Colors.grey.shade100,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 3.0),
          borderRadius: BorderRadius.circular(26),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(26),
          borderSide: const BorderSide(color: Colors.white, width: 3.0),
        ),
      ),
    );
  }

  Widget _buildCategoryListView(BuildContext context) {
    if (_data.isEmpty) {
      return _buildEmptyState();
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          context.read<OutcomeCategoryBloc>().add(const GetCategories());
        },
        child: FutureBuilder(
          future: Future.delayed(Duration.zero),
          builder: (context, snapshot) {
            // Safeguard: Ensure _data is not modified during the build phase
            if (_data.isEmpty) {
              return _buildEmptyState();
            }

            return AnimatedList(
              key: _listKey,
              initialItemCount: _data.length, // Ensure this matches _data's length
              padding: EdgeInsets.only(
                top: 28,
                bottom: 80 + MediaQuery.of(context).padding.bottom,
              ),
              itemBuilder: (context, index, animation) {
                if (index >= _data.length) {
                  // Prevent accessing out-of-bound indexes
                  return const SizedBox.shrink();
                }

                final categoryModel = _data[index];
                return _buildCategoryItem(context, categoryModel, animation, index);
              },
            );
          },
        ),
      );
    }
  }


  Widget _buildCategoryItem(BuildContext context, OutcomeCategory categoryModel,
      Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: OutcomeCategoryCard(
        category: categoryModel,
        onClickMoreAction: (category) =>
            _showCategoryActionBottomSheet(context, categoryModel, index),
        onUpdate: (editedCategory) {
          context
              .read<OutcomeCategoryBloc>()
              .add(UpdateCategory(editedCategory));
        },
        onClickToggle: (item) {
          _showSubCategoriesBottomSheet(context, categoryModel, index);
        },
        onAnimationEnd: () {
          setState(() {
            _data[index] = _data[index].copyWith(isUpdated: false);
          });
        },
        index: index,
        isUpdated: categoryModel.isUpdated,
      ),
    );
  }

  void _showCategoryActionBottomSheet(BuildContext context,
      OutcomeCategory categoryModel, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return OutcomeCategoryActionBottomSheet(
          category: categoryModel,
          onEdit: (category) =>
              _showEditCategoryBottomSheet(context, categoryModel, index),
          onDelete: (category) =>
              _showDeleteConfirmationBottomSheet(context, categoryModel, index),
          onSubCategories: (category) {
            _showSubCategoriesBottomSheet(context, categoryModel, index);
          },
        );
      },
    );
  }

  void _showEditCategoryBottomSheet(BuildContext context,
      OutcomeCategory categoryModel, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CategoryEditBottomSheet(
          category: categoryModel,
          onSave: (editedCategory) {
            context
                .read<OutcomeCategoryBloc>()
                .add(UpdateCategory(editedCategory));
          },
        );
      },
    );
  }

  void _showSubCategoriesBottomSheet(BuildContext context,
      OutcomeCategory categoryModel, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return OutcomeSubCategoryBottomSheet(category: categoryModel);
      },
    );
  }

  void _showDeleteConfirmationBottomSheet(BuildContext context,
      OutcomeCategory categoryModel, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ConfirmationBottomSheet(
          title: "Hapus Kategori",
          desc: Text.rich(
            TextSpan(
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium,
              children: [
                const TextSpan(
                    text: "Apakah kamu yakin akan menghapus kategori "),
                TextSpan(
                  text: categoryModel.name,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: "?"),
              ],
            ),
          ),
          positiveLabel: "Hapus",
          negativeLabel: "Tidak",
          onPositiveClick: () {
            context
                .read<OutcomeCategoryBloc>()
                .add(DeleteCategory(categoryModel));
          },
        );
      },
    );
  }


}
