import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../utils/app_utils.dart';
import '../../../domain/usecases/setting_usecase.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  final SettingUsecase settingUsecase;
  SettingCubit({required this.settingUsecase}) : super(SettingInitial());
  static SettingCubit get(BuildContext context) => BlocProvider.of(context);
  bool useDatabaseState = false;

  Future<void> getUseDatabaseState() async {
    try {
      emit(SettingLoadingState());
      final either = await settingUsecase.getUseLocalDatabaseState();
      emit(_mapFailuerOrDoneMessage(either: either));
    } catch (e) {
      final failure = AppUtils.buildFailure(e);
      emit(SettingErrorState(message: AppUtils.buildErrorMsg(failure)));
    }
  }

  Future<void> changeUserDatabaseState(bool v) async {
    emit(SettingLoadingState());
    useDatabaseState = v;
    emit(SettingChangeSwitchState());
    await settingUsecase.setUseLocalDatabaseState(state: useDatabaseState);
  }

  SettingState _mapFailuerOrDoneMessage({
    required Either<Failure, bool> either,
  }) {
    return either.fold(
      (failure) => SettingErrorState(message: AppUtils.buildErrorMsg(failure)),
      (state) {
        useDatabaseState = state;
        return SettingSuccessState();
      },
    );
  }
}
