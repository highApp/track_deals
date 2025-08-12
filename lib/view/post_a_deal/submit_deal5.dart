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

import '../../contoller/homeController/home_controller.dart';
import '../../contoller/homeController/get_category_data.dart';

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
  
  void _validateAndSubmit() {
    // Prevent multiple submissions
    if (_isSubmitting) return;
    _isSubmitting = true;
    
    // Validate all required data
    List<String> missingFields = [];
    
    if (widget.dealData['dealLink']?.isEmpty ?? true) {
      missingFields.add('Deal Link');
    }
    if (widget.dealData['title']?.isEmpty ?? true) {
      missingFields.add('Title');
    }
    if (widget.dealData['price']?.isEmpty ?? true) {
      missingFields.add('Price');
    }
    if (widget.dealData['availability']?.isEmpty ?? true) {
      missingFields.add('Availability');
    }
    if (widget.dealData['location']?.isEmpty ?? true) {
      missingFields.add('Location');
    }
    if (widget.dealData['images']?.isEmpty ?? true) {
      missingFields.add('Images');
    }
    if (widget.dealData['description']?.isEmpty ?? true) {
      missingFields.add('Description');
    }
    
    // Add category validation
    if (homCont.selectedCategory.value == null) {
      missingFields.add('Main Category');
    }
    
    // Add date validation
    if (_startDateController.text.isEmpty) {
      missingFields.add('Start Date');
    }
    if (_endDateController.text.isEmpty) {
      missingFields.add('End Date');
    }
    
    // Validate date logic
    if (_startDateController.text.isNotEmpty && _endDateController.text.isNotEmpty) {
      try {
        DateTime startDate = DateTime.parse(_startDateController.text);
        DateTime endDate = DateTime.parse(_endDateController.text);
        
        if (startDate.isAfter(endDate)) {
          missingFields.add('Start Date cannot be after End Date');
        }
        
        DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
        if (startDate.isBefore(yesterday)) {
          missingFields.add('Start Date cannot be in the past');
        }
      } catch (e) {
        missingFields.add('Invalid date format');
      }
    }
    
    if (missingFields.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Missing or invalid fields: ${missingFields.join(', ')}'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 4),
        ),
      );
      _isSubmitting = false;
      return;
    }
    
    // Print all collected data before submitting
    print('=== FINAL SUBMISSION - All Deal Data ===');
    print('Deal Link: ${widget.dealData['dealLink']}');
    print('Title: ${widget.dealData['title']}');
    print('Price: \$${widget.dealData['price']}');
    print('Next Best Price: ${widget.dealData['nextBestPrice'] != null ? '\$${widget.dealData['nextBestPrice']}' : 'Not provided'}');
    print('Coupon Code: ${widget.dealData['couponCode']?.isNotEmpty == true ? widget.dealData['couponCode'] : 'Not provided'}');
    print('Availability: ${widget.dealData['availability']}');
    print('Location: ${widget.dealData['location']}');
    print('Shipping From: ${widget.dealData['shippingFrom'] ?? 'Not applicable'}');
    print('Images Count: ${widget.dealData['images']?.length ?? 0}');
    print('Description: ${widget.dealData['description']?.isNotEmpty == true ? widget.dealData['description'] : 'Not provided'}');
    print('Main Category: ${homCont.selectedCategory.value?.name ?? 'Not selected'}');
    print('Category ID: ${homCont.selectedCategory.value?.id ?? 'Not selected'}');
    print('Start Date: ${_startDateController.text}');
    print('End Date: ${_endDateController.text}');
    print('===============================');
    
    // Show success message and navigate to home screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deal submitted successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    
    // Use a delayed navigation to avoid navigator lock issues
    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) {
        try {
          Navigator.pushAndRemoveUntil(
            context, 
            MaterialPageRoute(builder: (context) => Navigation()),
            (route) => false, // Remove all previous routes
          );
        } catch (e) {
          print('Navigation error: $e');
          // Fallback navigation
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Navigation()),
            );
          }
        }
      }
    });
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
                onTap: (){
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
                      color: const Color(0xFF6F6F6F),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text2(text: 'Back',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 70..w,),
              GestureDetector(
                onTap: _validateAndSubmit,
                child: Container(
                  height: 45..h,
                  width: 130..w,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text2(text: 'Submit',
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
                      onTap: (){
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
                              color: Color(0xFF9EA7B8),
                              width: 1,
                            )
                        ),
                        child: SvgPicture.asset('assets/svgIcons/4.svg'),
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
                      Text('Type: ${widget.dealData['availability']}', style: TextStyle(fontSize: 12..sp)),
                      Text('Location: ${widget.dealData['location']}', style: TextStyle(fontSize: 12..sp)),
                      widget.dealData['shippingFrom'] != null
                          ? Text('Shipping: ${widget.dealData['shippingFrom']}', style: TextStyle(fontSize: 12..sp))
                          : SizedBox.shrink(),
                      Text('Images: ${widget.dealData['images']?.length ?? 0} images', style: TextStyle(fontSize: 12..sp)),
                      widget.dealData['description']?.isNotEmpty == true
                          ? Text('Description: ${widget.dealData['description']}', style: TextStyle(fontSize: 12..sp))
                          : SizedBox.shrink(),
                      SizedBox(height: 5..h),
                      Obx(() => homCont.selectedCategory.value != null
                          ? Text('Category: ${homCont.selectedCategory.value!.name}', style: TextStyle(fontSize: 12..sp))
                          : Text('Category: Not selected', style: TextStyle(fontSize: 12..sp, color: Colors.red))),
                      SizedBox(height: 5..h),
                      _startDateController.text.isNotEmpty
                          ? Text('Start Date: ${_startDateController.text}', style: TextStyle(fontSize: 12..sp))
                          : Text('Start Date: Not selected', style: TextStyle(fontSize: 12..sp, color: Colors.red)),
                      _endDateController.text.isNotEmpty
                          ? Text('End Date: ${_endDateController.text}', style: TextStyle(fontSize: 12..sp))
                          : Text('End Date: Not selected', style: TextStyle(fontSize: 12..sp, color: Colors.red)),
                    ],
                  ),
                ),
                SizedBox(height: 20..h,),
                
                // Custom date picker for start date
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
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
                        color: AppColors.primaryColor,
                      ),
                      suffixIcon: Container(
                        padding: EdgeInsets.all(15),
                        child: SvgPicture.asset('assets/svgIcons/39.svg'),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
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
                SizedBox(height: 20..h,),
                
                // Custom date picker for end date
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
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
                        color: AppColors.primaryColor,
                      ),
                      suffixIcon: Container(
                        padding: EdgeInsets.all(15),
                        child: SvgPicture.asset('assets/svgIcons/39.svg'),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
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
                    : CategoryDropdown(
                        text: 'Main category (Required)',
                        text2: 'Select a category',
                        onCategorySelected: (Data? category) {
                          // Category selection is handled automatically by the widget
                          // The selected category is stored in the HomeController
                          print('Category selected: ${category?.name} (ID: ${category?.id})');
                        },
                      )),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
