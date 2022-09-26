import '../../../../core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../utils/app_utils.dart';
import '../../domain/repositories/setting_repo.dart';
import '../datasources/setting_local_datasources.dart';

class SettingRepoImpl implements SettingRepo{
  final SettingLocalDatasources settingLocalDatasources;

  SettingRepoImpl({required this.settingLocalDatasources});

  @override
  Future<Either<Failure, bool>> getUseLocalDatabaseState() async{
    try{
      final databaseState= await settingLocalDatasources.getCachedUseLocalDatabaseState();
      return Right(databaseState);
    }catch(e){
      return Left(AppUtils.buildFailure(e));
    }
  }
  
  @override
  Future<Either<Failure, bool>> setUseLocalDatabaseState({required bool state}) async{
    try{
      final databaseState= await settingLocalDatasources.cachedUseLocalDatabaseState(state: state);
      return Right(databaseState);
    }catch(e){
      return Left(AppUtils.buildFailure(e));
    }
  }
  
  }