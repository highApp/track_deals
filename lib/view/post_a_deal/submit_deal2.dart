import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/customText.dart';
import 'package:trackdeal/utils/text_field_custom.dart';
import 'package:trackdeal/view/post_a_deal/submit_deal3.dart';


class SubmitDeal2 extends StatefulWidget {
  const SubmitDeal2({super.key});

  @override
  State<SubmitDeal2> createState() => _SubmitDeal2State();
}

class _SubmitDeal2State extends State<SubmitDeal2> {

  bool isOnlineSelected = true;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
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
                    ),

                  ],
                ),
                SizedBox(height: 20..h,),
                Text2(text: 'Let’s start with the essentials',
                  fontSize: 20..sp,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 20..h,),
                TextFieldCustom(text: 'Title (Required)',text2: 'A short description title of your deal',),
                SizedBox(height: 20..h,),
                Text2(text: 'Price details',
                  fontSize: 20..sp,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 20..h,),
                TextFieldCustom(text: 'Price (\$)',text2: 'A short description title of your deal',),
                SizedBox(height: 20..h,),
                TextFieldCustom(text: 'Next best Price (\$)',text2: 'A short description title of your deal',),
                SizedBox(height: 20..h,),
                TextFieldCustom(text: 'Coupon code',text2: 'EDC6F',),
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
                SizedBox(height: 20..h,),
                TextFieldCustom(text: 'Select Location'),
                isOnlineSelected? SizedBox(height: 20..h,): SizedBox(),
                isOnlineSelected? 
                    TextFieldCustom(text: 'Shipping From'):
                    SizedBox(),
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
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitDeal3(),));
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
