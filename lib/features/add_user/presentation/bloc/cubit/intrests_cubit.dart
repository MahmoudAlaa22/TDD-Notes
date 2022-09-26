import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../utils/app_utils.dart';
import '../../../data/model/intrest_model.dart';
import '../../../domain/usecases/get_all_intrests.dart';

part 'intrests_state.dart';

class IntrestsCubit extends Cubit<IntrestsState> {
  final GetAllIntrestsUsecase getAllIntrestsUsecase;
  IntrestsCubit({required this.getAllIntrestsUsecase})
      : super(IntrestsInitial());
  static IntrestsCubit get(BuildContext context) => BlocProvider.of(context);
  List<IntrestModel>? intrests;
  IntrestModel? intrest;
  Future<void> getAllIntrests() async {
    try {
      emit(IntrestsLoadingState());
      final failureOrDone = await getAllIntrestsUsecase.getAllIntrests();
      emit(_mapFailuerOrDoneMessage(either: failureOrDone));
    } catch (e) {
      final failure = AppUtils.buildFailure(e);
      emit(IntrestsErreState(message: AppUtils.buildErrorMsg(failure)));
    }
  }

  void onChangeIntrests(IntrestModel v) {
    emit(IntrestsInitial());
    intrest = v;
    emit(IntrestsOnChange());
  }

  IntrestsState _mapFailuerOrDoneMessage({
    required Either<Failure, List<IntrestModel>> either,
  }) {
    return either.fold(
      (failure) => IntrestsErreState(message: AppUtils.buildErrorMsg(failure)),
      (intrests) {
        this.intrests = intrests;
        return IntrestsSuccessState(intrests: intrests);
      },
    );
  }
}
