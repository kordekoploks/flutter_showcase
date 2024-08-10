import 'package:eshop/data/models/category/category_model.dart';
import 'package:eshop/presentation/views/main/category/category_action_bottom_sheet.dart';
import 'package:eshop/presentation/widgets/category_card.dart';
import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constant/images.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/UuidHelper.dart';
import '../../../../domain/entities/category/category.dart';
import '../../../blocs/category/category_bloc.dart';
import '../../../widgets/alert_card.dart';
import '../../../widgets/vw_tab_bar.dart';
import 'category_add_bottom_sheet.dart';
import 'category_edit_bottom_sheet.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  int _selectedIndex = 0;

  final List<String> _tabTitles = ['Pengeluaran', 'Pendapatan'];
  final List<Function> _tabCallbacks = [
    () => print('Tab 1 clicked'),
    () => print('Tab 2 clicked'),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _tabCallbacks[index]();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return CategoryAddBottomSheet(
                onSave: (name) {
                  final currentState = context.read<CategoryBloc>().state;
                  int position = 0;

                  if (currentState is CategoryLoaded) {
                    position = currentState.categories.length + 1;
                  }

                  // Add the new category with the correct position
                  context.read<CategoryBloc>().add(AddCategory(
                        CategoryModel(
                          id: UuidHelper.generateNumericUUID(),
                          name: name,
                          desc: '${name} Description here',
                          // Add appropriate description if needed
                          position: position,
                          image:
                              '${name} Image URL here', // Add appropriate image URL if needed
                        ),
                      ));
                },
              );
            },
          );
          // Add your onPressed code here!
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
      appBar: const VwAppBar(
        title: 'Kelola Kategori',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: (MediaQuery.of(context).padding.top + 8),
            ),
            VwTabBar(
              titles: _tabTitles,
              selectedIndex: _selectedIndex,
              onTabTapped: _onTabTapped,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
              ),
            ),
            Expanded(
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoaded && state.categories.isEmpty) {
                    return const AlertCard(
                      image: kEmpty,
                      message: "Categories not found!",
                    );
                  }

                  if (state is CategoryError) {
                    if (state.failure is NetworkFailure) {
                      return AlertCard(
                        image: kNoConnection,
                        message: "Network failure\nTry again!",
                        onClick: () {
                          context
                              .read<CategoryBloc>()
                              .add(const GetCategories());
                        },
                      );
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state.failure is ServerFailure)
                          Image.asset(
                              'assets/status_image/internal-server-error.png'),
                        if (state.failure is NetworkFailure)
                          Image.asset('assets/status_image/no-connection.png'),
                        const Text("Categories not found!"),
                        IconButton(
                            onPressed: () {
                              context
                                  .read<CategoryBloc>()
                                  .add(const GetCategories());
                            },
                            icon: const Icon(Icons.refresh)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        )
                      ],
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<CategoryBloc>().add(const GetCategories());
                    },
                    child: ListView.builder(
                      itemCount: state.categories.length +
                          ((state is CategoryLoading) ? 10 : 0),
                      controller: ScrollController(),
                      padding: EdgeInsets.only(
                        top: 28,
                        left: 0,
                        right: 0,
                        bottom: 80 + MediaQuery.of(context).padding.bottom,
                      ),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        if (state.categories.length > index) {
                          Category categoryModel = state.categories[index];
                          return CategoryCard(
                              category: categoryModel,
                              onClickMoreAction: (category) {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return CategoryActionBottomSheet(
                                        category: categoryModel,
                                        onEdit: (category) {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return CategoryEditBottomSheet(
                                                category: categoryModel,
                                                onSave: (editedCategory) {
                                                  context
                                                      .read<CategoryBloc>()
                                                      .add(UpdateCategory(
                                                          editedCategory));
                                                },
                                              );
                                            },
                                          );
                                        },
                                        onDelete: (category) {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return CategoryEditBottomSheet(
                                                category: categoryModel,
                                                onSave: (editedCategory) {
                                                  context
                                                      .read<CategoryBloc>()
                                                      .add(UpdateCategory(
                                                          editedCategory));
                                                },
                                              );
                                            },
                                          );
                                        });
                                  },
                                );
                              });
                        }
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade100,
                          highlightColor: Colors.white,
                          child: const CategoryCard(),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
