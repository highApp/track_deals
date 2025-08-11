import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';

import '../constants/colors.dart';
import '../main.dart';

String notificationAccessToken="";


String formatPrice(String price) {
  final number = double.tryParse(price) ?? 0.0; // Convert string to double
  final formatter = NumberFormat("#,##0");   // Format with commas and two decimals
  return formatter.format(number);
}
errorAlertToast(String error) {
  Fluttertoast.showToast(
      msg: error,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.primaryColor,
      textColor: Colors.white,
      fontSize: 16.0);
}


showLoading() {
  final context = navigatorKey.currentContext;
  if (context == null) {
    print('Warning: Context is null, cannot show loading dialog');
    return;
  }
  
  showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.white,
          shadowColor: Colors.black,
          elevation: 2,
          insetPadding: EdgeInsets.symmetric(horizontal: 100),
          child: SizedBox(
            height: 50,
            child: SpinKitThreeInOut(
              color: Colors.black,
              size: 30.0,
            ),
          ),
        );
      });
}


