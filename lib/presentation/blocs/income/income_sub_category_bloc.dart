import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/category/income_category.dart';
import '../../../domain/entities/category/income_sub_category.dart';
import '../../../domain/usecases/income/add_income_sub_category_usecase.dart';
import '../../../domain/usecases/income/delete_income_sub_category_usecase.dart';
import '../../../domain/usecases/income/filter_income_sub_category_usecase.dart';
import '../../../domain/usecases/income/get_cached_income_sub_category_usecase.dart';
import '../../../domain/usecases/income/update_income_sub_category_usecase.dart';

part 'income_sub_category_state.dart';

part 'income_sub_category_event.dart';

class IncomeSubCategoryBloc
    extends Bloc<IncomeSubCategoryEvent, IncomeSubCategoryState> {
  final GetCachedIncomeSubCategoryUseCase _getCashedIncomeSubCategoryUseCase;
  final FilterIncomeSubCategoryUseCase _filterIncomeSubCategoryUseCase;
  final AddIncomeSubCategoryUseCase _addIncomeSubCategoryUseCase;
  final UpdateIncomeSubCategoryUseCase _updateIncomeSubCategoryUseCase;
  final DeleteIncomeSubCategoryUseCase _deleteIncomeSubCategoryUseCase;
  late List<IncomeSubCategory> incomeCategoryList;

  IncomeSubCategoryBloc(
      this._getCashedIncomeSubCategoryUseCase,
      this._filterIncomeSubCategoryUseCase,
      this._addIncomeSubCategoryUseCase,
      this._updateIncomeSubCategoryUseCase,
      this._deleteIncomeSubCategoryUseCase)
      : super(const IncomeSubCategoryLoading(data: [])) {
    on<GetSubCategories>(_onLoadCategories);
    on<FilterCategories>(_onFilterCategories);
    on<AddSubCategory>(_onAddCategory);
    on<UpdateSubCategory>(_onUpdateCategory);
    on<DeleteSubCategory>(_onDeleteCategory);
  }

  void _onLoadCategories(
      GetSubCategories event, Emitter<IncomeSubCategoryState> emit) async {
    try {
      emit(const IncomeSubCategoryLoading(data: []));
      final cashedResult =
          await _getCashedIncomeSubCategoryUseCase(event._data.id);
      cashedResult.fold(
        (failure) => (emit(IncomeSubCategoryError(
          data: state.data,
          failure: failure,
        ))),
        (data) {
          incomeCategoryList = data;
          if (data.isEmpty) {
            emit(IncomeSubCategoryEmpty(
              data: data,
            ));
          } else {
            emit(IncomeSubCategoryLoaded(
              data: incomeCategoryList,
            ));
          }
        },
      );

      ///Check remote data source to find categories
      ///Method will find and update if there any new category update from server
      ///Remote Category
    } catch (e) {
      EasyLoading.showError(e.toString());
      emit(IncomeSubCategoryError(
        data: state.data,
        failure: ExceptionFailure(),
      ));
    }
  }

  void _onFilterCategories(
      FilterCategories event, Emitter<IncomeSubCategoryState> emit) async {
    try {
      ///Initial Category loading with minimal loading animation
      ///
      ///Cashed category
      emit(IncomeSubCategoryLoading(data: state.data));
      final cashedResult = await _filterIncomeSubCategoryUseCase(event.keyword);
      cashedResult.fold(
          (failure) => emit(IncomeSubCategoryError(
                data: state.data,
                failure: failure,
              )), (categories) {
        if (categories.isEmpty) {
          emit(IncomeSubCategoryEmpty(
            data: state.data,
          ));
        } else {
          emit(IncomeSubCategoryLoaded(
            data: state.data,
          ));
        }
      });
    } catch (e) {
      emit(IncomeSubCategoryError(
        data: state.data,
        failure: ExceptionFailure(),
      ));
    }
  }

  void _onAddCategory(
      AddSubCategory event, Emitter<IncomeSubCategoryState> emit) async {
    try {
      emit(IncomeSubCategoryLoading(data: state.data));

      // Perform the addition operation
      final addResult = await _addIncomeSubCategoryUseCase(event._params);

      addResult.fold(
        (failure) => emit(IncomeSubCategoryError(
          data: state.data,
          failure: failure,
        )),
        (newSubCategory) {
          // Add the newly created subcategory to the existing list
          final updatedData = List<IncomeSubCategory>.from(state.data)
            ..add(newSubCategory);

          // Emit the updated state with the new subcategory added
          emit(IncomeSubCategoryAdded(
            dataAdded: newSubCategory,
            data: updatedData,
          ));
        },
      );
    } catch (e) {
      emit(IncomeSubCategoryError(
        data: state.data,
        failure: ExceptionFailure(),
      ));
    }
  }

  void _onUpdateCategory(
      UpdateSubCategory event, Emitter<IncomeSubCategoryState> emit) async {
    try {
      emit(IncomeSubCategoryLoading(data: state.data));

      // Perform the update operation
      final updatedResult =
          await _updateIncomeSubCategoryUseCase(event._params);

      updatedResult.fold(
        (failure) => emit(IncomeSubCategoryError(
          data: state.data,
          failure: failure,
        )),
        (updatedCategory) {
          // Find the index of the updated category
          final index = state.data.indexWhere((category) => category.id == updatedCategory.id);

          // If found, update the list with the new data
          if (index != -1) {
            final updatedData = List<IncomeSubCategory>.from(state.data);
            updatedData[index] = updatedCategory;

            // Emit the updated state
            emit(IncomeSubCategoryUpdated(
              dataUpdated: updatedCategory,
              data: updatedData,
            ));
          } else {
            // If not found, just emit the updated state without modifying the list
            emit(IncomeSubCategoryUpdated(
              dataUpdated: updatedCategory,
              data: state.data,
            ));
          }
        },
      );
    } catch (e) {
      emit(IncomeSubCategoryError(
        data: state.data,
        failure: ExceptionFailure(),
      ));
    }
  }

  void _onDeleteCategory(
      DeleteSubCategory event, Emitter<IncomeSubCategoryState> emit) async {
    try {
      emit(IncomeSubCategoryLoading(data: state.data));

      // Perform the delete operation
      final deleteResult = await _deleteIncomeSubCategoryUseCase(event._data);

      deleteResult.fold(
        (failure) => emit(IncomeSubCategoryError(
          data: state.data,
          failure: failure,
        )),
        (success) {
          // Remove the deleted category from the list
          final updatedData = List<IncomeSubCategory>.from(state.data)
            ..removeWhere((category) => category.id == event._data.id);

          // Emit the updated state with the remaining subcategories
          emit(IncomeSubCategoryDeleted(
              data: updatedData, dataDeleted: success));

          if (updatedData.isEmpty) {
            emit(IncomeSubCategoryEmpty(data: updatedData));
          }
        },
      );
    } catch (e) {
      emit(IncomeSubCategoryError(
        data: state.data,
        failure: ExceptionFailure(),
      ));
    }
  }
}
