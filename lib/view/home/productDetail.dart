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

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

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
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 310..h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/images/image1.png'))
                      ),
                    ),
                    Positioned(
                      left: 20..w,
                      top: 60..h,
                      child: GestureDetector(
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
                    ),
                    Positioned(
                      right: 20..w,
                      top: 60..h,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(.25),
                                blurRadius: 2
                              )
                            ]
                        ),
                        child: SvgPicture.asset('assets/svgIcons/21.svg'),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.25),
                        blurRadius: 1
                      )
                    ]
                  ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(.25),
                                      blurRadius: 4
                                  )
                                ]
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/svgIcons/blue.svg'),
                                SizedBox(width: 10..w,),
                                Text1(text: '2°',
                                  color: Color(0xFF2664EB),
                                ),
                                SizedBox(width: 10..w,),
                                SvgPicture.asset('assets/svgIcons/red.svg'),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset('assets/svgIcons/22.svg'),
                              SizedBox(width: 10..w,),
                              SvgPicture.asset('assets/svgIcons/bookmark.svg'),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 15..h,),
                      Text1(text: 'Brook flap chain bag',
                        fontSize: 20..sp,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text1(text: '\$125',
                            fontSize: 16..sp,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: 5..w,),
                          Stack(
                            children: [
                              SizedBox(
                                child: Text2(text: '\$250',
                                  color: AppColors.black.withOpacity(.6),
                                  fontSize: 11..sp,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                child: Container(
                                  height: 1..h,
                                  width: 30..w,
                                  decoration: BoxDecoration(
                                    color: AppColors.black.withOpacity(.6),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5..h,),
                      Row(
                        children: [
                          SvgPicture.asset('assets/svgIcons/truck.svg'),
                          SizedBox(width: 3..w,),
                          Text2(text: '\$10',
                            fontSize: 10..sp,
                            color: AppColors.black.withOpacity(.6),
                          ),
                          SizedBox(width: 10..w,),
                          Text1(text: 'Posted 6h ago',
                            color: AppColors.black.withOpacity(.4),
                            fontSize: 10..sp,
                          ),
                        ],
                      ),
                      SizedBox(height: 10..h,),
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text1(text: 'Get Deal',
                              color: AppColors.white,
                              fontSize: 12..sp,
                            ),
                            SizedBox(width: 5..w,),
                            SvgPicture.asset('assets/svgIcons/share.svg')

                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10..h,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            blurRadius: 1
                        )
                      ]
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 67..h,
                        width: 67..w,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images/image4.png'))
                        ),
                      ),
                      SizedBox(width: 5..w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text2(text: 'Posted by',
                            fontSize: 10..sp,
                            fontWeight: FontWeight.w400,
                          ),
                          Text2(text: 'William jhonshon',
                            fontSize: 13..sp,
                            fontWeight: FontWeight.w700,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset('assets/svgIcons/23.svg'),
                              SizedBox(width: 5..w,),
                              Text2(text: 'Joined in 2025',
                                fontSize: 10..sp,
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(width: 15..w,),
                              SvgPicture.asset('assets/svgIcons/24.svg'),
                              SizedBox(width: 5..w,),
                              Text2(text: '22',
                                fontSize: 10..sp,
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(width: 15..w,),
                              SvgPicture.asset('assets/svgIcons/25.svg'),
                              SizedBox(width: 5..w,),
                              Text2(text: '13',
                                fontSize: 10..sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
                        child: Text2(text: 'Description',
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
                        child: ReadMoreText(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make  ',
                          trimLines: 2,
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
    );
  }
}
