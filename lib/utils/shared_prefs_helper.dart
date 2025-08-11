import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../contoller/authController/model/user_login_data.dart';

class SharedPrefsHelper {
  static const String _userLoginDataKey = 'user_login_data';
  static const String _accessTokenKey = 'access_token';
  static const String _userIdKey = 'user_id';
  static const String _isLoggedInKey = 'is_logged_in';

  // Save user login data
  static Future<bool> saveUserLoginData(UserLoginData userData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print('SharedPrefsHelper: Saving user login data...');
      
      // Save complete user data as JSON
      String userDataJson = jsonEncode(userData.toJson());
      await prefs.setString(_userLoginDataKey, userDataJson);
      
      // Save individual important fields for quick access
      await prefs.setString(_accessTokenKey, userData.accessToken ?? '');
      await prefs.setInt(_userIdKey, userData.userId ?? 0);
      
      // Set login status to true
      await prefs.setBool(_isLoggedInKey, true);
      
      print('SharedPrefsHelper: User login data saved successfully');
      print('SharedPrefsHelper: isLoggedIn set to: ${await prefs.getBool(_isLoggedInKey)}');
      
      return true;
    } catch (e) {
      print('Error saving user login data: $e');
      return false;
    }
  }

  // Get user login data
  static Future<UserLoginData?> getUserLoginData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userDataJson = prefs.getString(_userLoginDataKey);
      if (userDataJson != null && userDataJson.isNotEmpty) {
        Map<String, dynamic> userDataMap = jsonDecode(userDataJson);
        return UserLoginData.fromJson(userDataMap);
      }
      return null;
    } catch (e) {
      print('Error getting user login data: $e');
      return null;
    }
  }

  // Get access token
  static Future<String?> getAccessToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(_accessTokenKey);
    } catch (e) {
      print('Error getting access token: $e');
      return null;
    }
  }

  // Get user ID
  static Future<int?> getUserId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_userIdKey);
    } catch (e) {
      print('Error getting user ID: $e');
      return null;
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? loginStatus = prefs.getBool(_isLoggedInKey);
      print('SharedPrefsHelper.isLoggedIn(): Raw value from SharedPreferences: $loginStatus');
      print('SharedPrefsHelper.isLoggedIn(): Final result: ${loginStatus ?? false}');
      return loginStatus ?? false;
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }

  // Clear user login data (logout)
  static Future<bool> clearUserLoginData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userLoginDataKey);
      await prefs.remove(_accessTokenKey);
      await prefs.remove(_userIdKey);
      await prefs.setBool(_isLoggedInKey, false);
      return true;
    } catch (e) {
      print('Error clearing user login data: $e');
      return false;
    }
  }

  // Explicitly set login status
  static Future<bool> setLoginStatus(bool isLoggedIn) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, isLoggedIn);
      print('SharedPrefsHelper: Login status set to: $isLoggedIn');
      return true;
    } catch (e) {
      print('Error setting login status: $e');
      return false;
    }
  }

  // Check and print current login status for debugging
  static Future<void> debugLoginStatus() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
      String? accessToken = prefs.getString(_accessTokenKey);
      int? userId = prefs.getInt(_userIdKey);
      
      print('SharedPrefsHelper Debug Info:');
      print('  - isLoggedIn: $isLoggedIn');
      print('  - accessToken: ${accessToken ?? 'null'}');
      print('  - userId: ${userId ?? 'null'}');
    } catch (e) {
      print('Error getting debug info: $e');
    }
  }
}
