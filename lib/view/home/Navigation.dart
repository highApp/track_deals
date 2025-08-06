import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/customText.dart';
import 'package:trackdeal/view/home/Discussion.dart';
import 'package:trackdeal/view/home/Profile.dart';
import 'package:trackdeal/view/home/home_screen.dart';
import 'package:trackdeal/view/home/messages.dart';
import 'package:trackdeal/view/home/post_discussion/submit_discussion.dart';
import 'package:trackdeal/view/post_a_coupon/submit_coupon1.dart';
import 'package:trackdeal/view/post_a_deal/submit_deal_1.dart';


class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentTab = 0;

  List _pages = [
    HomeScreen(),
    Discussion(),
    SizedBox(),
    Messages(),
    Profile(),
  ];

  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // drag handle
              Container(
                width: 70,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 15),
              Text2(text: 'What would you like to eat ?',
              fontSize: 16..sp,
              ),
              SizedBox(height: 15),
              Container(
                height: 1..h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.2)
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitDeal1(),));
                },
                child: Padding(
                  padding:EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svgIcons/18.svg'),
                        SizedBox(width: 30..w,),
                        Text2(text: 'Post a deal',)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20..h,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitCoupon1(),));
                },
                child: Padding(
                  padding:EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svgIcons/19.svg'),
                        SizedBox(width: 30..w,),
                        Text2(text: 'Post a coupon',)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20..h,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitDiscussion(),));
                },
                child: Padding(
                  padding:EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svgIcons/20.svg'),
                        SizedBox(width: 30..w,),
                        Text2(text: 'Post a discussion',)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20..h,),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentTab],
      bottomNavigationBar: Container(
        height: 75..h,
        decoration: BoxDecoration(
          color: AppColors.white
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.white,
          currentIndex: currentTab,
          onTap: (index) {
            if (index == 2) {
              _showCustomBottomSheet(context);
            } else {
              setState(() {
                currentTab = index;
              });
            }
          },
          type: BottomNavigationBarType.fixed, // important for 5 items
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Color(0xFF999999),
          selectedLabelStyle: TextStyle(
            fontSize: 10..sp,
            fontWeight: FontWeight.w600,

          ),
          unselectedLabelStyle: TextStyle(
              fontSize: 10..sp,
              fontWeight: FontWeight.w400),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svgIcons/home.svg',
                color: currentTab == 0 ? AppColors.primaryColor : Color(0xFF999999),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svgIcons/discus.svg',
                color: currentTab == 1 ? AppColors.primaryColor : Color(0xFF999999),
              ),
              label: 'Discussion',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svgIcons/post.svg',
                color: currentTab == 2 ? AppColors.primaryColor : Color(0xFF999999),
              ),
              label: 'Post',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svgIcons/message.svg',
                color: currentTab == 3 ? AppColors.primaryColor : Color(0xFF999999),
              ),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svgIcons/profile.svg',
                color: currentTab == 4 ? AppColors.primaryColor : Color(0xFF999999),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
