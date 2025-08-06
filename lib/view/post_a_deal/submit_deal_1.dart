import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/customText.dart';
import 'package:trackdeal/customWidgets/custom_button.dart';
import 'package:trackdeal/utils/text_field_custom.dart';
import 'package:trackdeal/view/post_a_deal/submit_deal2.dart';

class SubmitDeal1 extends StatefulWidget {
  const SubmitDeal1({super.key});

  @override
  State<SubmitDeal1> createState() => _SubmitDeal1State();
}

class _SubmitDeal1State extends State<SubmitDeal1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
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
                Text2(text: 'Share a deal with millions of people',
                fontSize: 20..sp,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.start,
                ),
                Text2(text: 'Paste link to where other users can get more information on the deal',
                fontSize: 14..sp,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 25..h,),
                TextFieldCustom(text: 'Deal Link',text2: 'https://www.site.com/greatdeal...',),
                SizedBox(height: 50..h,),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitDeal2(),));
                    },
                    child: Button1(text: 'Get Started')),
                SizedBox(height: 30..h,),
                Text2(text: 'I don’t have link',
                fontSize: 16..sp,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
