import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';
import '../customWidgets/customText.dart';
import '../contoller/homeController/home_data_model.dart';

class HomeScreenItems extends StatefulWidget {
  final Deals? deal;
  
  const HomeScreenItems({super.key, this.deal});

  @override
  State<HomeScreenItems> createState() => _HomeScreenItemsState();
}

class _HomeScreenItemsState extends State<HomeScreenItems> {
  @override
  Widget build(BuildContext context) {
    final deal = widget.deal;
    
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
                    image: DecorationImage(
                      image: deal?.images != null && deal!.images!.isNotEmpty
                          ? NetworkImage(deal.images!.first)
                          : AssetImage('assets/images/image1.png') as ImageProvider,
                      fit: BoxFit.cover,
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
                      Text1(text: '${deal?.likes ?? 0}°',
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            deal?.title ?? 'No Title',
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 14..sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'PlusJakartaSans',
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4..h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (deal?.discountPrice != null && deal!.discountPrice!.isNotEmpty)
                                Text1(
                                  text: '\$${deal.discountPrice}',
                                  fontSize: 14..sp,
                                  color: AppColors.primaryColor,
                                ),
                              if (deal?.price != null && deal!.price!.isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.only(left: 8..w),
                                  child: Text(
                                    '\$${deal.price}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12..sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'PlusJakartaSans',
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
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
                              image: DecorationImage(
                                image: deal?.user?.profileImage != null && deal!.user!.profileImage!.isNotEmpty
                                    ? NetworkImage(deal.user!.profileImage!)
                                    : AssetImage('assets/images/image3.png') as ImageProvider,
                                fit: BoxFit.cover,
                              )
                          ),
                        ),
                        SizedBox(width: 5..w),
                        Text1(
                          text: deal?.user != null 
                              ? 'Posted by ${deal!.user!.firstName ?? ''} ${deal.user!.lastName ?? ''}'
                              : 'Posted by Unknown',
                          color: AppColors.black.withOpacity(.6),
                          fontSize: 10..sp,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/svgIcons/mm.svg'),
                        Text1(
                          text: '${deal?.commentsCount ?? 0}',
                          color: Color(0xFF666666),
                          fontSize: 10..sp,
                        ),
                        SizedBox(width: 10..w,),
                        if (deal?.location != null && deal!.location!.isNotEmpty)
                          Text1(
                            text: deal.location!,
                            color: AppColors.black.withOpacity(.4),
                            fontSize: 10..sp,
                          )
                        else
                          Text1(
                            text: 'Location N/A',
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
