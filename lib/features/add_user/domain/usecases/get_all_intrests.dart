import 'package:dartz/dartz.dart';
import '../repositories/add_user_repo.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/intrest_model.dart';

class GetAllIntrestsUsecase {
  final AddUserRepo addUserRepo;

  GetAllIntrestsUsecase({required this.addUserRepo});

  Future<Either<Failure, List<IntrestModel>>> getAllIntrests() async {
    return await addUserRepo.getAllIntrests();
  }
}
