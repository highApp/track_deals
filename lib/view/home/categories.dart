import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/customText.dart';

import '../../contoller/homeController/home_controller.dart';
import '../../contoller/homeController/get_category_data.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late final HomeController homCont;
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  
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
      homCont = Get.find<HomeController>();
    } catch (e) {
      // If controller doesn't exist, create it as a singleton
      print('HomeController not found, creating new instance');
      Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
      homCont = Get.find<HomeController>();
    }
    // Categories will be loaded automatically in onInit
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xFF9EA7B8),
                            width: 1,
                          )
                      ),
                      child: SvgPicture.asset('assets/svgIcons/4.svg'),
                    ),
                  ),
                  Text2(text: 'Categories',
                  fontSize: 20..sp,
                  ),
                  SizedBox(width: 50,)
                ],
              ),
              SizedBox(height: 30..h,),
              
              // Dynamic categories list using Obx
              Obx(() {
                if (homCont.isLoadingCategories.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                }
                
                if (homCont.categories.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.category_outlined,
                          size: 50,
                          color: AppColors.black.withOpacity(0.3),
                        ),
                        SizedBox(height: 10),
                        Text2(
                          text: 'No categories available',
                          fontSize: 16,
                          color: AppColors.black.withOpacity(0.5),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () => homCont.refreshCategories(),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text2(
                              text: 'Refresh',
                              fontSize: 14,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: homCont.categories.length,
                  itemBuilder: (context, index) {
                    final category = homCont.categories[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 20..h),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withOpacity(.25),
                                  blurRadius: 1
                                )
                              ],
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: category.icon != null && category.icon!.isNotEmpty
                                ? Image.network(
                                    category.icon!,
                                    width: 24,
                                    height: 24,
                                    errorBuilder: (context, error, stackTrace) {
                                      // Fallback to default icon if network image fails
                                      return SvgPicture.asset(
                                        'assets/svgIcons/${(index % 20) + 15}.svg',
                                        width: 24,
                                        height: 24,
                                      );
                                    },
                                  )
                                : SvgPicture.asset(
                                    'assets/svgIcons/${(index % 20) + 15}.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                          ),
                          SizedBox(width: 15..w,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text2(
                                  text: category.name ?? 'Unnamed Category',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                Text2(
                                  text: '${category.id ?? 0} deals',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black.withOpacity(.5),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    super.dispose();
  }
}
