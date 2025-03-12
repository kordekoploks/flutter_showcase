import 'package:eshop/domain/entities/category/outcome_sub_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shimmer/shimmer.dart';

import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:eshop/core/constant/images.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/util/UuidHelper.dart';
import 'package:eshop/presentation/widgets/alert_card.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../data/models/category/income_category_model.dart';
import '../../../../../domain/entities/category/income_category.dart';
import '../../../../blocs/category/income_category_bloc.dart';
import '../../../../widgets/income_category/income_category_card.dart';
import '../../outcome_category/confirmation_bottom_sheet.dart';
import 'income_category_bottom_sheet/income_category_action_bottom_sheet.dart';
import 'income_category_bottom_sheet/income_category_add_bottom_sheet.dart';
import 'income_category_bottom_sheet/income_category_edit_bottom_sheet.dart';
import 'income_category_bottom_sheet/income_sub_category_bottom_sheet.dart';

class IncomeCategoryView extends StatefulWidget {
  const IncomeCategoryView({Key? key}) : super(key: key);

  @override
  _IncomeCategoryViewState createState() => _IncomeCategoryViewState();
}

class _IncomeCategoryViewState extends State<IncomeCategoryView> {
  int _selectedIndex = 0;
  final List<String> _tabTitles = ['Pengeluaran', 'Pendapatan'];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<IncomeCategory> _data = [];
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
    context.read<IncomeCategoryBloc>().add(const GetIncomeCategories());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<IncomeCategoryBloc, IncomeCategoryState>(
        listener: (context, state) {
          if (state is IncomeCategoryLoaded) {
            _setData(state);
          } else if (state is IncomeCategoryAdded) {
            _addSubCategory(state);
          } else if (state is IncomeCategoryDeleted) {
            _removeSubCategory(state);
          } else if (state is IncomeCategoryUpdated) {
            _updateCategory(state);
          } else if (state is IncomeCategoryEmpty)
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(kEmpty),
          const SizedBox(height: 16),
          Text("Categories is not found!", textAlign: TextAlign.center),
          IconButton(
            onPressed: () =>
                context.read<IncomeCategoryBloc>().add(const GetIncomeCategories()),
            //todo untuk membaca bahwa kategori lengit terus munculkan tobol repres yg di drag
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }

  void _setData(IncomeCategoryLoaded state) {
    setState(() {
      _data.clear();
      _data.addAll(state.data);
    }
    );
  }

  void _emptyData(IncomeCategoryEmpty state) {
    setState(() {
      _data.clear();
    }
    );
  }

  void _addSubCategory(IncomeCategoryAdded state) {
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


  void _removeSubCategory(IncomeCategoryDeleted state) {
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

  void _updateCategory(IncomeCategoryUpdated state) {
    final index = _data.indexWhere(
          (subCategory) => subCategory.id == state.dataUpdated.id,
    );
    if (index >= 0) {
      setState(() {
        _data[index] = state.dataUpdated.copyWith(isUpdated: true);
      }
      );
    }
  }

  void _showAddCategoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return IncomeCategoryAddBottomSheet(
          onSave: (name,description) {
            final currentState = context
                .read<IncomeCategoryBloc>()
                .state;
            int position = currentState is IncomeCategoryLoaded
                ? currentState.data.length + 1
                : 0;

            final newCategory = IncomeCategoryModel(
              id: UuidHelper.generateNumericUUID(),
              name: name,
              desc: '$description',
              position: position,
              image: '$name Image URL here',
              icon: 'icon',
            );
            // tombol add terusan dari atas
            context.read<IncomeCategoryBloc>().add(AddCategory(newCategory));
          },
        );
      },
    );
  }

  Widget _buildErrorState(BuildContext context, IncomeCateogryError state) {
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
                context.read<IncomeCategoryBloc>().add(const GetIncomeCategories()),
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
        context.read<IncomeCategoryBloc>().add(FilterCategories(val));
      },
      onChanged: (val) =>
          setState(() {
            context.read<IncomeCategoryBloc>().add(FilterCategories(val));
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
                    .read<IncomeCategoryBloc>()
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
        onRefresh: () async{
          context
              .read<IncomeCategoryBloc>()
              .add(const GetIncomeCategories());
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
                bottom: 80 + MediaQuery
                    .of(context)
                    .padding
                    .bottom,
              ),
              itemBuilder: (context, index, animation) {
                if (index >= _data.length) {
                  // Prevent accessing out-of-bound indexes
                  return const SizedBox.shrink();
                }

                final categoryModel = _data[index];
                return _buildCategoryItem(
                    context, categoryModel, animation, index);
              },
            );
          },
        ),
      );
    }
  }

  Widget _buildCategoryItem(BuildContext context, IncomeCategory categoryModel,
      Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: IncomeCategoryCard(
        category: categoryModel,
        onClickMoreAction: (category) =>
            _showCategoryActionBottomSheet(context, categoryModel, index),
        onUpdate: (editedCategory) {
          context
              .read<IncomeCategoryBloc>()
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
      IncomeCategory categoryModel, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return IncomeCategoryActionBottomSheet(
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
      IncomeCategory categoryModel, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return IncomeCategoryEditBottomSheet(
          category: categoryModel,
          onSave: (editedCategory) {
            context
                .read<IncomeCategoryBloc>()
                .add(UpdateCategory(editedCategory));
          },
        );
      },
    );
  }

  void _showSubCategoriesBottomSheet(BuildContext context,
      IncomeCategory categoryModel, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return IncomeSubCategoryBottomSheet(category: categoryModel);
      },
    );
  }

  void _showDeleteConfirmationBottomSheet(BuildContext context,
      IncomeCategory categoryModel, int index) {
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
                .read<IncomeCategoryBloc>()
                .add(DeleteCategory(categoryModel));
          },
        );
      },
    );
  }


}
