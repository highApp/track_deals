import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:trackdeal/view/auth/otp.dart';
import 'package:trackdeal/view/auth/get_started.dart';
import 'package:trackdeal/view/splash2.dart';

import '../../api/api_client.dart';
import '../../utils/utils.dart';
import '../../utils/shared_prefs_helper.dart';

import 'package:http/http.dart' as http;

import '../../view/auth/password.dart';
import 'model/user_login_data.dart';



class AuthController extends GetxController {
  int currentTab = 0;
  String verificationId = '';
  String? countryCode = "+1876";
  String? pRofilecheck = "1";

  bool isSendAgain = false;
  Timer? timer;
  bool isVerifyingOtp = false;

  String lat = "";
  String lng = "";
  bool isTermsConditionAccept = false;
  bool isPrivacyPolicyAccept = false;
  bool isTermsConditionAndPrivacyPolicyAccept = false;
  String? categoryId;
  String? subCategoryId;
  String? identificationTypeImage;
  String? frontImage;
  String? backImage;
  bool isSignedUp = false;
  RxInt start = 120.obs;
  String? profileImage;
  bool isLoginOrSignUpPhone = true;
  String? token;

  ApiClient api = ApiClient(appBaseUrl: baseUrl);

  // Check if user is already logged in
  Future<bool> checkIfUserLoggedIn() async {
    return await SharedPrefsHelper.isLoggedIn();
  }

  // Get stored user data
  Future<UserLoginData?> getStoredUserData() async {
    return await SharedPrefsHelper.getUserLoginData();
  }

  // Logout user
  Future<void> logoutUser() async {
    await SharedPrefsHelper.clearUserLoginData();
    // Navigate to login screen or wherever you want
    Get.offAll(() => Splash2());
  }

  // Get access token for API calls
  Future<String?> getAccessToken() async {
    return await SharedPrefsHelper.getAccessToken();
  }

  // Get user ID for API calls
  Future<int?> getUserId() async {
    return await SharedPrefsHelper.getUserId();
  }

  // Check initial app launch and determine navigation
  Future<String> getInitialRoute() async {
    bool isLoggedIn = await SharedPrefsHelper.isLoggedIn();
    if (isLoggedIn) {
      return '/get_started';
    } else {
      return '/splash2';
    }
  }

