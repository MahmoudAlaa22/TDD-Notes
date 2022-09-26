import 'dart:developer';

import 'package:dio/dio.dart';
import '../model/add_user_model.dart';

import '../../../../core/error/failures.dart';

import 'package:dartz/dartz.dart';
import '../model/intrest_model.dart';

import '../../../../core/network/network_info.dart';
import '../../../../utils/app_utils.dart';
import '../../domain/repositories/add_user_repo.dart';
import '../datasources/add_user_remote_datasources.dart';

class AddUserRepoImpl implements AddUserRepo {
  final AddUserRemoteDataSources addUserRemoteDataSources;
  final NetworkInfo networkInfo;
  AddUserRepoImpl(
      {required this.addUserRemoteDataSources, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> addUser(
      {required AddUserModel addUserModel}) async {
    try {
      final failureOrDone =
          await addUserRemoteDataSources.addUser(addUserModel: addUserModel);
      return Right(failureOrDone);
    } on DioError catch (e) {
      return Left(AppUtils.buildFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<IntrestModel>>> getAllIntrests() async {
    try {
      final failureOrDone = await addUserRemoteDataSources.getAllIntrests();
      return Right(failureOrDone);
    } on DioError catch (e) {
      return Left(AppUtils.buildFailure(e));
    }
  }
}
