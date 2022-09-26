import 'dart:developer';

import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../datasources/notes_local_datasources.dart';
import '../../../setting/data/datasources/setting_local_datasources.dart';
import '../../../setting/presentation/bloc/cubit/setting_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/network/network_info.dart';
import '../model/notes_model.dart';

import '../../../../core/error/failures.dart';

import 'package:dartz/dartz.dart';
import '../model/users_model.dart';

import '../../../../utils/app_utils.dart';
import '../../domain/repositories/notes_repo.dart';
import '../datasources/notes_remote_datasources.dart';

class NotesRepoImpl implements NotesRepo {
  final NotesRemoteDataSources notesRemoteDataSources;
  final NotesLocalDatasources notesLocalDatasources;
  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;

  NotesRepoImpl(
      {required this.notesRemoteDataSources,
      required this.notesLocalDatasources,
      required this.networkInfo,
      required this.sharedPreferences});

  @override
  Future<Either<Failure, List<NotesModel>>> getAllNotes() async {
    if (await networkInfo.isConnected) {
      try {
        final failureOrDone = await notesRemoteDataSources.getAllNotes();
        await notesLocalDatasources.cachedNotes(notes: failureOrDone);
        return Right(failureOrDone);
      } on DioError catch (e) {
        return Left(AppUtils.buildFailure(e));
      }
    } else {
      try {
        final useDatabasState =
            sharedPreferences.getBool(CACHED_DATABASE_STATE);
        if (useDatabasState!) {
          final failureOrDone = await notesLocalDatasources.getCachedNotes();
          return Right(failureOrDone);
        } else {
          return Left(UnknownFailure());
        }
      } on DioError catch (e) {
        return Left(AppUtils.buildFailure(e));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updateNote({required NotesModel note}) async {
    await notesRemoteDataSources.updateNote(note: note);
    try {
      return const Right(unit);
    } on DioError catch (e) {
      return Left(AppUtils.buildFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<UsersModel>>> getAllUser() async {
    if (await networkInfo.isConnected) {
      try {
        final failureOrDone = await notesRemoteDataSources.getAllUser();
        await notesLocalDatasources.cachedUsers(users: failureOrDone);
        return Right(failureOrDone);
      } on DioError catch (e) {
        return Left(AppUtils.buildFailure(e));
      }
    } else {
      try {
        final useDatabasState =
            sharedPreferences.getBool(CACHED_DATABASE_STATE);
        if (useDatabasState!) {
          final failureOrDone = await notesLocalDatasources.getCachedUser();
          return Right(failureOrDone);
        } else {
          return Left(UnknownFailure());
        }
      } on DioError catch (e) {
        return Left(AppUtils.buildFailure(e));
      }
    }
  }
}
