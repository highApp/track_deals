import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/customText.dart';
import 'package:trackdeal/utils/drawer.dart';
import 'package:trackdeal/utils/home_screen_items.dart';
import 'package:trackdeal/view/home/productDetail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedIndex = 0;
  final icons = ['6.svg', '7.svg', '8.svg'];
  final labels = ['All', 'Hottest', 'Trending'];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerCustom(),
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding:EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(height: 20..h,),
                Row(
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
                          Text1(text: 'Deals',
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
                SizedBox(height: 25..h,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 6),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(3, (index) {

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: SizedBox(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svgIcons/${icons[index]}',
                                color: selectedIndex == index ? AppColors.white : Colors.black,
                              ),
                              SizedBox(width: 5..w),
                              Text2(
                                text: labels[index],
                                fontSize: 12..sp,
                                color: selectedIndex == index ? AppColors.white : Colors.black,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 15..h,),
                SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context,index)=>
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(),));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: HomeScreenItems(),
                        )),

                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
