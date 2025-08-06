import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/customText.dart';
import 'package:trackdeal/customWidgets/custom_button.dart';
import 'package:trackdeal/utils/date_picker_custom.dart';
import 'package:trackdeal/utils/drop__down_list.dart';
import 'package:trackdeal/utils/text_field_custom.dart';
import 'package:trackdeal/view/home/Navigation.dart';
import 'package:trackdeal/view/post_a_deal/submit_deal2.dart';

class SubmitCoupon5 extends StatefulWidget {
  const SubmitCoupon5({super.key});

  @override
  State<SubmitCoupon5> createState() => _SubmitCoupon5State();
}

class _SubmitCoupon5State extends State<SubmitCoupon5> {
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Navigation(),));
                },
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
                    Text2(text: 'Submit a coupon',
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
                DatePickerCustom(text: 'Start Date',text2: 'mm/dd/yyyy',),
                SizedBox(height: 20..h,),
                DatePickerCustom(text: 'End Date',text2: 'mm/dd/yyyy',),
                SizedBox(height: 20..h,),
                DropDownList(text: 'Main caegory (Required)',text2: 'None',),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
