import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_with_get_x/data/models/user_data_model.dart';

class AuthenticationController extends GetxController {
  static const String _accessTokenKey = 'access-token';
  static const String _userDataKey = 'user-data';

  static String accessToken = '';
  static UserDataModel? userData ;

  static Future<void> saveAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    accessToken = token;
  }

  static Future<String?> getUserAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_accessTokenKey);
  }

  static Future<void> saveUserData(UserDataModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDataKey, jsonEncode(user.toJson()));
    userData = user;
  }

  static Future<UserDataModel?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(_userDataKey);
    if (data == null) {
      return null;
    }
    UserDataModel userModel = UserDataModel.fromJson(jsonDecode(data));
    return userModel;
  }

  static Future<bool> checkAuthenticationState() async {
    String? token = await getUserAccessToken();

    if(token == null) return false;

    accessToken = token;
    userData = await getUserData();

    return true;

  }

  static Future<void> clearAllData() async {
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
