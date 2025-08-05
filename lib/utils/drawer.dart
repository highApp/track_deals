import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackdeal/constants/colors.dart' show AppColors;
import 'package:trackdeal/customWidgets/customText.dart';
import 'package:trackdeal/view/home/categories.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260..w,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: AppColors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25..h,),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text('Logo',
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'MontserratAlternates'
              ),
            ),
          ),
          SizedBox(height: 15..h,),
          Container(
            height: 1..h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: AppColors.black.withOpacity(.1)
            ),
          ),
          SizedBox(height: 15..h,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Categories(),));
              },
              child: Row(
                children: [
                  SvgPicture.asset('assets/svgIcons/9.svg'),
                  SizedBox(width: 10..w,),
                  Text2(text: 'Category',
                    fontSize: 14,
                    color: AppColors.black.withOpacity(.5),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20..h,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                SvgPicture.asset('assets/svgIcons/10.svg'),
                SizedBox(width: 10..w,),
                Text2(text: 'Setting',
                  fontSize: 14,
                  color: AppColors.black.withOpacity(.5),
                )
              ],
            ),
          ),
          SizedBox(height: 20..h,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                SvgPicture.asset('assets/svgIcons/11.svg'),
                SizedBox(width: 10..w,),
                Text2(text: 'About us',
                  fontSize: 14,
                  color: AppColors.black.withOpacity(.5),
                )
              ],
            ),
          ),
          SizedBox(height: 20..h,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                SvgPicture.asset('assets/svgIcons/12.svg'),
                SizedBox(width: 10..w,),
                Text2(text: 'Contact us',
                  fontSize: 14,
                  color: AppColors.black.withOpacity(.5),
                )
              ],
            ),
          ),
          SizedBox(height: 20..h,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                SvgPicture.asset('assets/svgIcons/13.svg'),
                SizedBox(width: 10..w,),
                Text2(text: 'FAQ',
                  fontSize: 14,
                  color: AppColors.black.withOpacity(.5),
                )
              ],
            ),
          ),
          SizedBox(height: 20..h,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                SvgPicture.asset('assets/svgIcons/14.svg'),
                SizedBox(width: 10..w,),
                Text2(text: 'Privacy Policy',
                  fontSize: 14,
                  color: AppColors.black.withOpacity(.5),
                )
              ],
            ),
          ),
          SizedBox(height: 20..h,),
        ],
      ),
    );
  }
}
