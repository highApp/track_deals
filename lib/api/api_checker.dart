import 'dart:convert';


import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;

import '../utils/utils.dart';





class ApiChecker {
  Future<Response> checkApi({required http.Response respons, bool showUserError = true, bool showSystemError = true}) async {
    dynamic  response =Response(
          body: jsonDecode(respons.body) ?? respons.body,
          bodyString: respons.body.toString(),
          request: Request(
              headers: respons.request!.headers,
              method: respons.request!.method,
              url: respons.request!.url),
          headers: respons.headers,
          statusCode: respons.statusCode,
          statusText: respons.reasonPhrase,
        );
    print(response.body);
    print("status code: ${response.statusCode}");
    if (response == null) {
      if (showSystemError) {
        errorAlertToast('Check your internet connection and try again');
      }
    } else if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode! == 401 || response.statusCode! == 403) {
      if (showUserError) {
        // Get.offAll(() =>  LoginPhone());
         errorAlertToast(response.body['message']);
     }
    } else if (response.statusCode! >= 500) {
      if (showSystemError) {
        errorAlertToast(
          'Server Error!\nPlease try again...',
        );
      }
    } else if (response.statusCode! >= 400) {
      if (showUserError) {
        errorAlertToast(response.body['message']);
      }
    }
    return Response(statusCode: response.statusCode, statusText: response.body);
  }
}
