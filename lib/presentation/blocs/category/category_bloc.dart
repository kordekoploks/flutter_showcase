import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eshop/data/models/category/outcome_category_model.dart';
import 'package:eshop/domain/usecases/outcome_category/add_category_usecase.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/entities/category/outcome_category.dart';
import '../../../domain/usecases/outcome_category/filter_category_usecase.dart';
import '../../../domain/usecases/outcome_category/get_cached_category_usecase.dart';
import '../../../domain/usecases/outcome_category/update_category_usecase.dart';
import '../../../domain/usecases/outcome_category/delete_category_usecase.dart';

part 'category_event.dart';

part 'category_state.dart';

class OutcomeCategoryBloc
    extends Bloc<OutcomeCategoryEvent, OutcomeCategoryState> {
  final GetCachedCategoryUseCase _getCashedCategoryUseCase;
  final FilterCategoryUseCase _filterCategoryUseCase;
  final AddCategoryUseCase _addCategoryUseCase;
  final UpdateCategoryUseCase _updateCategoryUseCase;
  final DeleteCategoryUseCase _deleteCategoryUseCase;

  OutcomeCategoryBloc(
      this._getCashedCategoryUseCase,
      this._filterCategoryUseCase,
      this._addCategoryUseCase,
      this._updateCategoryUseCase,
      this._deleteCategoryUseCase)
      : super(const OutcomeCategoryLoading(data: [])) {
    on<GetCategories>(_onLoadCategories);
    on<FilterCategories>(_onFilterCategories);
    on<AddCategory>(_onAddCategory);
    on<UpdateCategory>(_onUpdateCategory);
    on<DeleteCategory>(_onDeleteCategory);
  }

  void _onLoadCategories(
      GetCategories event, Emitter<OutcomeCategoryState> emit) async {
    try {
      emit(const OutcomeCategoryLoading(data: []));
      final cashedResult = await _getCashedCategoryUseCase(NoParams());
      cashedResult.fold(
        (failure) =>
            (emit(OutcomeCateogryError(data: state.data, failure: failure))),
        (categories) {
          if (categories.isEmpty) {
            emit(OutcomeCategoryEmpty(
              data: categories,
            ));
          } else {
            emit(OutcomeCategoryLoaded(
              data: categories,
            ));
          }
        },
      );
    } catch (e) {
      EasyLoading.showError(e.toString());
      emit(OutcomeCateogryError(
        data: state.data,
        failure: ExceptionFailure(),
      ));
    }
  }

  void _onFilterCategories(
      FilterCategories event, Emitter<OutcomeCategoryState> emit) async {
    try {
      ///Initial Category loading with minimal loading animation
      ///
      ///Cashed category
      emit(OutcomeCategoryLoading(data: state.data));
      final cashedResult = await _filterCategoryUseCase(event.keyword);
      cashedResult.fold(
          (failure) => emit(OutcomeCateogryError(
                data: state.data,
                failure: failure,
              )), (categories) {
        if (categories.isEmpty) {
          emit(OutcomeCategoryEmpty(
            data: categories,
          ));
        } else {
          emit(OutcomeCategoryLoaded(
            data: categories,
          ));
        }
      });
    } catch (e) {
      emit(OutcomeCateogryError(
        data: state.data,
        failure: ExceptionFailure(),
      ));
    }
  }

  void _onAddCategory(
      AddCategory event, Emitter<OutcomeCategoryState> emit) async {
    try {
      emit(OutcomeCategoryLoading(data: state.data));
      final cashedResult = await _addCategoryUseCase(event._categoryModel);
      cashedResult.fold(
        (failure) => emit(OutcomeCateogryError(
          data: state.data,
          failure: failure,
        )
        ),
        (newData) {
          // Add the newly created subcategory to the existing list
          final updatedData = List<OutcomeCategory>.from(state.data)
            ..add(newData);

          emit(OutcomeCategoryAdded(dataAdded: newData, data: updatedData));
        },
      );
    } catch (e) {
      emit(OutcomeCateogryError(
        data: state.data,
        failure: ExceptionFailure(),
      )
      );
    }
  }

  void _onUpdateCategory(
      UpdateCategory event, Emitter<OutcomeCategoryState> emit) async {
    try {
      emit(OutcomeCategoryUpdating(
          dataUpdating: event._categoryModel, data: state.data));
      final updatedResult = await _updateCategoryUseCase(event._categoryModel);

      updatedResult.fold(
          (failure) => emit(OutcomeCateogryError(
                data: state.data,
                failure: failure,
              )), (updatedCategory) {
        final index = state.data
            .indexWhere((category) => category.id == updatedCategory.id);

        // If found, update the list with the new data
        if (index != -1) {
          final updatedData = List<OutcomeCategory>.from(state.data);
          updatedData[index] = updatedCategory;

          // Emit the updated state
          emit(OutcomeCategoryUpdated(
            dataUpdated: updatedCategory,
            data: updatedData,
          ));
        } else {
          // If not found, just emit the updated state without modifying the list
          emit(OutcomeCategoryUpdated(
            dataUpdated: updatedCategory,
            data: state.data,
          ));
        }
        ;
      });
    } catch (e) {
      emit(OutcomeCateogryError(
        data: state.data,
        failure: ExceptionFailure(),
      ));
    }
  }

  void _onDeleteCategory(
      DeleteCategory event, Emitter<OutcomeCategoryState> emit) async {
    try {
      emit(OutcomeCategoryLoading(data: state.data));
      final cashedResult = await _deleteCategoryUseCase(event._categoryModel);
      cashedResult.fold(
          (failure) => emit(OutcomeCateogryError(
                data: state.data,
                failure: failure,
              )), (categories) {
        final updatedData = List<OutcomeCategory>.from(state.data)
          ..removeWhere((category) => category.id == event._categoryModel.id);

        emit(OutcomeCategoryDeleted(
          dataDeleted: categories,
          data: updatedData,
        ));
        if(updatedData.isEmpty){
          emit(OutcomeCategoryEmpty(
            data: updatedData
          ));
        }
      });
    } catch (e) {
      emit(OutcomeCateogryError(
        data: state.data,
        failure: ExceptionFailure(),
      ));
    }
  }

}
