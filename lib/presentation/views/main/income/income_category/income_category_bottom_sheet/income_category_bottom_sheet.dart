import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Models & Entities
// Utilities & Constants
import '../../../../../../core/constant/images.dart';
import '../../../../../../domain/entities/category/income_category.dart';
import '../../../../../blocs/category/income_category_bloc.dart';
import '../../../../../widgets/VwFilterTextField.dart';
import '../../../../../widgets/alert_card.dart';
import '../../../../../widgets/income_category/income_category_item_card.dart';

class IncomeCategoryBottomSheet extends StatefulWidget {
  final IncomeCategory incomeCategory;
  final ValueChanged<IncomeCategory>? onCategorySelected;

  const IncomeCategoryBottomSheet({
    Key? key,
    required this.incomeCategory,
    this.onCategorySelected,
  }) : super(key: key);

  @override
  _IncomeCategoryBottomSheetState createState() => _IncomeCategoryBottomSheetState();
}

  class _IncomeCategoryBottomSheetState extends State<IncomeCategoryBottomSheet> {
  final GlobalKey<AnimatedListState> _listKey =
  GlobalKey<AnimatedListState>();
  final List<IncomeCategory> _subCategories = [];
  final TextEditingController _filterController = TextEditingController();
  late IncomeCategory selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.incomeCategory;
    _fetchIncomeCategories();
  }

  void _fetchIncomeCategories() {
    context.read<IncomeCategoryBloc>().add(GetIncomeCategories());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<IncomeCategoryBloc, IncomeCategoryState>(
      listener: (context, state) {
        if (state is IncomeCategoryLoaded) {
          _setCategories(state);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              Center(
                child: Container(
                  width: 75,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: VwSearchTextField(
                      controller: _filterController,
                      showClearButton: false,
                      hintText: "Search Accounts...",
                      onChanged: (val) {
                        context.read<IncomeCategoryBloc>().add(FilterCategories(val));
                      },
                      onSubmitted: (val) {
                        context.read<IncomeCategoryBloc>().add(FilterCategories(val));
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const Divider(color: Colors.grey),
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [_buildIncomeCategoryContent()],
              ), // Display the custom content here
            ],
          ),
        ),
      ),
    );
  }

  void _setCategories(IncomeCategoryLoaded state) {
    setState(() {
      _subCategories.clear();
      _subCategories.addAll(state.data);
    }
    );
  }

  Widget _buildIncomeCategoryContent() {
    if (
    _subCategories.isEmpty) {
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
                if (index >= _subCategories.length) {
                  // Prevent accessing out-of-bound indexes
                  return const SizedBox.shrink();
                }
                final incomeCategory = _subCategories[index];
                return _buildIncomeCategoryItemCard(
                  context,
                  incomeCategory,
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

  Widget _buildIncomeCategoryItemCard(
      BuildContext context,
      IncomeCategory incomeCategory,
      int index,
      Animation<double> animation,
      ) {
    return SizeTransition(
      sizeFactor: animation,
      child: IncomeCategoryItemCard(
        subCategory: incomeCategory,
        index: index,
        onTap: () {
          widget.onCategorySelected?.call(incomeCategory);
        },
        onAnimationEnd: () {
          setState(() {
            _subCategories[index] = _subCategories[index].copyWith(isUpdated: false);
          }
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return const AlertCard(
      image: kEmpty,
      message: "No categories found!",
    );
  }
}
