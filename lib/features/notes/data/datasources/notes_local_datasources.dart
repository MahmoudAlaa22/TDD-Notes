import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../model/notes_model.dart';
import '../model/users_model.dart';

abstract class NotesLocalDatasources {
  Future<List<NotesModel>> getCachedNotes();
  Future<Unit> cachedNotes({required List<NotesModel> notes});
  Future<List<UsersModel>> getCachedUser();
  Future<Unit> cachedUsers({required List<UsersModel> users});
}

const CACHED_NOTES = 'CACHED_NOTES';
const CACHED_USERS = 'CACHED_USERS';

class NotesLocalDatasourcesImpl implements NotesLocalDatasources {
  final SharedPreferences sharedPreferences;

  NotesLocalDatasourcesImpl({required this.sharedPreferences});
  @override
  Future<List<NotesModel>> getCachedNotes() async {
    final jsonToString = sharedPreferences.getString(CACHED_NOTES);

    if (jsonToString != null) {
      List decodeJsonData = json.decode(jsonToString);

      List<NotesModel> jsonToData =
          decodeJsonData.map<NotesModel>((e) => NotesModel.fromMap(e)).toList();

      return Future.value(jsonToData);
    } else {
      throw EmptyCachException();
    }
  }

  @override
  Future<List<UsersModel>> getCachedUser() {
    final jsonToString = sharedPreferences.getString(CACHED_USERS);
    if (jsonToString != null) {
      List decodeJsonData = json.decode(jsonToString);
      List<UsersModel> jsonToData =
          decodeJsonData.map<UsersModel>((e) => UsersModel.fromMap(e)).toList();

      return Future.value(jsonToData);
    } else {
      throw EmptyCachException();
    }
  }

  @override
  Future<Unit> cachedNotes({required List<NotesModel> notes}) {
    final notesModelToJson =
        notes.map<Map<String, dynamic>>((e) => e.toMap()).toList();
    sharedPreferences.setString(CACHED_NOTES, json.encode(notesModelToJson));
    return Future.value(unit);
  }

  @override
  Future<Unit> cachedUsers({required List<UsersModel> users}) {
    final usersModelToJson =
        users.map<Map<String, dynamic>>((e) => e.toMap()).toList();

    sharedPreferences.setString(CACHED_USERS, json.encode(usersModelToJson));
    return Future.value(unit);
  }
}
