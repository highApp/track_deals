import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/custom_button.dart';
import 'package:trackdeal/view/auth/username_login_email.dart';

import '../../contoller/authController/auth_contorller.dart';

class Password extends StatefulWidget {
  final String email;
  
  const Password({super.key, required this.email});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  late final AuthController authCont;

  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeController();
    _firstNameFocusNode.addListener(() {
      setState(() {}); // Rebuild when focus changes
    });
    _lastNameFocusNode.addListener(() {
      setState(() {}); // Rebuild when focus changes
    });
  }

  void _initializeController() {
    try {
      authCont = Get.find<AuthController>();
    } catch (e) {
      // If controller doesn't exist, create it as a singleton
      print('Password: AuthController not found, creating new instance');
      Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
      authCont = Get.find<AuthController>();
    }
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  // Handle next button click
  void _handleNextButtonClick() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = widget.email;
    
    // Validate inputs
    if (firstName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your first name'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    if (firstName.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('First name must be at least 2 characters long'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    if (lastName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your last name'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    if (lastName.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Last name must be at least 2 characters long'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    // Check if names contain only letters and spaces
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(firstName)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('First name should only contain letters'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(lastName)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Last name should only contain letters'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    // Print email + firstname + lastname
    print('Email: $email');
    print('First Name: $firstName');
    print('Last Name: $lastName');
    print('Combined: $email + $firstName + $lastName');
    authCont.signUp(email,firstName,lastName);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Clear form data when going back
        _firstNameController.clear();
        _lastNameController.clear();
        return true;
      },
      child: SafeArea(
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
                      // Clear form data when going back
                      _firstNameController.clear();
                      _lastNameController.clear();
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
                  Text('Enter Name',
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'PlusJakartaSans'
                    ),
                  ),
                  SizedBox(height: 10..h,),
                  Text('Email: ${widget.email}',
                    style: TextStyle(
                        color: AppColors.black.withOpacity(0.6),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'PlusJakartaSans'
                    ),
                  ),
                  SizedBox(height: 20..h,),
                  Focus(
                    onFocusChange: (hasFocus){
                      setState(() {});
                    },
                    child: TextField(
                      controller: _firstNameController,
                      focusNode: _firstNameFocusNode,
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        floatingLabelBehavior: FloatingLabelBehavior.always, // Always float
                        labelStyle: TextStyle(
                          color: _firstNameFocusNode.hasFocus ? AppColors.primaryColor : Color(0xFF6F6F6F),
                        ),
                        suffixText: '${_firstNameController.text.length}/50',
                        suffixStyle: TextStyle(
                          color: _firstNameController.text.length > 40 ? Colors.orange : Colors.grey,
                          fontSize: 12,
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
                      maxLength: 50,
                      onChanged: (value) {
                        setState(() {}); // Rebuild to update character counter
                      },
                    ),
                  ),
                  SizedBox(height: 20..h,),
                  Focus(
                    onFocusChange: (hasFocus){
                      setState(() {});
                    },
                    child: TextField(
                      controller: _lastNameController,
                      focusNode: _lastNameFocusNode,
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        floatingLabelBehavior: FloatingLabelBehavior.always, // Always float
                        labelStyle: TextStyle(
                          color: _lastNameFocusNode.hasFocus ? AppColors.primaryColor : Color(0xFF6F6F6F),
                        ),
                        suffixText: '${_lastNameController.text.length}/50',
                        suffixStyle: TextStyle(
                          color: _lastNameController.text.length > 40 ? Colors.orange : Colors.grey,
                          fontSize: 12,
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
                      maxLength: 50,
                      onChanged: (value) {
                        setState(() {}); // Rebuild to update character counter
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.265,),
                  SizedBox(height: 20..h,),
                  GestureDetector(
                      onTap: _handleNextButtonClick,
                      child: Button1(text: 'Next'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
