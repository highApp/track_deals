
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/view/splash2.dart';

class Splash1 extends StatefulWidget {
  const Splash1({super.key});
  @override
  State<Splash1> createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Splash2())
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Text('TrackDeals',
        style: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 40,
          fontWeight: FontWeight.w700,
          fontFamily: 'MontserratAlternates'
        ),),
      ),
    );
  }
}
