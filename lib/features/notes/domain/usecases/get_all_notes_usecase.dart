
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/notes_model.dart';
import '../repositories/notes_repo.dart';

class GetAllNotesUsecase{
  final NotesRepo notesRepo;

  GetAllNotesUsecase({required this.notesRepo});
  Future<Either<Failure, List<NotesModel>>> getAllNotes()async{
    return await notesRepo.getAllNotes();
  }

}