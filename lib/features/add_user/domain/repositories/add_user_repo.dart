import 'package:dartz/dartz.dart';
import '../../data/model/add_user_model.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/intrest_model.dart';

abstract class AddUserRepo{
  Future<Either<Failure, Unit>> addUser({required AddUserModel addUserModel});
  Future<Either<Failure, List<IntrestModel>>> getAllIntrests();
  
}