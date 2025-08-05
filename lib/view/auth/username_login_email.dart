import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/custom_button.dart';
import 'package:trackdeal/view/auth/get_started.dart';

class UsernameByEmail extends StatefulWidget {
  const UsernameByEmail({super.key});


  @override
  State<UsernameByEmail> createState() => _UsernameByEmailState();
}

class _UsernameByEmailState extends State<UsernameByEmail> {


  bool _termsAccepted = false;
  final FocusNode _usernameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(() {
      setState(() {}); // Rebuild when focus changes
    });
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30..h,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Color(0xFF9EA7B8),
                          width: 1,
                        )
                    ),
                    child: SvgPicture.asset('assets/svgIcons/4.svg'),
                  ),
                ),
                SizedBox(height: 35..h,),
                Center(
                  child: Text('TrackDeals',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'MontserratAlternates'
                    ),
                  ),
                ),
                SizedBox(height: 35..h,),
                Text('Please enter your user name here',
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'PlusJakartaSans'
                  ),
                ),
                SizedBox(height: 20..h,),
                Focus(
                  onFocusChange: (hasFocus){
                    setState(() {});
                  },
                  child: TextField(
                    focusNode: _usernameFocusNode,
                    cursorColor: AppColors.primaryColor,
                    decoration: InputDecoration(
                      labelText: 'User Name',
                      floatingLabelBehavior: FloatingLabelBehavior.always, // Always float
                      labelStyle: TextStyle(
                        color: _usernameFocusNode.hasFocus ? AppColors.primaryColor : Color(0xFF6F6F6F),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:  BorderSide(
                          color: Color(0xFF6F6F6F),
                          width: 1, // Border width
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:  BorderSide(
                          color: AppColors.primaryColor,
                          width: 1, // Border width on focus
                        ),
                      ),
                      contentPadding:  EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10, // Field height control
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.32,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          _termsAccepted = !_termsAccepted;
                        });
                      },
                      child: Container(
                        height: 20..h,
                        width: 20..w,
                        decoration: BoxDecoration(
                            color: _termsAccepted ? AppColors.primaryColor : AppColors.white,
                            border: Border.all(
                              color: _termsAccepted ? AppColors.primaryColor : Color(0xFFCCCCCC),
                            ),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(child: Icon(Icons.check,
                          size: 15,
                          color: _termsAccepted ? AppColors.white : Colors.transparent,
                        )),
                      ),
                    ),
                    SizedBox(width: 5..w,),
                    RichText(text: TextSpan(
                        text: 'I accept the ',
                        style: TextStyle(
                            color: AppColors.black,
                            fontFamily: 'PlusJakartaSans',
                            fontWeight: FontWeight.w500
                        ),
                        children: [
                          TextSpan(
                            text: 'the term of use ',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: 'PlusJakartaSans',
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          TextSpan(
                            text: 'and  ',
                            style: TextStyle(
                                color: AppColors.black,
                                fontFamily: 'PlusJakartaSans',
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          TextSpan(
                            text: 'privacy\npolicy',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: 'PlusJakartaSans',
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ]
                    ))
                  ],
                ),
                SizedBox(height: 20..h,),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GetStarted(),));
                    },
                    child: Button1(text: 'Next'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
