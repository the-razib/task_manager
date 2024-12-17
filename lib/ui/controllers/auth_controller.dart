import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_with_getx/data/models/user_model.dart';
import 'package:get/get.dart';
/// A controller class to manage authentication-related operations.
class AuthController{
  static const String _accessTokenKey='access-token';
  static const String _userDataKey='userdata';

  static String? accessToken;
  static UserModel? userdata;

  /// Saves the access token to shared preferences.
  ///
  /// \param token The access token to be saved.
  static Future<void> saveAccessToken (String token) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey,token);
    accessToken=token;
  }

static Future<void> saveUserData(UserModel userModel) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String userJson = jsonEncode(userModel.toJson());
  bool result = await sharedPreferences.setString(_userDataKey, userJson);
  if (result) {
    userdata = userModel;
    print('User data saved successfully.');
  } else {
    print('Failed to save user data.');
  }
}

  /// Retrieves the access token from shared preferences.
  ///
  /// \returns The access token if it exists, otherwise null.
  static Future<String?> getAccessToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token=sharedPreferences.getString(_accessTokenKey);
    accessToken=token;
    return token;
  }

  static Future<UserModel?> getUserData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userEncodedData=sharedPreferences.getString(_userDataKey);
    if(userEncodedData==null) {
      return null;
    }
    UserModel userModel = UserModel.fromJson(jsonDecode(userEncodedData));
    userdata=userModel;
    return userModel;
  }

  /// Checks if the user is logged in.
  ///
  /// \returns True if the access token is not null, otherwise false.
  static bool loggedIn(){
    return accessToken!=null;
  }

  /// Clears the user data from shared preferences.
  static Future<void> clearUserData ()async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    sharedPreferences.clear();
    accessToken=null;
  }
  void updateUserData(UserModel userModel) {
    userdata = userModel;
  }

}