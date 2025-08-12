import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'dart:io';

import '../../api/api_client.dart';
import 'get_category_data.dart';
import 'deal_upload_model.dart';
import '../../utils/shared_prefs_helper.dart';

class HomeController extends GetxController{
  ApiClient api = ApiClient(appBaseUrl: "https://truckdeals.highapp.co.uk/");
  
  // Observable variables for categories
  RxList<Data> categories = <Data>[].obs;
  Rx<Data?> selectedCategory = Rx<Data?>(null);
  RxBool isLoadingCategories = false.obs;
  RxBool isUploadingDeal = false.obs;
  
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
      // Validate and get bearer token for categories API call
      bool isTokenValid = await validateToken();
      if (!isTokenValid) {
        print('No valid token found for categories API call');
        // Continue without token for categories (they might be public)
      }
      
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
  
  // Get current user ID
  Future<int?> getCurrentUserId() async {
    return await SharedPrefsHelper.getUserId();
  }
  
  // Check if user is authenticated
  Future<bool> isUserAuthenticated() async {
    return await SharedPrefsHelper.isLoggedIn();
  }
  
  // Get formatted bearer token
  Future<String?> getBearerToken() async {
    String? accessToken = await SharedPrefsHelper.getAccessToken();
    if (accessToken != null && accessToken.isNotEmpty) {
      return accessToken.startsWith('Bearer ') ? accessToken : 'Bearer $accessToken';
    }
    return null;
  }
  
  // Validate and refresh token if needed
  Future<bool> validateToken() async {
    String? token = await getBearerToken();
    if (token == null) {
      print('No valid token found');
      return false;
    }
    
    // Update API client header with current token
    api.updateHeader(token);
    print('Token validated and API header updated');
    return true;
  }
  
  // Check if token needs refresh (you can implement this based on your token expiration logic)
  Future<bool> isTokenExpired() async {
    // This is a placeholder - implement based on your token structure
    // You might want to decode JWT and check expiration time
    return false;
  }
  
  // Force token refresh (implement if your API supports refresh tokens)
  Future<bool> refreshToken() async {
    // This is a placeholder - implement based on your refresh token logic
    print('Token refresh not implemented - user needs to login again');
    return false;
  }
  
  // Get current token status for debugging
  Future<Map<String, dynamic>> getTokenStatus() async {
    String? token = await getBearerToken();
    bool isLoggedIn = await SharedPrefsHelper.isLoggedIn();
    int? userId = await SharedPrefsHelper.getUserId();
    
    return {
      'hasToken': token != null,
      'isLoggedIn': isLoggedIn,
      'userId': userId,
      'tokenPreview': token != null ? '${token.substring(0, 20)}...' : 'No token',
    };
  }
  
  // Normalize availability field for API consistency
  String _normalizeAvailability(String? availability) {
    if (availability == null) return 'online'; // Default to online
    
    String normalized = availability.toLowerCase().trim();
    
    // Handle various possible formats
    switch (normalized) {
      case 'online':
      case 'on-line':
      case 'web':
      case 'internet':
        return 'online';
      case 'in-store':
      case 'instore':
      case 'in store':
      case 'physical':
      case 'brick and mortar':
        return 'in-store';
      default:
        // If it's not recognized, default to online
        print('Warning: Unknown availability value "$availability", defaulting to "online"');
        return 'online';
    }
  }
  
  // Get human-readable availability description
  String getAvailabilityDescription(String? availability) {
    String normalized = _normalizeAvailability(availability);
    switch (normalized) {
      case 'online':
        return 'Online Deal';
      case 'in-store':
        return 'In-Store Deal';
      default:
        return 'Online Deal';
    }
  }
  
  // Check if availability is valid
  bool isValidAvailability(String? availability) {
    if (availability == null) return false;
    String normalized = availability.toLowerCase().trim();
    return normalized == 'online' || normalized == 'in-store';
  }
  
  @override
  void onClose() {
    // Clean up resources when controller is disposed
    categories.clear();
    selectedCategory.value = null;
    super.onClose();
  }

  Future<Response> UploadDeal(UploadDealModel dealModel, List<File> images) async {
    if (isUploadingDeal.value) {
      return Response(statusCode: 400, statusText: 'Upload already in progress');
    }
    
    // Check if user is authenticated
    bool isLoggedIn = await SharedPrefsHelper.isLoggedIn();
    if (!isLoggedIn) {
      return Response(statusCode: 401, statusText: 'User not authenticated. Please login first.');
    }
    
    isUploadingDeal.value = true;
    
    try {
      // Validate and get bearer token
      bool isTokenValid = await validateToken();
      if (!isTokenValid) {
        return Response(statusCode: 401, statusText: 'Invalid or expired token. Please login again.');
      }
      
      // Convert images to list of file paths
      List<String> imagePaths = images.map((file) => file.path).toList();
      
      // Prepare the request body
      Map<String, dynamic> requestBody = {
        'title': dealModel.title,
        'deal_link': dealModel.dealLink,
        'price': dealModel.price,
        'discount_price': dealModel.discountPrice,
        'code': dealModel.code,
        'availability': _normalizeAvailability(dealModel.availability),
        'location': dealModel.location,
        'shipping_from': dealModel.shippingFrom,
        'description': dealModel.description,
        'start_date': dealModel.startDate,
        'end_date': dealModel.endDate,
        'category_id': dealModel.categoryId,
      };
      
      print('=== Uploading Deal ===');
      print('Original Availability: ${dealModel.availability}');
      print('Normalized Availability: ${_normalizeAvailability(dealModel.availability)}');
      print('Request Body: $requestBody');
      print('Images Count: ${imagePaths.length}');
      print('Image Paths: $imagePaths');
      
      // Make the API call
      Response response = await api.postWithForm(
        "api/deals", // Update this to your actual API endpoint
        requestBody,
        image: imagePaths,
        imageKey: 'images[]', // Update this to match your API's expected image parameter
        showdialog: true,
      );
      
      print('API Response: ${response.statusCode} - ${response.bodyString??""}');
      print('Response Body Type: ${response.body.runtimeType}');
      print('Response Body: ${response.body}');
      
      // Handle token expiration
      if (response.statusCode == 401) {
        print('Token expired or invalid, user needs to re-authenticate');
        // You could implement token refresh logic here if your API supports it
        return Response(statusCode: 401, statusText: 'Session expired. Please login again.');
      }
      
      return response;
    } catch (e) {
      print('Error uploading deal: $e');
      return Response(statusCode: 500, statusText: 'Error uploading deal: $e');
    } finally {
      isUploadingDeal.value = false;
    }
  }
}