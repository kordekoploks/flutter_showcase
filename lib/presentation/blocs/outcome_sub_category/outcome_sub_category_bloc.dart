import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eshop/domain/usecases/outcome_sub_category/add_outcome_sub_category_usecase.dart';
import 'package:eshop/domain/usecases/outcome_sub_category/delete_outcome_sub_category_usecase.dart';
import 'package:eshop/domain/usecases/outcome_sub_category/get_cached_outcome_sub_category_usecase.dart';
import 'package:eshop/domain/usecases/outcome_sub_category/update_outcome_sub_category_usecase.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/error/failures.dart';
import '../../../data/models/category/outcome_sub_category_model.dart';
import '../../../domain/entities/category/outcome_category.dart';
import '../../../domain/entities/category/outcome_sub_category.dart';
import '../../../domain/usecases/outcome_category/filter_category_usecase.dart';

part 'outcome_sub_category_state.dart';

part 'outcome_sub_category_event.dart';

class OutcomeSubCategoryBloc
    extends Bloc<OutcomeSubCategoryEvent, OutcomeSubCategoryState> {
  final GetCachedOutcomeSubCategoryUseCase _getCashedCategoryUseCase;
  final FilterCategoryUseCase _filterCategoryUseCase;
  final AddOutcomeSubCategoryUseCase _addCategoryUseCase;
  final UpdateOutcomeSubCategoryUseCase _updateCategoryUseCase;
  final DeleteOutcomeSubCategoryUseCase _deleteCategoryUseCase;
  late List<OutcomeSubCategory> outcomeCategoryList;

  OutcomeSubCategoryBloc(
      this._getCashedCategoryUseCase,
      this._filterCategoryUseCase,
      this._addCategoryUseCase,
      this._updateCategoryUseCase,
      this._deleteCategoryUseCase)
      : super(const OutcomeSubCategoryLoading(data: [])) {
    on<GetSubCategories>(_onLoadCategories);
    on<FilterCategories>(_onFilterCategories);
    on<AddSubCategory>(_onAddCategory);
    on<UpdateSubCategory>(_onUpdateCategory);
    on<DeleteSubCategory>(_onDeleteCategory);
  }

  void _onLoadCategories(
      GetSubCategories event, Emitter<OutcomeSubCategoryState> emit) async {
    try {
      emit(const OutcomeSubCategoryLoading(data: []));
      final cashedResult = await _getCashedCategoryUseCase(event._data.id);
      cashedResult.fold(
        (failure) => (emit(OutcomeSubCategoryError(
          data: state.data,
          failure: failure,
        ))),
        (data) {
          outcomeCategoryList = data;
          if (data.isEmpty) {
            emit(OutcomeSubCategoryEmpty(
              data: data,
            ));
          }
          else{
          emit(OutcomeSubCategoryLoaded(
            data: outcomeCategoryList,
          ));
          }
        },
      );

      ///Check remote data source to find categories
      ///Method will find and update if there any new category update from server
      ///Remote Category
    } catch (e) {
      EasyLoading.showError(e.toString());
      emit(OutcomeSubCategoryError(
        data: state.data,
        failure: ExceptionFailure(),
      ));
    }
  }

  void _onFilterCategories(
      FilterCategories event, Emitter<OutcomeSubCategoryState> emit) async {
    try {
      ///Initial Category loading with minimal loading animation
      ///
      ///Cashed category
      emit(OutcomeSubCategoryLoading(data: state.data));
      final cashedResult = await _filterCategoryUseCase(event.keyword);
      cashedResult.fold(
        (failure) => emit(OutcomeSubCategoryError(
          data: state.data,
          failure: failure,
        )),
        (categories) {
           if(categories.isEmpty) {
             emit(OutcomeSubCategoryEmpty(
               data: state.data,
             ));

           }
           else{
             emit(OutcomeSubCategoryLoaded(
               data: state.data,
             ));

           }
          }
      );
    } catch (e) {
      emit(OutcomeSubCategoryError(
        data: state.data,
        failure: ExceptionFailure(),
      ));
    }
  }

  void _onAddCategory(AddSubCategory event, Emitter<OutcomeSubCategoryState> emit) async {
    try {
      emit(OutcomeSubCategoryLoading(data: state.data));

      // Perform the addition operation
      final addResult = await _addCategoryUseCase(event._params);

      addResult.fold(
            (failure) => emit(OutcomeSubCategoryError(
          data: state.data,
          failure: failure,
        )),
            (newSubCategory) {
          // Add the newly created subcategory to the existing list
          final updatedData = List<OutcomeSubCategory>.from(state.data)
            ..add(newSubCategory);

          // Emit the updated state with the new subcategory added
          emit(OutcomeSubCategoryAdded(
            dataAdded: newSubCategory,
            data: updatedData,
          ));
        },
      );
    } catch (e) {
      emit(OutcomeSubCategoryError(
        data: state.data,
        failure: ExceptionFailure(),
      ));
    }
  }
  void _onUpdateCategory(
      UpdateSubCategory event, Emitter<OutcomeSubCategoryState> emit) async {
    try {
      emit(OutcomeSubCategoryLoading(data: state.data));

      // Perform the update operation
      final updatedResult = await _updateCategoryUseCase(event._params);

      updatedResult.fold(
            (failure) => emit(OutcomeSubCategoryError(
          data: state.data,
          failure: failure,
        )),
            (updatedCategory) {
          // Find the index of the updated category
          final index = state.data.indexWhere((category) => category.id == updatedCategory.id);

          // If found, update the list with the new data
          if (index != -1) {
            final updatedData = List<OutcomeSubCategory>.from(state.data);
            updatedData[index] = updatedCategory;

            // Emit the updated state
            emit(OutcomeSubCategoryUpdated(
              dataUpdated: updatedCategory,
              data: updatedData,
            ));
          } else {
            // If not found, just emit the updated state without modifying the list
            emit(OutcomeSubCategoryUpdated(
              dataUpdated: updatedCategory,
              data: state.data,
            ));
          }
        },
      );
    } catch (e) {
      emit(OutcomeSubCategoryError(
        data: state.data,
        failure: ExceptionFailure(),
      ));
    }
  }


  void _onDeleteCategory(
      DeleteSubCategory event, Emitter<OutcomeSubCategoryState> emit) async {
    try {
      emit(OutcomeSubCategoryLoading(data: state.data));

      // Perform the delete operation
      final deleteResult = await _deleteCategoryUseCase(event._data);

      deleteResult.fold(
            (failure) => emit(OutcomeSubCategoryError(
          data: state.data,
          failure: failure,
        )),
            (success) {
          // Remove the deleted category from the list
          final updatedData = List<OutcomeSubCategory>.from(state.data)
            ..removeWhere((category) => category.id == event._data.id);

          // Emit the updated state with the remaining subcategories
          emit(OutcomeSubCategoryDeleted(
            data: updatedData,
            dataDeleted: success
          ));

          if(updatedData.isEmpty){
            emit(OutcomeSubCategoryEmpty(
                data: updatedData
            ));
          }
        },
      );
    } catch (e) {
      emit(OutcomeSubCategoryError(
        data: state.data,
        failure: ExceptionFailure(),
      ));
    }
  }

}
