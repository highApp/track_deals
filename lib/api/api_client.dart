import 'package:get/get.dart';
import 'package:http/http.dart' as Http;

import '../utils/utils.dart';
import 'api_checker.dart';
String? tokenMain;
String baseUrl = "https://truckdeals.highapp.co.uk/";

class ApiClient extends GetxService {
  final String appBaseUrl;
  static const String noInternetMessage =
      'Connection to API server failed due to internet connection';
  final int timeoutInSeconds = 60;
  String? token;
  Map<String, String> _mainHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': "*",
  };
  ApiClient({
    required this.appBaseUrl,
  }) {
    if (tokenMain != null) {
      updateHeader(
        tokenMain!,
      );
    }
  }
  void updateHeader(
    String token,
  ) {
    this.token = token;
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Access-Control-Allow-Origin': "*",
      'Authorization': 'Bearer $token'
    };

    print(_mainHeaders);
  }

  ApiChecker apichecker = ApiChecker();
  Future<Response> getData(String uri,
      {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      final url = Uri.parse(appBaseUrl + uri);
      final newURI = url.replace(queryParameters: query);
      print("Url:  $newURI");
      Http.Response _response = await Http.get(
        newURI,
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return apichecker.checkApi(
        respons: _response,
      );
    } catch (e) {
      print("eroor : $e");
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }


  Future<Response> postWithForm(String uri, Map<String, dynamic> body,
      {Map<String, String>? headers,bool showdialog = true,List<String>? image,String imageKey='',bool showUserError = true, bool showSystemError = true }) async {

    print(body);
    if(showdialog) {
      showLoading();
    }
    try {
      var header = headers??_mainHeaders;
      print(header);
      var request = Http.MultipartRequest(
          'POST',
          Uri.parse(appBaseUrl + uri));
      request.fields
          .addAll(body.map((key, value) => MapEntry(key, value.toString())));

      request.headers.addAll(header);
      image?.forEach((element) async {
        request.files.add(await Http.MultipartFile.fromPath(imageKey, element));
      });
      Http.StreamedResponse streamedResponse = await request.send();
      if(showdialog) {
        Get.back();
      }
      var response = await Http.Response.fromStream(streamedResponse);
      return apichecker.checkApi(respons: response,showUserError: showUserError,showSystemError: showSystemError);
    } catch (e) {
      if(showdialog) {
        Get.back();
      }
      print("error" + e.toString());
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }



}
