import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/customText.dart';
import 'package:trackdeal/utils/text_field_custom.dart';
import 'package:trackdeal/view/post_a_deal/submit_deal3.dart';


class SubmitDeal2 extends StatefulWidget {
  final String dealLink;
  
  const SubmitDeal2({super.key, required this.dealLink});

  @override
  State<SubmitDeal2> createState() => _SubmitDeal2State();
}

class _SubmitDeal2State extends State<SubmitDeal2> {

  bool isOnlineSelected = true;
  
  // Form controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _nextBestPriceController = TextEditingController();
  final TextEditingController _couponCodeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _shippingFromController = TextEditingController();
  
  // Form validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _titleError;
  String? _priceError;
  String? _nextBestPriceError;
  String? _couponCodeError;
  String? _locationError;
  String? _shippingFromError;
  String? _availabilityError;

  void _validateAndNavigate() {
    setState(() {
      _titleError = null;
      _priceError = null;
      _nextBestPriceError = null;
      _couponCodeError = null;
      _locationError = null;
      _shippingFromError = null;
      _availabilityError = null;
    });

    bool isValid = true;

    // Validate title
    if (_titleController.text.trim().isEmpty) {
      setState(() {
        _titleError = 'Title is required';
      });
      isValid = false;
    }

    // Validate price
    if (_priceController.text.trim().isEmpty) {
      setState(() {
        _priceError = 'Price is required';
      });
      isValid = false;
    } else {
      try {
        double price = double.parse(_priceController.text.trim());
        if (price <= 0) {
          setState(() {
            _priceError = 'Price must be greater than 0';
          });
          isValid = false;
        }
      } catch (e) {
        setState(() {
          _priceError = 'Please enter a valid price';
        });
        isValid = false;
      }
    }

    // Validate next best price if provided
    if (_nextBestPriceController.text.trim().isNotEmpty) {
      try {
        double nextBestPrice = double.parse(_nextBestPriceController.text.trim());
        double mainPrice = double.parse(_priceController.text.trim());
        
        if (nextBestPrice <= 0) {
          setState(() {
            _nextBestPriceError = 'Next best price must be greater than 0';
          });
          isValid = false;
        } else if (nextBestPrice <= mainPrice) {
          setState(() {
            _nextBestPriceError = 'Next best price must be higher than the deal price';
          });
          isValid = false;
        }
      } catch (e) {
        setState(() {
          _nextBestPriceError = 'Please enter a valid price';
        });
        isValid = false;
      }
    }

    // Validate coupon code if provided
    if (_couponCodeController.text.trim().isNotEmpty) {
      String couponCode = _couponCodeController.text.trim();
      if (couponCode.length < 3) {
        setState(() {
          _couponCodeError = 'Coupon code must be at least 3 characters long';
        });
        isValid = false;
      } else if (!RegExp(r'^[A-Za-z0-9\-\_]+$').hasMatch(couponCode)) {
        setState(() {
          _couponCodeError = 'Coupon code can only contain letters, numbers, hyphens, and underscores';
        });
        isValid = false;
      }
    }

    // Validate location
    if (_locationController.text.trim().isEmpty) {
      setState(() {
        _locationError = 'Location is required';
      });
      isValid = false;
    }

    // Validate shipping from for online deals
    if (isOnlineSelected && _shippingFromController.text.trim().isEmpty) {
      setState(() {
        _shippingFromError = 'Shipping location is required for online deals';
      });
      isValid = false;
    }

    // Validate availability selection (this is always required)
    // Note: isOnlineSelected is initialized to true, so this validation ensures a choice was made

    if (!isValid) return;

    // Create deal data map
    Map<String, dynamic> dealData = {
      'dealLink': widget.dealLink,
      'title': _titleController.text.trim(),
      'price': double.parse(_priceController.text.trim()),
      'nextBestPrice': _nextBestPriceController.text.trim().isNotEmpty 
          ? double.parse(_nextBestPriceController.text.trim()) 
          : null,
      'couponCode': _couponCodeController.text.trim(),
      'availability': isOnlineSelected ? 'online' : 'in-store',
      'location': _locationController.text.trim(),
      'shippingFrom': isOnlineSelected ? _shippingFromController.text.trim() : null,
    };

    // Print all values
    print('=== SubmitDeal2 Form Data ===');
    print('Deal Link: ${dealData['dealLink']}');
    print('Title: ${dealData['title']}');
    print('Price: \$${dealData['price']}');
    print('Next Best Price: ${dealData['nextBestPrice'] != null ? '\$${dealData['nextBestPrice']}' : 'Not provided'}');
    print('Coupon Code: ${dealData['couponCode'].isNotEmpty ? dealData['couponCode'] : 'Not provided'}');
    print('Availability: ${dealData['availability']} (${isOnlineSelected ? 'Online Deal' : 'In-Store Deal'})');
    print('Location: ${dealData['location']}');
    print('Shipping From: ${dealData['shippingFrom'] ?? 'Not applicable'}');
    print('=============================');

    // Navigate to SubmitDeal3 with all data
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => SubmitDeal3(dealData: dealData),
      )
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _nextBestPriceController.dispose();
    _couponCodeController.dispose();
    _locationController.dispose();
    _shippingFromController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xFF9EA7B8),
                                width: 1,
                              ),
                          ),
                          child: SvgPicture.asset('assets/svgIcons/4.svg'),
                        ),
                      ),
                      Text2(text: 'Submit a deal',
                        fontSize: 20..sp,
                      ),
                      SizedBox(width: 50..w, height: 1..h)
                    ],
                  ),
                  SizedBox(height: 30..h),
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
                                  color: Colors.black.withOpacity(.1)
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*.23,
                              height: 2..h,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.1)
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
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
                                color: Colors.black.withOpacity(.1),
                                shape: BoxShape.circle
                            ),
                          ),
                          Container(
                            height: 10..h,
                            width: 10..w,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.1),
                                shape: BoxShape.circle
                            ),
                          ),
                          Container(
                            height: 10..h,
                            width: 10..w,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.1),
                                shape: BoxShape.circle
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                  SizedBox(height: 20..h,),
                  Text2(text: 'Let\'s start with the essentials',
                    fontSize: 20..sp,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 20..h,),
                  TextFieldCustom(
                    text: 'Title (Required)',
                    text2: 'A short description title of your deal',
                    controller: _titleController,
                    errorText: _titleError,
                  ),
                  _titleError != null
                      ? Padding(
                          padding: EdgeInsets.only(top: 8..h, left: 15..w),
                          child: Text(
                            _titleError!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12..sp,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  SizedBox(height: 20..h,),
                  Text2(text: 'Price details',
                    fontSize: 20..sp,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 20..h,),
                  TextFieldCustom(
                    text: 'Price (\$)',
                    text2: 'Enter the deal price',
                    controller: _priceController,
                    errorText: _priceError,
                  ),
                  _priceError != null
                      ? Padding(
                          padding: EdgeInsets.only(top: 8..h, left: 15..w),
                          child: Text(
                            _priceError!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12..sp,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  SizedBox(height: 20..h,),
                  TextFieldCustom(
                    text: 'Next best Price (\$)',
                    text2: 'Enter the next best price (optional)',
                    controller: _nextBestPriceController,
                    errorText: _nextBestPriceError,
                  ),
                  _nextBestPriceError != null
                      ? Padding(
                          padding: EdgeInsets.only(top: 8..h, left: 15..w),
                          child: Text(
                            _nextBestPriceError!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12..sp,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  SizedBox(height: 20..h,),
                  TextFieldCustom(
                    text: 'Coupon code',
                    text2: 'Enter coupon code (optional)',
                    controller: _couponCodeController,
                    errorText: _couponCodeError,
                  ),
                  _couponCodeError != null
                      ? Padding(
                          padding: EdgeInsets.only(top: 8..h, left: 15..w),
                          child: Text(
                            _couponCodeError!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12..sp,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  SizedBox(height: 20..h,),
                  Text2(text: 'Availability',
                    fontSize: 20..sp,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 20..h,),
                  Container(
                    height: 45..h,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFF6F6F6F),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Online Button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isOnlineSelected = true;
                            });
                          },
                          child: Container(
                            height: 50..h,
                            width: MediaQuery.of(context).size.width * .45,
                            decoration: BoxDecoration(
                              color: isOnlineSelected ? AppColors.primaryColor : Colors.transparent,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                            ),
                            child: Center(
                              child: Text2(
                                text: 'Online',
                                color: isOnlineSelected ? Colors.white : Colors.black.withOpacity(.5),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),

                        // In-store Button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isOnlineSelected = false;
                            });
                          },
                          child: Container(
                            height: 50..h,
                            width: MediaQuery.of(context).size.width * .45,
                            decoration: BoxDecoration(
                              color: !isOnlineSelected ? AppColors.primaryColor : Colors.transparent,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Center(
                              child: Text2(
                                text: 'In-store',
                                color: !isOnlineSelected ? Colors.white : Colors.black.withOpacity(.5),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _availabilityError != null
                      ? Padding(
                          padding: EdgeInsets.only(top: 8..h, left: 15..w),
                          child: Text(
                            _availabilityError!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12..sp,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  SizedBox(height: 20..h,),
                  TextFieldCustom(
                    text: 'Select Location',
                    text2: 'Enter location',
                    controller: _locationController,
                    errorText: _locationError,
                  ),
                  _locationError != null
                      ? Padding(
                          padding: EdgeInsets.only(top: 8..h, left: 15..w),
                          child: Text(
                            _locationError!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12..sp,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  isOnlineSelected ? SizedBox(height: 20..h,) : SizedBox.shrink(),
                  isOnlineSelected
                      ? TextFieldCustom(
                          text: 'Shipping From',
                          text2: 'Enter shipping location',
                          controller: _shippingFromController,
                          errorText: _shippingFromError,
                        )
                      : SizedBox.shrink(),
                  _shippingFromError != null
                      ? Padding(
                          padding: EdgeInsets.only(top: 8..h, left: 15..w),
                          child: Text(
                            _shippingFromError!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12..sp,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  SizedBox(height: 20..h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
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
                      GestureDetector(
                        onTap: _validateAndNavigate,
                        child: Container(
                          height: 45..h,
                          width: 130..w,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text2(text: 'Next',
                              fontSize: 12,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
