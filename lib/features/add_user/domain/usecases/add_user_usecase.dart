import 'package:dartz/dartz.dart';
import '../repositories/add_user_repo.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/add_user_model.dart';

class AddUserUsecase {
  final AddUserRepo addUserRepo;

  AddUserUsecase({required this.addUserRepo});

  Future<Either<Failure, Unit>> addUser(
      {required AddUserModel addUserModel}) async {
    return addUserRepo.addUser(addUserModel: addUserModel);
  }

}
