import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../api/api_client.dart';
import 'get_category_data.dart';

class HomeController extends GetxController{
  ApiClient api = ApiClient(appBaseUrl: "https://truckdeals.highapp.co.uk/");
  
  // Observable variables for categories
  RxList<Data> categories = <Data>[].obs;
  Rx<Data?> selectedCategory = Rx<Data?>(null);
  RxBool isLoadingCategories = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    // Delay the category fetch to ensure proper initialization
    Future.delayed(Duration(milliseconds: 100), () {
      getCategory();
    });
  }
  
  Future<void> getCategory() async{
    if (isLoadingCategories.value) return; // Prevent multiple simultaneous calls
    
    isLoadingCategories.value = true;
    
    try {
      Response response = await api.postWithForm(
        "api/getCategories",
        {},
      );
      
      if (response.statusCode == 200) {
        if (response.body != null) {
          GetCategoryModel categoryModel = GetCategoryModel.fromJson(response.body);
          if (categoryModel.status == true && categoryModel.data != null) {
            categories.value = categoryModel.data!;
            print('Categories loaded: ${categories.length}');
          } else {
            print('API returned false status or no data');
          }
        }
      } else {
        print('API request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading categories: $e');
    } finally {
      isLoadingCategories.value = false;
    }
  }
  
  void setSelectedCategory(Data? category) {
    selectedCategory.value = category;
  }
  
  String? getSelectedCategoryName() {
    return selectedCategory.value?.name;
  }
  
  int? getSelectedCategoryId() {
    return selectedCategory.value?.id;
  }
  
  // Method to manually refresh categories
  Future<void> refreshCategories() async {
    await getCategory();
  }
  
  // Check if categories are loaded
  bool get hasCategories => categories.isNotEmpty;
  
  @override
  void onClose() {
    // Clean up resources when controller is disposed
    categories.clear();
    selectedCategory.value = null;
    super.onClose();
  }
}