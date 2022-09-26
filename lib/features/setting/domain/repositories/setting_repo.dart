import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class SettingRepo{
  Future<Either<Failure, bool>> getUseLocalDatabaseState();
  Future<Either<Failure, bool>> setUseLocalDatabaseState({required bool state});
}