  startTimer() {
    start.value = 120;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      if (start.value < 1) {
        timer.cancel();
      } else {
        start.value = start.value - 1;
      }
    });
  }

  Future sendEmailOTPCode(String email) async {
    Response response = await api.postWithForm(
      "api/login-with-email",
      {
        'email': email,
      },

    );
    if (response.statusCode == 200) {
      Get.to(() => OTP(email: email));
    }
    else
      {
        errorAlertToast('Something went wrong\nPlease try again!');
      }
  }

  Future verifyOtp(String email,String oTp) async {
    isVerifyingOtp = true;
    update();

    try {
      Response response = await api.postWithForm(
        "api/otp",
        {
          'email': email,
          'otp_code': oTp,
        },
      );

      if (response.statusCode == 200) {
        // OTP verification successful, now check user login
        await checkUserLogin(email);
      } else {
        // Reset loading state
        isVerifyingOtp = false;
        update();

        // Parse response to get specific error message
        try {
          Map<String, dynamic> responseData = json.decode(response.body);
          String errorMessage = responseData['message'] ?? 'Invalid OTP. Please try again!';
          errorAlertToast(errorMessage);
        } catch (e) {
          errorAlertToast('Invalid OTP. Please try again!');
        }
      }
    } catch (e) {
      // Reset loading state
      isVerifyingOtp = false;
      update();

      String errorMessage = 'Something went wrong\nPlease try again!';

      // Provide more specific error messages based on the error type
      if (e.toString().contains('timeout')) {
        errorMessage = 'Request timeout. Please check your internet connection.';
      } else if (e.toString().contains('network')) {
        errorMessage = 'Network error. Please check your internet connection.';
      } else if (e.toString().contains('server')) {
        errorMessage = 'Server error. Please try again later.';
      }

      errorAlertToast(errorMessage);
    }
  }

  // Show success popup
  void _showSuccessPopup() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 60,
              ),
              SizedBox(height: 20),
              Text(
                'Success!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'OTP verified successfully.\nWelcome back!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    // Auto-close popup and navigate after 2 seconds
    Future.delayed(Duration(seconds: 2), () async {
      bool loginStatusSet = await SharedPrefsHelper.setLoginStatus(true);
      Get.back(); // Close popup
      Get.offAll(() => GetStarted()); // Navigate to GetStarted
    });
  }

  Future checkUserLogin(String email) async {
    try {
      print('AuthController: Starting checkUserLogin for email: $email');
      
      Response response = await api.postWithForm(
        "api/login",
        {
          'email': email,
          'device_token': 'ali111'
        },
      );
      
      print('AuthController: API response status code: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        try {
          var data = jsonDecode(response.bodyString??"");
          print('AuthController: Parsed response data: $data');
          
          UserLoginData loginData = UserLoginData.fromJson(data);
          print('AuthController: UserLoginData created successfully');
          print('AuthController: Status: ${loginData.status}, Message: ${loginData.message}');

          if (loginData.status == true) {
            print("AuthController: Login successful! User exists, navigating to GetStarted");
            
            // Save user data to SharedPreferences
            bool saved = await SharedPrefsHelper.saveUserLoginData(loginData);
            print('AuthController: User data saved to SharedPreferences: $saved');
            
            if (saved) {
              // Set login status
              bool loginStatusSet = await SharedPrefsHelper.setLoginStatus(true);
              print('AuthController: Login status set: $loginStatusSet');
              
              // Navigate to GetStarted screen
              Get.offAll(() => GetStarted());
            } else {
              print('AuthController: Failed to save user data');
              errorAlertToast('Failed to save user data. Please try again!');
            }
          } else {
            print("AuthController: Login failed: ${loginData.message}");
            print("AuthController: User not found, navigating to Password screen for signup");
            
            // Navigate to Password screen for signup
            Get.to(() => Password(email: email));
            errorAlertToast('User not found. Please sign up first.');
          }
        } catch (e) {
          print('AuthController: Error parsing user data: $e');
          print('AuthController: Error details: ${e.toString()}');
          // If parsing fails, navigate to Password screen
          Get.to(() => Password(email: email));
          errorAlertToast('Error parsing user data. Please try again.');
        }
      } else {
        print('AuthController: API request failed with status: ${response.statusCode}');
        try {
          var errorData = jsonDecode(response.body);
          String errorMessage = errorData['message'] ?? 'Login failed. Please try again!';
          print('AuthController: Error message from API: $errorMessage');
          errorAlertToast(errorMessage);
        } catch (e) {
          print('AuthController: Error parsing error response: $e');
          errorAlertToast('Login failed. Please try again!');
        }
      }
    } catch (e) {
      print('AuthController: Exception in checkUserLogin: $e');
      print('AuthController: Exception details: ${e.toString()}');
      errorAlertToast('Something went wrong. Please try again!');
    }
  }

  Future signUp(String email, String firstName, String lastName) async{
    // Response response = await api.postWithForm(
    //   "api/signUp",
    //   {
    //     'email': email,
    //     'first_name': firstName,
    //     'last_name': lastName,
    //     'type': 'email',
    //     'device_token': '1234',
    //     'role': 'customer',
    //   },
    //
    // );
    // if (response.statusCode == 200) {
    //   //Get.to(() => OTP(email: email));
    // }
    // else
    // {
    //   errorAlertToast('Something went wrong\nPlease try again!');
    // }
    try {
      print('AuthController: Starting checkUserLogin for email: $email');

      Response response = await api.postWithForm(
        "api/signUp",
        {
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
          'type': 'email',
          'device_token': '1234',
          'role': 'customer',
        },
      );

      print('AuthController: API response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        try {
          var data = jsonDecode(response.bodyString??"");
          print('AuthController: Parsed response data: $data');

          UserLoginData loginData = UserLoginData.fromJson(data);
          print('AuthController: UserLoginData created successfully');
          print('AuthController: Status: ${loginData.status}, Message: ${loginData.message}');

          if (loginData.status == true) {
            print("AuthController: Login successful! User exists, navigating to GetStarted");

            // Save user data to SharedPreferences
            bool saved = await SharedPrefsHelper.saveUserLoginData(loginData);
            print('AuthController: User data saved to SharedPreferences: $saved');

            if (saved) {
              // Set login status
              bool loginStatusSet = await SharedPrefsHelper.setLoginStatus(true);
              print('AuthController: Login status set: $loginStatusSet');

              // Navigate to GetStarted screen
              Get.offAll(() => GetStarted());
            } else {
              print('AuthController: Failed to save user data');
              errorAlertToast('Failed to save user data. Please try again!');
            }
          } else {
            print("AuthController: Login failed: ${loginData.message}");
            print("AuthController: User not found, navigating to Password screen for signup");

            // Navigate to Password screen for signup
            Get.to(() => Password(email: email));
            errorAlertToast('User not found. Please sign up first.');
          }
        } catch (e) {
          print('AuthController: Error parsing user data: $e');
          print('AuthController: Error details: ${e.toString()}');
          // If parsing fails, navigate to Password screen
          Get.to(() => Password(email: email));
          errorAlertToast('Error parsing user data. Please try again.');
        }
      } else {
        print('AuthController: API request failed with status: ${response.statusCode}');
        try {
          var errorData = jsonDecode(response.body);
          String errorMessage = errorData['message'] ?? 'Login failed. Please try again!';
          print('AuthController: Error message from API: $errorMessage');
          errorAlertToast(errorMessage);
        } catch (e) {
          print('AuthController: Error parsing error response: $e');
          errorAlertToast('Login failed. Please try again!');
        }
      }
    } catch (e) {
      print('AuthController: Exception in checkUserLogin: $e');
      print('AuthController: Exception details: ${e.toString()}');
      errorAlertToast('Something went wrong. Please try again!');
    }
  }

  Future logOut() async {
    try {
      // Get the access token from SharedPreferences
      String? accessToken = await SharedPrefsHelper.getAccessToken();
      
      if (accessToken == null || accessToken.isEmpty) {
        print('AuthController: No access token found');
        // Even without token, clear local data and navigate
        await SharedPrefsHelper.clearUserLoginData();
        Get.offAll(() => Splash2());
        return;
      }

      // Make API call with Bearer token
      Response response = await api.postWithForm(
        "api/logout",
        {},
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        print('AuthController: Logout successful');
        // Clear local user data
        await SharedPrefsHelper.clearUserLoginData();
        Get.offAll(() => Splash2());
      } else {
        print('AuthController: Logout API failed with status: ${response.statusCode}');
        // Even if API fails, clear local data and navigate
        await SharedPrefsHelper.clearUserLoginData();
        Get.offAll(() => Splash2());
      }
    } catch (e) {
      print('AuthController: Exception in logOut: $e');
      // Even if there's an error, clear local data and navigate
      await SharedPrefsHelper.clearUserLoginData();
      Get.offAll(() => Splash2());
    }
  }

  // Show logout confirmation popup
  void showLogoutConfirmation() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.logout,
                color: Colors.orange,
                size: 60,
              ),
              SizedBox(height: 20),
              Text(
                'Logout',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Are you sure you want to logout?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back(); // Close popup
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back(); // Close popup
                      logOut(); // Proceed with logout
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }




}