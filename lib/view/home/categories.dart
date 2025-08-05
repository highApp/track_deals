import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/customText.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
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
                  Text2(text: 'Categories',
                  fontSize: 20..sp,
                  ),
                  SizedBox(width: 50,)
                ],
              ),
              SizedBox(height: 30..h,),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(.25),
                          blurRadius: 1
                        )
                      ],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: SvgPicture.asset('assets/svgIcons/15.svg'),
                  ),
                  SizedBox(width: 15..w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text2(text: 'Food & Grocery',
                      fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      Text2(text: '20 deals',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black.withOpacity(.5),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 20..h,),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.black.withOpacity(.25),
                              blurRadius: 1
                          )
                        ],
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: SvgPicture.asset('assets/svgIcons/16.svg'),
                  ),
                  SizedBox(width: 15..w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text2(text: 'Travel',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      Text2(text: '7 deals',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black.withOpacity(.5),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 20..h,),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.black.withOpacity(.25),
                              blurRadius: 1
                          )
                        ],
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: SvgPicture.asset('assets/svgIcons/17.svg'),
                  ),
                  SizedBox(width: 15..w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text2(text: 'Sports',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      Text2(text: '17 deals',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black.withOpacity(.5),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 20..h,),
            ],
          ),
        ),
      ),
    );
  }
}
