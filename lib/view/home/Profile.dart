import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/customText.dart';
import 'package:trackdeal/utils/drawer.dart';
import 'package:trackdeal/utils/home_screen_items.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white.withOpacity(.97),
        key: _scaffoldKey,
        drawer: DrawerCustom(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20..h,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: (){
                                _scaffoldKey.currentState?.openDrawer();
                              },
                              child: SvgPicture.asset('assets/svgIcons/drawer.svg')),
                          SizedBox(width: 15..w,),
                          Text1(text: 'Profile',
                            fontSize: 20..sp,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/svgIcons/search.svg'),
                          SizedBox(width: 5..w,),
                          SvgPicture.asset('assets/svgIcons/bell.svg'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 25..h,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            blurRadius: 1
                        )
                      ]
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text2(text: 'Joined:20/07/25',
                          fontSize: 12..sp,
                            fontWeight: FontWeight.w200,
                            color: Colors.black.withOpacity(.7),
                          ),
                          SvgPicture.asset('assets/svgIcons/31.svg'),
                        ],
                      ),
                      Center(
                        child: Container(
                          height: 115..h,
                          width: 115..w,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black.withOpacity(.1),
                              width: 8
                            ),
                            image: DecorationImage(image: AssetImage('assets/images/image6.png'))
                          ),

                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text1(text: 'John smith',
                          fontSize: 20..sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(width: 10..w,),
                          SvgPicture.asset('assets/svgIcons/32.svg'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/svgIcons/33.svg'),
                          SizedBox(width: 5..w,),
                          Text2(text: 'Deal',
                          fontSize: 12..sp,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(width: 5..w,),
                          Text2(text: '250',
                            fontSize: 12..sp,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(width: 5..w,),
                          SvgPicture.asset('assets/svgIcons/34.svg'),
                          SizedBox(width: 5..w,),
                          Text2(text: 'Comments',
                            fontSize: 12..sp,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(width: 5..w,),
                          Text2(text: '100',
                            fontSize: 12..sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      SizedBox(height: 2..h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/svgIcons/35.svg'),
                          SizedBox(width: 5..w,),
                          Text2(text: 'followers',
                            fontSize: 12..sp,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(width: 5..w,),
                          Text2(text: '17',
                            fontSize: 12..sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      SizedBox(height: 10..h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30..w,vertical: 8..h),
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/svgIcons/36.svg'),
                                SizedBox(width: 3..w,),
                                Text2(text: 'Follow',
                                  fontSize: 14..sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10..w,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30..w,vertical: 8..h),
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/svgIcons/37.svg'),
                                SizedBox(width: 3..w,),
                                Text2(text: 'Message',
                                  fontSize: 14..sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10..h,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.25),
                        blurRadius: 1
                      )
                    ]
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: AppColors.primaryColor,
                    labelColor: AppColors.primaryColor,
                    unselectedLabelColor: Colors.black,

                    tabs: const [
                      Tab(text: "Deals"),
                      Tab(text: "Discussions"),
                      Tab(text: "Badges"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10..h,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  height: 700..h,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(2),
                          itemCount: 3,
                          itemBuilder: (context,index) => Padding(
                            padding:  EdgeInsets.only(bottom: 10),
                            child: HomeScreenItems(),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(2),
                          itemCount: 3,
                          itemBuilder: (context,index) => Padding(
                            padding:  EdgeInsets.only(bottom: 10),
                            child: HomeScreenItems(),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(2),
                          itemCount: 3,
                          itemBuilder: (context,index) => Padding(
                            padding:  EdgeInsets.only(bottom: 10),
                            child: HomeScreenItems(),
                          ),
                        ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
