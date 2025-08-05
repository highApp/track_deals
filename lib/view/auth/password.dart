import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/custom_button.dart';
import 'package:trackdeal/view/auth/username_login_email.dart';

class Password extends StatefulWidget {
  const Password({super.key});


  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _usernameFocusNode1 = FocusNode();

  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(() {setState(() {});// Rebuild when focus changes
    });
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _usernameFocusNode1.dispose();
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
                Text('Create Password',
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
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
                    obscureText: true,
                    focusNode: _usernameFocusNode,
                    cursorColor: AppColors.primaryColor,
                    decoration: InputDecoration(
                      labelText: 'Password',
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
                SizedBox(height: 20..h,),
                Focus(
                  onFocusChange: (hasFocus){
                    setState(() {});
                  },
                  child: TextField(
                    obscureText: true,
                    focusNode: _usernameFocusNode1,
                    cursorColor: AppColors.primaryColor,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      floatingLabelBehavior: FloatingLabelBehavior.always, // Always float
                      labelStyle: TextStyle(
                        color: _usernameFocusNode1.hasFocus ? AppColors.primaryColor : Color(0xFF6F6F6F),
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
                SizedBox(height: MediaQuery.of(context).size.height*.265,),
                SizedBox(height: 20..h,),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UsernameByEmail(),));
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
