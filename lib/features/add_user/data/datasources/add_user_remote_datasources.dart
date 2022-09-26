import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';
import '../../../../utils/app_utils.dart';
import '../model/add_user_model.dart';
import '../model/intrest_model.dart';

abstract class AddUserRemoteDataSources {
  Future<Unit> addUser({required AddUserModel addUserModel});
  Future<List<IntrestModel>> getAllIntrests();
}

class AddUserRemoteDataSourcesImpl implements AddUserRemoteDataSources {
  final DioHelper dioHelper;

  AddUserRemoteDataSourcesImpl({required this.dioHelper});

  @override
  Future<Unit> addUser({required AddUserModel addUserModel}) async {
    try {
      await dioHelper.generalPost(EndPoints.INSERT_USER, addUserModel.toMap());
      return Future.value(unit);
    } on DioError catch (e) {
      throw AppUtils.handleDioError(e);
    }
  }

  @override
  Future<List<IntrestModel>> getAllIntrests() async {
    try {
      final Response response =
          await dioHelper.generalGet(EndPoints.GET_ALL_INTERESTS);
      final data = response.data as List;
      final intrests = data.map((e) => IntrestModel.fromMap(e)).toList();
      return Future.value(intrests);
    } on DioError catch (e) {
      throw AppUtils.handleDioError(e);
    }
  }
}
