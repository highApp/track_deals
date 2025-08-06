import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';
import '../customWidgets/customText.dart';

class HomeScreenItems extends StatefulWidget {
  const HomeScreenItems({super.key});

  @override
  State<HomeScreenItems> createState() => _HomeScreenItemsState();
}

class _HomeScreenItemsState extends State<HomeScreenItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260..h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
                color: AppColors.black.withOpacity(.25),
                blurRadius: 4
            )
          ],
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 170..h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/image1.png'),
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                ),
              ),
              Positioned(
                bottom: 8..h,
                left: 8..w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(.9),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            blurRadius: 4
                        )
                      ]
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svgIcons/blue.svg'),
                      SizedBox(width: 10..w,),
                      Text1(text: '2°',
                        color: Color(0xFF2664EB),
                      ),
                      SizedBox(width: 10..w,),
                      SvgPicture.asset('assets/svgIcons/red.svg'),
                    ],
                  ),
                ),
              ),
              Positioned(
                  right: 12..w,
                  top: 12..w,
                  child: SvgPicture.asset('assets/svgIcons/bookmark.svg'))
            ],
          ),
          Container(
            height: 89..h,
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text1(text: '5 free Calming chews for pets',
                          fontSize: 14..sp,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text1(text: '\$125',
                              fontSize: 14..sp,
                              color: AppColors.primaryColor,
                            ),
                            SizedBox(width: 5..w,),
                            Stack(
                              children: [
                                SizedBox(
                                  child: Text2(text: '\$250',
                                    color: AppColors.black.withOpacity(.6),
                                    fontSize: 11..sp,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  child: Container(
                                    height: 1..h,
                                    width: 30..w,
                                    decoration: BoxDecoration(
                                      color: AppColors.black.withOpacity(.6),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: 10..w,),
                            SvgPicture.asset('assets/svgIcons/truck.svg'),
                            Text2(text: '\$10',
                              fontSize: 10..sp,
                              color: AppColors.black.withOpacity(.6),
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Text1(text: 'Get Deal',
                            color: AppColors.white,
                            fontSize: 12..sp,
                          ),
                          SizedBox(width: 5..w,),
                          SvgPicture.asset('assets/svgIcons/share.svg')

                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 15..h,
                          width: 15..w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: AssetImage('assets/images/image3.png'))
                          ),
                        ),
                        Text1(text: 'Posted by william jhonshon',
                          color: AppColors.black.withOpacity(.6),
                          fontSize: 10..sp,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/svgIcons/mm.svg'),
                        Text1(text: '10',
                          color: Color(0xFF666666),
                          fontSize: 10..sp,
                        ),
                        SizedBox(width: 10..w,),
                        Text1(text: 'Posted 6h ago',
                          color: AppColors.black.withOpacity(.4),
                          fontSize: 10..sp,
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
