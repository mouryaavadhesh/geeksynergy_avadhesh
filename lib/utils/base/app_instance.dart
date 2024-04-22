

import 'package:geeksynergy_avadhesh/data/database/database_manager.dart';
import 'package:geeksynergy_avadhesh/data/netwrok/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils.dart';

class AppInstance {
  static final AppInstance _instance = AppInstance._internal();
  final DatabaseManager databaseHelper = DatabaseManager();
  late SharedPreferences _sharedPreferences;

  final DioClient _dioClient = DioClient.init();

  factory AppInstance() {
    return _instance;
  }

  AppInstance._internal();
  Future<void> init() async {
    try {
      databaseHelper.init();
      _sharedPreferences = await SharedPreferences.getInstance();

    } catch (err, stackTrace) {
      Utils.captureException(err, stackTrace);
    }
  }

  DioClient get getApiInstance => _dioClient;
  SharedPreferences get sharedPreferences => _sharedPreferences;

}
