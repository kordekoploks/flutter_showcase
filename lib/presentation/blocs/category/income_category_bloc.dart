import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../data/models/category/income_category_model.dart';
import '../../../domain/entities/category/income_category.dart';
import '../../../domain/usecases/income/get_cached_income_category_usecase.dart';
import '../../../domain/usecases/income/income_category/add_income_category_usecase.dart';
import '../../../domain/usecases/income/income_category/delete_income_category_usecase.dart';
import '../../../domain/usecases/income/income_category/filter_income_category_usecase.dart';
import '../../../domain/usecases/income/income_category/update_income_category_usecase.dart';


part 'income_category_event.dart';

part 'income_category_state.dart';

class IncomeCategoryBloc
    extends Bloc<IncomeCategoryEvent, IncomeCategoryState> {
  final GetCachedIncomeCategoryUseCase _getCashedIncomeCategoryUseCase;
  final FilterIncomeCategoryUseCase _filterIncomeCategoryUseCase;
  final AddIncomeCategoryUseCase _addIncomeCategoryUseCase;
  final UpdateIncomeCategoryUseCase _updateIncomeCategoryUseCase;
  final DeleteIncomeCategoryUseCase _deleteIncomeCategoryUseCase;

  IncomeCategoryBloc(
      this._getCashedIncomeCategoryUseCase,
      this._filterIncomeCategoryUseCase,
      this._addIncomeCategoryUseCase,
      this._updateIncomeCategoryUseCase,
      this._deleteIncomeCategoryUseCase)
      : super(const IncomeCategoryLoading(data: [])) {
    on<GetIncomeCategories>(_onLoadCategories);
    on<FilterCategories>(_onFilterCategories);
    on<AddCategory>(_onAddCategory);
    on<UpdateCategory>(_onUpdateCategory);
    on<DeleteCategory>(_onDeleteCategory);
  }

  void _onLoadCategories(
      GetIncomeCategories event, Emitter<IncomeCategoryState> emit) async {
    try {
      emit(const IncomeCategoryLoading(data: []));
      final cashedResult = await _getCashedIncomeCategoryUseCase(NoParams());
      cashedResult.fold(
            (failure) =>
        (emit(IncomeCateogryError(data: state.data, failure: failure))),
            (categories) {
          if (categories.isEmpty) {
            emit(IncomeCategoryEmpty(
              data: categories,
            ));
          } else {
            emit(IncomeCategoryLoaded(
              data: categories,
            ));
          }
        },
      );
    } catch (e) {
      EasyLoading.showError(e.toString());
      emit(IncomeCateogryError(
        data: state.data,
        failure: ExceptionFailure(),
      ));
    }
  }

  void _onFilterCategories(
      FilterCategories event, Emitter<IncomeCategoryState> emit) async {
    try {
      ///Initial Category loading with minimal loading animation
      ///
      ///Cashed category
      emit(IncomeCategoryLoading(data: state.data));
      final cashedResult = await _filterIncomeCategoryUseCase(event.keyword);
      cashedResult.fold(
              (failure) => emit(IncomeCateogryError(
            data: state.data,
            failure: failure,
          )), (categories) {
        if (categories.isEmpty) {
          emit(IncomeCategoryEmpty(
            data: categories,
          ));
        } else {
          emit(IncomeCategoryLoaded(
            data: categories,
          ));
        }
      });
    } catch (e) {
      emit(IncomeCateogryError(
        data: state.data,
        failure: ExceptionFailure(),
      ));
    }
  }

  void _onAddCategory(
      AddCategory event, Emitter<IncomeCategoryState> emit) async {
    try {
      emit(IncomeCategoryLoading(data: state.data));
      final cashedResult = await _addIncomeCategoryUseCase(event._categoryModel);
      cashedResult.fold(
            (failure) => emit(IncomeCateogryError(
          data: state.data,
          failure: failure,
        )
        ),
            (newData) {
          // Add the newly created subcategory to the existing list
          final updatedData = List<IncomeCategory>.from(state.data)
            ..add(newData);

          emit(IncomeCategoryAdded(dataAdded: newData, data: updatedData));
        },
      );
    } catch (e) {
      emit(IncomeCateogryError(
        data: state.data,
        failure: ExceptionFailure(),
      )
      );
    }
  }

  void _onUpdateCategory(
      UpdateCategory event, Emitter<IncomeCategoryState> emit) async {
    try {
      emit(IncomeCategoryUpdating(
          dataUpdating: event._categoryModel, data: state.data));
      final updatedResult = await _updateIncomeCategoryUseCase(event._categoryModel);

      updatedResult.fold(
              (failure) => emit(IncomeCateogryError(
            data: state.data,
            failure: failure,
          )), (updatedCategory) {
        final index = state.data
            .indexWhere((category) => category.id == updatedCategory.id);

        // If found, update the list with the new data
        if (index != -1) {
          final updatedData = List<IncomeCategory>.from(state.data);
          updatedData[index] = updatedCategory;

          // Emit the updated state
          emit(IncomeCategoryUpdated(
            dataUpdated: updatedCategory,
            data: updatedData,
          ));
        } else {
          // If not found, just emit the updated state without modifying the list
          emit(IncomeCategoryUpdated(
            dataUpdated: updatedCategory,
            data: state.data,
          ));
        }
        ;
      });
    } catch (e) {
      emit(IncomeCateogryError(
        data: state.data,
        failure: ExceptionFailure(),
      ));
    }
  }

  void _onDeleteCategory(
      DeleteCategory event, Emitter<IncomeCategoryState> emit) async {
    try {
      emit(IncomeCategoryLoading(data: state.data));
      final cashedResult = await _deleteIncomeCategoryUseCase(event._categoryModel);
      cashedResult.fold(
              (failure) => emit(IncomeCateogryError(
            data: state.data,
            failure: failure,
          )), (categories) {
        final updatedData = List<IncomeCategory>.from(state.data)
          ..removeWhere((category) => category.id == event._categoryModel.id);

        emit(IncomeCategoryDeleted(
          dataDeleted: categories,
          data: updatedData,
        ));
        if(updatedData.isEmpty){
          emit(IncomeCategoryEmpty(
              data: updatedData
          ));
        }
      });
    } catch (e) {
      emit(IncomeCateogryError(
        data: state.data,
        failure: ExceptionFailure(),
      ));
    }
  }

}
