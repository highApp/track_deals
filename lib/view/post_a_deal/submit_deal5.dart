import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/customText.dart';
import 'package:trackdeal/customWidgets/custom_button.dart';
import 'package:trackdeal/utils/date_picker_custom.dart';
import 'package:trackdeal/utils/category_dropdown.dart';
import 'package:trackdeal/utils/text_field_custom.dart';
import 'package:trackdeal/view/home/Navigation.dart';
import 'package:trackdeal/view/post_a_deal/submit_deal2.dart';
import 'dart:io';

import '../../contoller/homeController/home_controller.dart';
import '../../contoller/homeController/get_category_data.dart';
import '../../contoller/homeController/deal_upload_model.dart';
import '../home/home_screen.dart';
import '../../utils/shared_prefs_helper.dart';

class SubmitDeal5 extends StatefulWidget {
  final Map<String, dynamic> dealData;
  
  const SubmitDeal5({super.key, required this.dealData});

  @override
  State<SubmitDeal5> createState() => _SubmitDeal5State();
}

class _SubmitDeal5State extends State<SubmitDeal5> {
  late final HomeController homCont;
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  
  // Add date controllers
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  
  // Validation error messages
  String? _startDateError;
  String? _endDateError;
  String? _categoryError;
  
  @override
  void initState() {
    super.initState();
    _initializeController();
    _firstNameFocusNode.addListener(() {
      setState(() {}); // Rebuild when focus changes
    });
    _lastNameFocusNode.addListener(() {
      setState(() {}); // Rebuild when focus changes
    });
  }
  
  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }
  
  void _initializeController() {
    try {
      homCont = Get.find<HomeController>();
    } catch (e) {
      // If controller doesn't exist, create it as a singleton
      print('HomeController not found, creating new instance');
      Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
      homCont = Get.find<HomeController>();
    }
    // Categories will be loaded automatically in onInit
  }

  bool _isSubmitting = false;

  // Comprehensive validation method
  bool _validateAllFields() {
    bool isValid = true;
    
    // Clear previous errors
    setState(() {
      _startDateError = null;
      _endDateError = null;
      _categoryError = null;
    });
    
    // Validate start date
    if (_startDateController.text.trim().isEmpty) {
      setState(() {
        _startDateError = 'Start date is required';
      });
      isValid = false;
    }
    
    // Validate end date
    if (_endDateController.text.trim().isEmpty) {
      setState(() {
        _endDateError = 'End date is required';
      });
      isValid = false;
    }
    
    // Validate that end date is after start date
    if (_startDateController.text.isNotEmpty && _endDateController.text.isNotEmpty) {
      try {
        DateTime startDate = DateTime.parse(_startDateController.text);
        DateTime endDate = DateTime.parse(_endDateController.text);
        
        if (endDate.isBefore(startDate) || endDate.isAtSameMomentAs(startDate)) {
          setState(() {
            _endDateError = 'End date must be after start date';
          });
          isValid = false;
        }
      } catch (e) {
        setState(() {
          _endDateError = 'Invalid date format';
        });
        isValid = false;
      }
    }
    
    // Validate category selection
    if (homCont.selectedCategory.value == null) {
      setState(() {
        _categoryError = 'Please select a category';
      });
      isValid = false;
    }
    
    // Validate required fields from previous screens
    if (widget.dealData['dealLink']?.toString().trim().isEmpty == true) {
      _showValidationError('Deal link is required');
      isValid = false;
    }
    
    if (widget.dealData['title']?.toString().trim().isEmpty == true) {
      _showValidationError('Deal title is required');
      isValid = false;
    }
    
    if (widget.dealData['price'] == null) {
      _showValidationError('Deal price is required');
      isValid = false;
    }
    
    if (widget.dealData['location']?.toString().trim().isEmpty == true) {
      _showValidationError('Location is required');
      isValid = false;
    }
    
    // Validate availability
    if (widget.dealData['availability']?.toString().trim().isEmpty == true) {
      _showValidationError('Deal availability is required');
      isValid = false;
    } else if (!homCont.isValidAvailability(widget.dealData['availability'])) {
      _showValidationError('Invalid availability value. Must be "online" or "in-store"');
      isValid = false;
    }
    
    // Validate images
    if (widget.dealData['images'] == null || 
        (widget.dealData['images'] is List && (widget.dealData['images'] as List).isEmpty)) {
      _showValidationError('At least one image is required');
      isValid = false;
    }
    
    return isValid;
  }
  
  void _showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  // Helper method to safely convert any value to string
  String _safeGetString(dynamic value) {
    if (value == null) {
      return '';
    }
    return value.toString();
  }

  void _validateAndSubmit() async {
    if (_isSubmitting) return;
    
    // Check if user is authenticated
    bool isAuthenticated = await homCont.isUserAuthenticated();
    if (!isAuthenticated) {
      _showValidationError('Please login to submit a deal');
      return;
    }
    
    // Debug: Show token status
    var tokenStatus = await homCont.getTokenStatus();
    print('=== Token Status ===');
    print('Has Token: ${tokenStatus['hasToken']}');
    print('Is Logged In: ${tokenStatus['isLoggedIn']}');
    print('User ID: ${tokenStatus['userId']}');
    print('Token Preview: ${tokenStatus['tokenPreview']}');
    print('==================');
    
    // Validate all fields first
    if (!_validateAllFields()) {
      return;
    }
    
    setState(() {
      _isSubmitting = true;
    });
    
    try {
      // Create UploadDealModel with all the data
      UploadDealModel dealModel = UploadDealModel(
        title: _safeGetString(widget.dealData['title']),
        dealLink: _safeGetString(widget.dealData['dealLink']),
        price: _safeGetString(widget.dealData['price']),
        discountPrice: _safeGetString(widget.dealData['nextBestPrice']),
        code: _safeGetString(widget.dealData['couponCode']),
        availability: _safeGetString(widget.dealData['availability']),
        location: _safeGetString(widget.dealData['location']),
        shippingFrom: _safeGetString(widget.dealData['shippingFrom']),
        description: _safeGetString(widget.dealData['description']),
        startDate: _startDateController.text.trim(),
        endDate: _endDateController.text.trim(),
        categoryId: homCont.getSelectedCategoryId()?.toString(),
        userId: await homCont.getCurrentUserId() ?? 1, // Get actual user ID from authentication
      );
      
      // Log availability information
      print('=== Deal Availability Info ===');
      print('Original Availability: ${widget.dealData['availability']}');
      print('Is Valid: ${homCont.isValidAvailability(widget.dealData['availability'])}');
      print('Description: ${homCont.getAvailabilityDescription(widget.dealData['availability'])}');
      print('=============================');
      
      // Get images list from dealData
      List<File> images = [];
      if (widget.dealData['images'] != null) {
        if (widget.dealData['images'] is List<File>) {
          images = List<File>.from(widget.dealData['images']);
        } else if (widget.dealData['images'] is List) {
          // Handle case where images might be stored differently
          for (var item in widget.dealData['images']) {
            if (item is File) {
              images.add(item);
            }
          }
        }
      }
      
      print('=== Submitting Deal ===');
      print('Deal Model: ${dealModel.toJson()}');
      print('Images Count: ${images.length}');
      
      if (images.isEmpty) {
        _showValidationError('No valid images found');
        setState(() {
          _isSubmitting = false;
        });
        return;
      }
      
      // Call the UploadDeal method
      var response = await homCont.UploadDeal(dealModel, images);
      
      print('=== Response Details ===');
      print('Status Code: ${response.statusCode}');
      print('Status Text: ${response.statusText}');
      print('Response Body: ${response.body}');
      print('Response Body Type: ${response.body.runtimeType}');
      print('=======================');
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        // Success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Deal uploaded successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
        
        // Navigate to home screen or success screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Navigation()),
          (route) => false,
        );
      } else if (response.statusCode == 401) {
        // Authentication error
        String errorMessage = response.statusText ?? 'Authentication failed';
        if (errorMessage.contains('token') || errorMessage.contains('login')) {
          _showValidationError('Session expired. Please login again.');
          // You could navigate to login screen here
        } else {
          _showValidationError('Authentication failed: $errorMessage');
        }
      } else {
        // Other errors
        String errorMessage = 'Failed to upload deal';
        if (response.statusText != null) {
          errorMessage += ': ${response.statusText}';
        }
        if (response.body != null && response.body is Map<String, dynamic>) {
          if (response.body['message'] != null) {
            errorMessage += ' - ${response.body['message']}';
          }
        }
        _showValidationError(errorMessage);
      }
    } catch (e) {
      print('Error submitting deal: $e');
      _showValidationError('An error occurred while submitting the deal');
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: 80..h,
          decoration: BoxDecoration(
              color: Colors.white
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _isSubmitting ? null : (){
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  height: 45..h,
                  width: 130..w,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: _isSubmitting ? Colors.grey : const Color(0xFF6F6F6F),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text2(
                      text: 'Back',
                      fontSize: 12,
                      color: _isSubmitting ? Colors.grey : null,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 70..w,),
              GestureDetector(
                onTap: _isSubmitting ? null : _validateAndSubmit,
                child: Container(
                  height: 45..h,
                  width: 130..w,
                  decoration: BoxDecoration(
                    color: _isSubmitting ? Colors.grey : AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: _isSubmitting
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text2(
                            text: 'Submit',
                            fontSize: 12,
                            color: AppColors.white,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: _isSubmitting ? null : (){
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: _isSubmitting ? Colors.grey : Color(0xFF9EA7B8),
                              width: 1,
                            )
                        ),
                        child: SvgPicture.asset(
                          'assets/svgIcons/4.svg',
                          colorFilter: _isSubmitting ? ColorFilter.mode(Colors.grey, BlendMode.srcIn) : null,
                        ),
                      ),
                    ),
                    Text2(text: 'Submit a deal',
                      fontSize: 20..sp,
                    ),
                    SizedBox(width: 50,)
                  ],
                ),
                SizedBox(height: 30..h,),
                Stack(
                  children: [
                    Positioned(
                      top: 4..h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*.23,
                            height: 2..h,
                            decoration: BoxDecoration(
                                color:AppColors.primaryColor
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*.23,
                            height: 2..h,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*.23,
                            height: 2..h,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*.23,
                            height: 2..h,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 10..h,
                            width: 10..w,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle
                            ),
                          ),
                          Container(
                            height: 10..h,
                            width: 10..w,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle
                            ),
                          ),
                          Container(
                            height: 10..h,
                            width: 10..w,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle
                            ),
                          ),
                          Container(
                            height: 10..h,
                            width: 10..w,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle
                            ),
                          ),
                          Container(
                            height: 10..h,
                            width: 10..w,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle
                            ),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 20..h,),
                Text2(text: 'Final Details',
                  fontSize: 20..sp,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 20..h,),
                
                // Display complete form data summary
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15..w),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text2(
                        text: 'Complete Deal Summary',
                        fontSize: 16..sp,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 10..h),
                      Text('Link: ${widget.dealData['dealLink']}', style: TextStyle(fontSize: 12..sp)),
                      Text('Title: ${widget.dealData['title']}', style: TextStyle(fontSize: 12..sp)),
                      Text('Price: \$${widget.dealData['price']}', style: TextStyle(fontSize: 12..sp)),
                      widget.dealData['nextBestPrice'] != null
                          ? Text('Next Best Price: \$${widget.dealData['nextBestPrice']}', style: TextStyle(fontSize: 12..sp))
                          : SizedBox.shrink(),
                      widget.dealData['couponCode'].isNotEmpty
                          ? Text('Coupon: ${widget.dealData['couponCode']}', style: TextStyle(fontSize: 12..sp))
                          : SizedBox.shrink(),
                      Text(
                        'Type: ${homCont.getAvailabilityDescription(widget.dealData['availability'])}', 
                        style: TextStyle(
                          fontSize: 12..sp,
                          color: homCont.isValidAvailability(widget.dealData['availability']) ? Colors.green : Colors.red,
                        )
                      ),
                      Text('Location: ${widget.dealData['location']}', style: TextStyle(fontSize: 12..sp)),
                      widget.dealData['shippingFrom'] != null
                          ? Text('Shipping: ${widget.dealData['shippingFrom']}', style: TextStyle(fontSize: 12..sp))
                          : SizedBox.shrink(),
                      Text(
                        'Images: ${widget.dealData['images']?.length ?? 0} images', 
                        style: TextStyle(
                          fontSize: 12..sp,
                          color: (widget.dealData['images']?.length ?? 0) > 0 ? Colors.green : Colors.red,
                        )
                      ),
                      widget.dealData['description']?.isNotEmpty == true
                          ? Text('Description: ${widget.dealData['description']}', style: TextStyle(fontSize: 12..sp))
                          : SizedBox.shrink(),
                      SizedBox(height: 5..h),
                      Obx(() => homCont.selectedCategory.value != null
                          ? Text('Category: ${homCont.selectedCategory.value!.name}', style: TextStyle(fontSize: 12..sp, color: Colors.green))
                          : Text('Category: Not selected', style: TextStyle(fontSize: 12..sp, color: Colors.red))),
                      SizedBox(height: 5..h),
                      _startDateController.text.isNotEmpty
                          ? Text('Start Date: ${_startDateController.text}', style: TextStyle(fontSize: 12..sp, color: Colors.green))
                          : Text('Start Date: Not selected', style: TextStyle(fontSize: 12..sp, color: Colors.red)),
                      _endDateController.text.isNotEmpty
                          ? Text('End Date: ${_endDateController.text}', style: TextStyle(fontSize: 12..sp, color: Colors.green))
                          : Text('End Date: Not selected', style: TextStyle(fontSize: 12..sp, color: Colors.red)),
                    ],
                  ),
                ),
                SizedBox(height: 20..h,),
                
                // Custom date picker for start date
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: _startDateError != null ? Colors.red : Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    controller: _startDateController,
                    readOnly: true,
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          _startDateController.text = picked.toIso8601String().split('T')[0];
                          _startDateError = null; // Clear error when date is selected
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Start Date (Required)',
                      hintText: 'mm/dd/yyyy',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(.3),
                        fontSize: 12,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(
                        color: _startDateError != null ? Colors.red : AppColors.primaryColor,
                      ),
                      suffixIcon: Container(
                        padding: EdgeInsets.all(15),
                        child: SvgPicture.asset('assets/svgIcons/39.svg'),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: _startDateError != null ? Colors.red : Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: _startDateError != null ? Colors.red : AppColors.primaryColor,
                          width: 1,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                if (_startDateError != null)
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 5),
                    child: Text(
                      _startDateError!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                SizedBox(height: 20..h,),
                
                // Custom date picker for end date
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: _endDateError != null ? Colors.red : Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    controller: _endDateController,
                    readOnly: true,
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _startDateController.text.isNotEmpty 
                            ? DateTime.parse(_startDateController.text).add(Duration(days: 1))
                            : DateTime.now().add(Duration(days: 1)),
                        firstDate: _startDateController.text.isNotEmpty 
                            ? DateTime.parse(_startDateController.text)
                            : DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          _endDateController.text = picked.toIso8601String().split('T')[0];
                          _endDateError = null; // Clear error when date is selected
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'End Date (Required)',
                      hintText: 'mm/dd/yyyy',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(.3),
                        fontSize: 12,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(
                        color: _endDateError != null ? Colors.red : AppColors.primaryColor,
                      ),
                      suffixIcon: Container(
                        padding: EdgeInsets.all(15),
                        child: SvgPicture.asset('assets/svgIcons/39.svg'),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: _endDateError != null ? Colors.red : Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: _endDateError != null ? Colors.red : AppColors.primaryColor,
                          width: 1,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                if (_endDateError != null)
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 5),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, top: 5),
                      child: Text(
                        _endDateError!,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 20..h,),
                
                Obx(() => homCont.isLoadingCategories.value
                    ? Container(
                        padding: EdgeInsets.all(15..w),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                              ),
                            ),
                            SizedBox(width: 10..w),
                            Text('Loading categories...', style: TextStyle(fontSize: 12..sp)),
                          ],
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CategoryDropdown(
                            text: 'Main category (Required)',
                            text2: 'Select a category',
                            onCategorySelected: (Data? category) {
                              // Category selection is handled automatically by the widget
                              // The selected category is stored in the HomeController
                              print('Category selected: ${category?.name} (ID: ${category?.id})');
                              // Clear category error when category is selected
                              if (category != null) {
                                setState(() {
                                  _categoryError = null;
                                });
                              }
                            },
                          ),
                          if (_categoryError != null)
                            Padding(
                              padding: EdgeInsets.only(left: 20, top: 5),
                              child: Text(
                                _categoryError!,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      )),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
