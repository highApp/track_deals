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
  const SubmitDeal3({super.key});

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
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imagesList.add(File(pickedFile.path));
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
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitDeal4(),));
                },
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
                Text2(text: 'Upload up to 8 images to publish your offer. you can drag and drop to reorder them and pick the cover images',
                  fontSize: 14..sp,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 20..h,),
                SizedBox(
                  height: ((imagesList.length + 1) / 2).ceil() * 170..h, // Adjust height based on item count
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
                    itemCount: imagesList.length + 1, // Extra one for camera icon
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // First item = camera icon
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
                        final image = imagesList[index - 1];
                        return Container(
                          height: 160..h,
                          width: 160..w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: FileImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }
                    },
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
