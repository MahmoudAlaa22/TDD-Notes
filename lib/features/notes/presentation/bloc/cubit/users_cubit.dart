import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../utils/app_utils.dart';
import '../../../data/model/users_model.dart';
import '../../../domain/usecases/get_all_uses.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final GetAllUsersUsecase getAllUsersUsecase;
  UsersCubit({required this.getAllUsersUsecase}) : super(UsersInitial());
List<UsersModel>? users;
    static UsersCubit get(BuildContext context)=> BlocProvider.of(context);  
  Future<void> getAllUsers()async{
    try{
      emit(UsersLoadingState());
      final failureOrDone = await getAllUsersUsecase.getAllUsers();
        emit(_mapFailuerOrDoneMessage(either: failureOrDone));
    }catch (e) {
      final failure = AppUtils.buildFailure(e);
      emit(UsersErrorState(message: AppUtils.buildErrorMsg(failure)));
    }
  }


UsersModel? getUserAssigned({required String id}){
   for(var e in users!){
    if(e.id==id)
    return e;
   }
   return null;
}

  UsersState _mapFailuerOrDoneMessage({
    required Either<Failure, List<UsersModel>> either,
  }) {
    return either.fold(
      (failure) => UsersErrorState(message: AppUtils.buildErrorMsg(failure)),
      (users) { 
        this.users=users;
       return UsersSuccessState(users: users);},
    );
  }
}
