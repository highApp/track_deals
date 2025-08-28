import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:trackdeal/contoller/homeController/home_data_model.dart';

import '../../api/api_client.dart';

class HomeMainController extends GetxController {
  ApiClient api = ApiClient(appBaseUrl: "https://truckdeals.highapp.co.uk/");
  
  // Observable variables
  var homeData = Rx<HomeDataModel?>(null);
  var isLoading = false.obs;
  var selectedType = 'all'.obs;

  Future<void> getHomedata({String type = 'all'}) async {
    try {
      // Use a defensive approach to prevent build phase conflicts
      if (Get.isRegistered<HomeMainController>()) {
        isLoading.value = true;
        selectedType.value = type;
      }
      
      print('HomeMainController: Fetching data for type: $type');
      
      Response response = await api.postWithForm(
        "api/public-home",
        {
          'type': type
        },
      );

      print('HomeMainController: API response status: ${response.statusCode}');
      print('HomeMainController: API response body: ${response.body}');

      // Use a defensive approach when updating observable variables
      if (Get.isRegistered<HomeMainController>()) {
        if (response.statusCode == 200) {
          if (response.body != null) {
            try {
              homeData.value = HomeDataModel.fromJson(response.body);
              print('HomeMainController: Data parsed successfully. Deals count: ${homeData.value?.dataUsers?.firstOrNull?.deals?.length ?? 0}');
            } catch (parseError) {
              print('HomeMainController: Error parsing response: $parseError');
              homeData.value = null;
            }
          } else {
            print('HomeMainController: Response body is null');
            homeData.value = null;
          }
        } else {
          print('HomeMainController: API error with status: ${response.statusCode}');
          homeData.value = null;
        }
      }
    } catch (e) {
      print('HomeMainController: Exception occurred: $e');
      if (Get.isRegistered<HomeMainController>()) {
        homeData.value = null;
      }
    } finally {
      // Use a defensive approach when updating observable variables
      if (Get.isRegistered<HomeMainController>()) {
        isLoading.value = false;
        print('HomeMainController: Request completed for type: $type');
      }
    }
  }
}