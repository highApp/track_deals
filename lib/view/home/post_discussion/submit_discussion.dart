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

class SubmitDiscussion extends StatefulWidget {
  const SubmitDiscussion({super.key});

  @override
  State<SubmitDiscussion> createState() => _SubmitDiscussionState();
}

class _SubmitDiscussionState extends State<SubmitDiscussion> {
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
                    Text2(text: 'Submit a new discussion',
                      fontSize: 18..sp,
                    ),
                    SizedBox(width: 50,)
                  ],
                ),
                SizedBox(height: 30..h,),
                SizedBox(height: 20..h,),
                TextFieldCustom(text: 'Title (Required)',text2: 'Title',),
                SizedBox(height: 20..h,),
                DropDownList(text: 'Main caegory (Required)',text2: 'None',),
                SizedBox(height: 20..h,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 300..h,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xFF6F6F6F),
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Feel free to discuss anything here',
                        hintStyle: TextStyle(
                            fontSize: 14..sp,
                            color: Colors.black.withOpacity(.5)
                        )
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
