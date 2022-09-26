
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/users_model.dart';
import '../repositories/notes_repo.dart';

class GetAllUsersUsecase{
  final NotesRepo notesRepo;

  GetAllUsersUsecase({required this.notesRepo});
    Future<Either<Failure, List<UsersModel>>> getAllUsers()async{
    return await notesRepo.getAllUser();
  }

}