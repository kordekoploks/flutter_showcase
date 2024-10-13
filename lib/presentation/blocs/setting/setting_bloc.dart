import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eshop/domain/usecases/setting/save_setting_usecase.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../data/models/setting/setting_model.dart';
import '../../../domain/entities/setting/setting.dart';
import '../../../domain/usecases/setting/get_cached_setting_usecase.dart';

part 'setting_event.dart';

part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final GetCachedSettingUseCase _getCachedSettingUseCase;
  final SaveSettingUseCase _saveSettingUseCase;

  SettingBloc(
    this._getCachedSettingUseCase,
    this._saveSettingUseCase,
  ) : super(SettingInitial())  {
    on<CheckSetting>(_onCheckSetting);
    on<SaveSetting>(_onSettingChange);
  }


  void _onCheckSetting(CheckSetting event, Emitter<SettingState> emit) async {
    try {
      emit(SettingLoading());
      final result = await _getCachedSettingUseCase(NoParams());
      result.fold(
        (failure) => emit(SettingAplliedFail(failure)),
        (setting) => emit(SettingApplied(setting)),
      );
    } catch (e) {
      emit(SettingAplliedFail(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSettingChange(SaveSetting event, Emitter<SettingState> emit) async {
    try {
      emit(SettingLoading());
      final result = await _saveSettingUseCase(event.params);
      result.fold(
        (failure) => emit(SettingAplliedFail(failure)),
        (setting) => emit(SettingApplied(setting)),
      );
    } catch (e) {
      emit(SettingAplliedFail(ExceptionFailure()));
    }
  }
}
