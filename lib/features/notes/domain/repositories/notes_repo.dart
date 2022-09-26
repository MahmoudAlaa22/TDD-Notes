import '../../data/model/notes_model.dart';

import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../data/model/users_model.dart';

abstract class NotesRepo{
  Future<Either<Failure, List<NotesModel>>> getAllNotes();
  Future<Either<Failure, Unit>> updateNote({required NotesModel note});
  Future<Either<Failure, List<UsersModel>>> getAllUser();
  
}