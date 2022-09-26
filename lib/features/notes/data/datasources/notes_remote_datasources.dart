import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';
import '../../../../utils/app_utils.dart';
import '../model/notes_model.dart';
import '../model/users_model.dart';

abstract class NotesRemoteDataSources {
  Future<List<NotesModel>> getAllNotes();
  Future<List<UsersModel>> getAllUser();
  Future<Unit> updateNote({required NotesModel note});
}

class NotesRemoteDataSourcesImpl implements NotesRemoteDataSources {
  final DioHelper dioHelper;

  NotesRemoteDataSourcesImpl({required this.dioHelper});

  @override
  Future<List<NotesModel>> getAllNotes() async {
    try {
      final Response response = await dioHelper.generalGet(
        EndPoints.GET_ALL_NOTES,
      );
      final data = response.data as List;
      final notes = data.map((e) => NotesModel.fromMap(e)).toList();
      return Future.value(notes);
    } on DioError catch (e) {
      throw AppUtils.handleDioError(e);
    }
  }

  @override
  Future<Unit> updateNote({required NotesModel note}) async {
    try {
      await dioHelper.generalPost(EndPoints.UPDATE_NOTE, {
        "Id": note.id,
        "Text": note.text,
        "UserId": note.userId,
        "PlaceDateTime": note.placeDateTime
      });
      return Future.value(unit);
    } on DioError catch (e) {
      throw AppUtils.handleDioError(e);
    }
  }

  @override
  Future<List<UsersModel>> getAllUser() async {
    try {
      final Response response = await dioHelper.generalGet(
        EndPoints.GET_ALL_USERS,
      );
      final data = response.data as List;
      final users = data.map((e) => UsersModel.fromMap(e)).toList();
      return Future.value(users);
    } on DioError catch (e) {
      throw AppUtils.handleDioError(e);
    }
  }
}
