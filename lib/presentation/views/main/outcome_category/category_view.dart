import 'package:eshop/domain/entities/category/outcome_sub_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    //todo  untuk mennampilkan income data

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OutcomeCategoryBloc, OutcomeCategoryState>(
      // todo untuk melisten income
        listener: (context, state) {
          if (state is OutcomeCategoryLoaded) {
            _setData(state);
            //todo untuk set data income,
          } else if (state is OutcomeCategoryAdded) {
            _addSubCategory(state);

          } else if (state is OutcomeCategoryDeleted) {
            _removeSubCategory(state);

          } else if (state is OutcomeCategoryUpdated) {
            _updateCategory(state);
            //todo untuk update data category outcome,
          } else if (state is OutcomeCategoryLoading) {
            // _updateSubCategory(state);
          } else if (state is OutcomeCategoryEmpty)
            _emptyData(state);
          //todo untuk menampilkan bahwa data kosong,
        },
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showAddCategoryBottomSheet(context),
            label: Text(
              'AdD',
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
                context.read<OutcomeCategoryBloc>().add(const GetCategories()),
            //todo untuk membaca bahwa kategori lengit terus munculkan tobol repres yg di drag
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );

  }

  void _setData(OutcomeCategoryLoaded state) {
    setState(() {
      _data.clear();// untuk menghapus data di view
      _data.addAll(state.data); //  untuk menambahkan data baru dari bloc
    });
  }

  void _emptyData(OutcomeCategoryEmpty state) {
    setState(() {
      _data.clear();//todo untuk mengosngkan data dari view
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

  void _updateCategory(OutcomeCategoryUpdated state) {
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
            //todo untuk membaca dari bloc untuk menambahkan data pada saat menambahkan kategori
                .state;
            int position = currentState is OutcomeCategoryLoaded
            //todo untuk emit dari bloc sebelum edit selesai
                ? currentState.data.length + 1
                : 0;

            final newCategory = OutcomeCategoryModel( //todo untuk menambahkan deskripsi dan gambar untuk field kategori view
              id: UuidHelper.generateNumericUUID(),
              name: name,
              desc: '$name Description here',
              position: position,
              image: '$name Image URL here',
            );

            context.read<OutcomeCategoryBloc>().add(AddCategory(newCategory));
          },//todo untuk membaca categori yang telah ditambahin
        );
      },
    );
  }

  Widget _buildErrorState(BuildContext context, OutcomeCateogryError state) { //todo untuk menampilka apa wae saat error terjadi
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
                context.read<OutcomeCategoryBloc>().add(const GetCategories()), //todo untuk membaca category yang memunculkan icon repres
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
        context.read<OutcomeCategoryBloc>().add(FilterCategories(val));//todo untuk membaca filter kategori di search saat enter
      },
      onChanged: (val) =>
          setState(() {
            context.read<OutcomeCategoryBloc>().add(FilterCategories(val));//todo untuk membaca saat memasukan huruf di search
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
                    .read<OutcomeCategoryBloc>() //todo untuk membaca kategori dari bloc untuk filter categori
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
              .read<OutcomeCategoryBloc>()
              .add(const GetCategories());
        },
        //todo add read for incme caegory bloc
        //todo make income category file for class

        child: FutureBuilder(
          future: Future.delayed(Duration.zero),
          builder: (context, snapshot) {
            return AnimatedList(
              key: _listKey,
                initialItemCount: _data.isNotEmpty ? _data.length : 0,
              padding: EdgeInsets.only(
                top: 28,
                bottom: 80 + MediaQuery
                    .of(context)
                    .padding
                    .bottom,
              ),
              itemBuilder: (context, index, animation) {
                final categoryModel = _data[index];
                return _buildCategoryItem(
                    context, categoryModel, animation, index);
              },
            );
          },
        )
        ,
      );
    }
  }

  Widget _buildCategoryItem(BuildContext context, OutcomeCategory categoryModel, //todo untuk menampilkan data yang telah diisi
      Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: OutcomeCategoryCard( //todo untuk mendapatkan data dari outcome categori card
        category: categoryModel,
        onClickMoreAction: (category) =>
            _showCategoryActionBottomSheet(context, categoryModel, index),
        onUpdate: (editedCategory) {
          context
              .read<OutcomeCategoryBloc>().add(UpdateCategory(editedCategory)); // todo untuk membaca update kategori yang telah di tambahkan
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
      OutcomeCategory categoryModel, int index) { //todo untuk menapmpilkan data untuk bottom sheet
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return OutcomeCategoryActionBottomSheet( //todo untuk menampilkan data kembali untuk bottomshet
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
      OutcomeCategory categoryModel, int index) { //todo untuk mendapatkan data untuk bottomshit
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CategoryEditBottomSheet(
          category: categoryModel,
          onSave: (editedCategory) {
            context
                .read<OutcomeCategoryBloc>() //todo untuk membaca kategori yang di edit
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
      OutcomeCategory categoryModel, int index) { //todo untuk menampilkan data peringatan saaat mau delete
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
                .read<OutcomeCategoryBloc>()//todo untuk membaca categori dari bloc
                .add(DeleteCategory(categoryModel));
          },
        );
      },
    );
  }


}
