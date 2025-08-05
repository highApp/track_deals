import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readmore/readmore.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/customText.dart';
import 'package:trackdeal/customWidgets/custom_button.dart';

class DiscussionDetail extends StatefulWidget {
  const DiscussionDetail({super.key});

  @override
  State<DiscussionDetail> createState() => _DiscussionDetailState();
}

class _DiscussionDetailState extends State<DiscussionDetail> {

  final List<String> imagePaths = [
    'assets/images/image5.png',
    'assets/images/image5.png',
    'assets/images/image5.png',
    'assets/images/image5.png',
    'assets/images/image5.png',

  ];

  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xFFFBFBFB),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5..h,
                width: 60..w,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.4),
                    borderRadius: BorderRadius.circular(5)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text2(text: 'Please share your opinion about the product',
                  fontSize: 18..sp,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 150..h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFFE5E5E5),
                          blurRadius: 5
                      )
                    ]
                ),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Your Review',
                      hintStyle: TextStyle(
                          color: Colors.black.withOpacity(.5)
                      )
                  ),
                ),
              ),
              SizedBox(height: 20..h,),
              Row(
                children: [
                  GestureDetector(
                    onTap: imagePickerOption,
                    child: Container(
                      height: 105..h,
                      width: 105..w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFFE5E5E5),
                                blurRadius: 5
                            )
                          ]
                      ),
                      child:Center(
                        child: Container(
                            height: 52..h,
                            width: 52..w,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle
                            ),
                            child: Icon(Icons.camera_alt, color: Colors.white,size: 20,)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: imagesList.isNotEmpty
                        ? SizedBox(
                      height: 105..h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imagesList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            height: 105..h,
                            width: 105..w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: FileImage(imagesList[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                        : const SizedBox(),
                  ),
                ],
              ),
              SizedBox(height: 50..h,),
              GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Button1(text: 'Send review')),

            ],
          ),
        );
      },
    );
  }

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
        backgroundColor: AppColors.white.withOpacity(.97),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                 SizedBox(height: 20..h,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
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
                        Text2(text: 'Discussion',
                        fontSize: 20..sp,
                        ),
                        Container(width: 50..w,)
                      ],
                    ),
                  ),
                  SizedBox(height: 25..h,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            blurRadius: 1
                          )
                        ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text2(text: 'Reward member deals',
                              fontSize: 16..sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10..h,),
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.2),
                            ),
                          ),
                          SizedBox(height: 10..h,),
                          Row(
                            children: [
                              Container(
                                height: 40..h,
                                width: 40..w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: AssetImage('assets/images/image4.png'))
                                ),
                              ),
                              SizedBox(width: 10..w,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text2(text: 'William jhonshon',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  Text2(text: 'posted 6hours ago',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(.5),
                                  ),
                                ],
                              ),

                            ],
                          ),
                          SizedBox(height: 10..h,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ReadMoreText(
                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make  ',
                              trimLines: 6,
                              colorClickableText: AppColors.primaryColor,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400
                              ),
                              trimCollapsedText: 'See More',
                              trimExpandedText: 'See less',
                              trimMode: TrimMode.Line,
                            ),
                          ),
                          SizedBox(height: 10..h,),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: SizedBox(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                      imagePaths.length, (index)
                                  {
                                    return Container(
                                      margin: EdgeInsets.only(right: 10),
                                      width: 110..h,
                                      height: 110..w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: AssetImage(imagePaths[index]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10..h,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.25),
                              blurRadius: 1
                          )
                        ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text2(text: 'Comments(10)',
                            fontSize: 14..sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 10..h,),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.2),
                          ),
                        ),
                        SizedBox(height: 10..h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Container(
                                height: 40..h,
                                width: 40..w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: AssetImage('assets/images/image4.png'))
                                ),
                              ),
                              SizedBox(width: 10..w,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text2(text: 'emilyinyc',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  Row(
                                    children: [
                                      Text2(text: '17 hours ago',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withOpacity(.5),
                                      ),
                                      SizedBox(width: 10..w,),
                                      Text2(text: '5:36',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withOpacity(.5),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 5..h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text2(text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
                            fontSize: 12..sp,
                            color: Colors.black.withOpacity(.7),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(height: 5..h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/svgIcons/26.svg'),
                              SizedBox(width: 5..w,),
                              Text2(text: 'Like',
                                fontSize: 12..sp,
                                color: Colors.black.withOpacity(.7),
                              ),
                              SizedBox(width: 15..w,),
                              SvgPicture.asset('assets/svgIcons/27.svg'),
                              SizedBox(width: 5..w,),
                              Text2(text: 'reply',
                                fontSize: 12..sp,
                                color: Colors.black.withOpacity(.7),
                              )
                            ],
                          ),
                        ),
              // this can be convert into list ..... when backend done...
                        SizedBox(height: 10..h,),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.2),
                          ),
                        ),
                        SizedBox(height: 10..h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Container(
                                height: 40..h,
                                width: 40..w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: AssetImage('assets/images/image4.png'))
                                ),
                              ),
                              SizedBox(width: 10..w,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text2(text: 'emilyinyc',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  Row(
                                    children: [
                                      Text2(text: '17 hours ago',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withOpacity(.5),
                                      ),
                                      SizedBox(width: 10..w,),
                                      Text2(text: '5:36',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withOpacity(.5),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 5..h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text2(text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
                            fontSize: 12..sp,
                            color: Colors.black.withOpacity(.7),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(height: 5..h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/svgIcons/26.svg'),
                              SizedBox(width: 5..w,),
                              Text2(text: 'Like',
                                fontSize: 12..sp,
                                color: Colors.black.withOpacity(.7),
                              ),
                              SizedBox(width: 15..w,),
                              SvgPicture.asset('assets/svgIcons/27.svg'),
                              SizedBox(width: 5..w,),
                              Text2(text: 'reply',
                                fontSize: 12..sp,
                                color: Colors.black.withOpacity(.7),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: 15..w,
              bottom: 20..h,
              child: GestureDetector(
                onTap: (){
                  _showCustomBottomSheet(context);
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/svgIcons/28.svg'),
                      SizedBox(width: 5..w,),
                      Text1(text: 'Write a Comment',
                        color: AppColors.white,
                        fontSize: 14..sp,
                      ),

                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
