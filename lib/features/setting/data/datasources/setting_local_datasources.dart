
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingLocalDatasources {
  Future<bool> getCachedUseLocalDatabaseState();
  Future<bool> cachedUseLocalDatabaseState({required bool state});
}

const CACHED_DATABASE_STATE = 'GET_CACHED_DATABASE_STATE';

class SettingLocalDatasourcesImpl implements SettingLocalDatasources {
  final SharedPreferences sharedPreferences;

  SettingLocalDatasourcesImpl({required this.sharedPreferences});

  @override
  Future<bool> getCachedUseLocalDatabaseState() async {
    final state = sharedPreferences.getBool(CACHED_DATABASE_STATE);
    if (state == null || state == false) {
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Future<bool> cachedUseLocalDatabaseState({required bool state}) async {
    if (state == false) {
      await sharedPreferences.setBool(CACHED_DATABASE_STATE, false);
      return Future.value(false);
    } else {
      await sharedPreferences.setBool(CACHED_DATABASE_STATE, true);
      return Future.value(true);
    }
  }
}
