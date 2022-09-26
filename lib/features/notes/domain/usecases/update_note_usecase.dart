
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/notes_model.dart';
import '../repositories/notes_repo.dart';

class UpdateNoteUsecase{
  final NotesRepo notesRepo;

  UpdateNoteUsecase({required this.notesRepo});
  Future<Either<Failure, Unit>> updateNote({required NotesModel notesModel})async{
    return await notesRepo.updateNote(note: notesModel);
  }
}