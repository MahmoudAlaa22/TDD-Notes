import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/setting_repo.dart';

class SettingUsecase{
  final SettingRepo settingRepo;

  SettingUsecase({required this.settingRepo});

  Future<Either<Failure, bool>> getUseLocalDatabaseState()async{
    return await settingRepo.getUseLocalDatabaseState();
  }
  Future<Either<Failure, bool>> setUseLocalDatabaseState({required bool state})async{
    return await settingRepo.setUseLocalDatabaseState(state: state);
  }
}