import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/customText.dart';
import 'package:trackdeal/view/post_a_deal/submit_deal4.dart';

import '../../customWidgets/custom_button.dart';

class SubmitDeal3 extends StatefulWidget {
  final Map<String, dynamic> dealData;
  
  const SubmitDeal3({super.key, required this.dealData});

  @override
  State<SubmitDeal3> createState() => _SubmitDeal3State();
}

class _SubmitDeal3State extends State<SubmitDeal3> {

  List<File> imagesList = [];

  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pick Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      pickImage(ImageSource.camera);
                      Get.back();
                    },
                    child: const Button1(text: 'Camera'),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      pickImage(ImageSource.gallery);
                      Get.back();
                    },
                    child: const Button1(text: 'Gallery'),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Button1(text: 'Cancel'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    if (source == ImageSource.gallery) {
      // For gallery, allow multiple image selection
      final List<XFile> pickedFiles = await ImagePicker().pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        setState(() {
          for (var pickedFile in pickedFiles) {
            if (imagesList.length < 8) { // Limit to 8 images
              imagesList.add(File(pickedFile.path));
            }
          }
        });
      }
    } else {
      // For camera, single image selection
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null && imagesList.length < 8) {
        setState(() {
          imagesList.add(File(pickedFile.path));
        });
      }
    }
  }

  void removeImage(int index) {
    setState(() {
      imagesList.removeAt(index);
    });
  }

  void _printAllValuesAndNavigate() {
    // Validate images
    if (imagesList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please add at least one image for your deal'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }
    
    // Print all values including SubmitDeal1 and SubmitDeal2 data
    print('=== SubmitDeal3 - All Form Data ===');
    print('Deal Link: ${widget.dealData['dealLink']}');
    print('Title: ${widget.dealData['title']}');
    print('Price: \$${widget.dealData['price']}');
    print('Next Best Price: ${widget.dealData['nextBestPrice'] != null ? '\$${widget.dealData['nextBestPrice']}' : 'Not provided'}');
    print('Coupon Code: ${widget.dealData['couponCode'].isNotEmpty ? widget.dealData['couponCode'] : 'Not provided'}');
    print('Availability: ${widget.dealData['availability']}');
    print('Location: ${widget.dealData['location']}');
    print('Shipping From: ${widget.dealData['shippingFrom'] ?? 'Not applicable'}');
    print('Images Count: ${imagesList.length}');
    print('===============================');

    // Create updated deal data with images
    Map<String, dynamic> updatedDealData = Map.from(widget.dealData);
    updatedDealData['images'] = imagesList;

    // Print data being passed to SubmitDeal4
    print('=== SubmitDeal3 - Data being passed to SubmitDeal4 ===');
    print('Images added: ${updatedDealData['images']?.length ?? 0}');
    print('Total data keys: ${updatedDealData.keys.toList()}');
    print('===============================');

    // Navigate to SubmitDeal4 with all data
    Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitDeal4(dealData: updatedDealData)));
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
              SizedBox(width: 70..w,),
              GestureDetector(
                onTap: _printAllValuesAndNavigate,
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
            child: Column(
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
                    ),

                  ],
                ),
                SizedBox(height: 20..h,),
                Text2(text: 'Make your deal stand out with images',
                  fontSize: 20..sp,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.start,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text2(
                        text: 'Upload up to 8 images to publish your offer. ',
                        fontSize: 14..sp,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Text2(
                      text: '(${imagesList.length}/8)',
                      fontSize: 14..sp,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                Text2(
                  text: 'You can select multiple images from gallery and remove them by tapping the X button',
                  fontSize: 14..sp,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 20..h,),
                
                // Display previous form data summary
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
                        text: 'Deal Summary',
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
                    ],
                  ),
                ),
                SizedBox(height: 20..h,),
                
                SizedBox(
                  height: ((imagesList.length + (imagesList.length < 8 ? 1 : 0)) / 2).ceil() * 170..h, // Adjust height based on item count
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(), // Disable inner scroll
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemCount: imagesList.length + (imagesList.length < 8 ? 1 : 0), // Extra one for camera icon only if space available
                    itemBuilder: (context, index) {
                      if (index == 0 && imagesList.length < 8) {
                        // First item = camera icon (only show if space available)
                        return GestureDetector(
                          onTap: imagePickerOption,
                          child: Container(
                            height: 160..h,
                            width: 160..w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFE5E5E5),
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: Center(
                              child: SvgPicture.asset('assets/svgIcons/38.svg'),
                            ),
                          ),
                        );
                      } else {
                        final image = imagesList[index - (imagesList.length < 8 ? 1 : 0)];
                        return Stack(
                          children: [
                            Container(
                              height: 160..h,
                              width: 160..w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: FileImage(image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5..h,
                              right: 5..w,
                              child: GestureDetector(
                                onTap: () => removeImage(index - (imagesList.length < 8 ? 1 : 0)),
                                child: Container(
                                  padding: EdgeInsets.all(5..w),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.close, color: Colors.white, size: 18..sp),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
                
                // Show message when max images reached
                if (imagesList.length >= 8)
                  Padding(
                    padding: EdgeInsets.only(top: 10..h),
                    child: Text2(
                      text: 'Maximum 8 images reached. Remove some images to add more.',
                      fontSize: 12..sp,
                      color: Colors.orange,
                      textAlign: TextAlign.center,
                    ),
                  ),
                
                // Show message when no images selected
                if (imagesList.isEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 10..h),
                    child: Text2(
                      text: '⚠️ Please add at least one image for your deal',
                      fontSize: 12..sp,
                      color: Colors.red,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
