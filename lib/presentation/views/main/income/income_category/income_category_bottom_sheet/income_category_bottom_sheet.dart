import 'package:eshop/presentation/blocs/category/outcome_category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Models & Entities
// Utilities & Constants
import '../../../../../../core/constant/images.dart';
import '../../../../../../domain/entities/category/income_category.dart';
import '../../../../../blocs/category/income_category_bloc.dart';
import '../../../../../widgets/alert_card.dart';

class IncomeCategoryBottomSheet extends StatefulWidget {
  final Function(IncomeCategory) onCategorySelected;

  const IncomeCategoryBottomSheet({Key? key, required this.onCategorySelected}) : super(key: key);

  @override
  _IncomeCategoryBottomSheetState createState() => _IncomeCategoryBottomSheetState();
}

class _IncomeCategoryBottomSheetState extends State<IncomeCategoryBottomSheet> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<IncomeCategory> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchOutcomeCategories();
  }

  void _fetchOutcomeCategories() {
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
      child: Container(
        height: 400, // Adjust as needed
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select a Category",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(child: _buildCategoryList()),
          ],
        ),
      ),
    );
  }

  void _setCategories(IncomeCategoryLoaded state) {
    setState(() {
      _categories.clear();
      _categories.addAll(state.data);
    });
  }

  Widget _buildCategoryList() {
    if (_categories.isEmpty) {
      return _buildEmptyState();
    } else {
      return ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_categories[index].name),
            onTap: () {
              widget.onCategorySelected(_categories[index]);
              Navigator.pop(context); // Close the bottom sheet
            },
          );
        },
      );
    }
  }

  Widget _buildEmptyState() {
    return const AlertCard(
      image: kEmpty,
      message: "No categories found!",
    );
  }
}
