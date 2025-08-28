import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/customText.dart';
import 'package:trackdeal/utils/drawer.dart';
import 'package:trackdeal/utils/home_screen_items.dart';
import 'package:trackdeal/utils/shared_prefs_helper.dart';
import 'package:trackdeal/contoller/authController/model/user_login_data.dart';
import 'package:trackdeal/api/api_client.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final TabController _tabController;
  UserLoginData? userData;
  bool isLoading = true;
  bool isPickingImage = false;
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await SharedPrefsHelper.getUserLoginData();
      setState(() {
        userData = user;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString().substring(2)}';
    } catch (e) {
      return 'N/A';
    }
  }

  Future<void> _pickImage() async {
    if (isPickingImage) return;
    
    setState(() {
      isPickingImage = true;
    });
    
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );
      
      if (image != null) {
        setState(() {
          selectedImage = File(image.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      // You can show a snackbar or toast here for better UX
    } finally {
      setState(() {
        isPickingImage = false;
      });
    }
  }

  void _resetImage() {
    setState(() {
      selectedImage = null;
    });
  }

  Future<void> _saveProfileImage() async {
    if (selectedImage == null) return;
    
    setState(() {
      isPickingImage = true;
    });
    
    try {
      // Get user data and token
      final user = await SharedPrefsHelper.getUserLoginData();
      
      if (user == null || user.accessToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User not authenticated. Please login again.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }
      
      // Create API client and update header with bearer token
      final apiClient = ApiClient(appBaseUrl: "https://truckdeals.highapp.co.uk/");
      apiClient.updateHeader(user.accessToken!);
      
      print('Debug: Using token: ${user.accessToken}');
      print('Debug: User ID: ${user.userId}');
      print('Debug: Email: ${user.email}');
      
      // Prepare the request body
      final body = {
        'user_id': user.userId.toString(),
        'email': user.email,
        // Add any other required fields for profile update
        'first_name': user.firstName ?? '',
        'last_name': user.lastName ?? '',
        'address': user.address ?? '',
      };
      
      print('Debug: Request body: $body');
      print('Debug: Image path: ${selectedImage!.path}');
      
      // Upload the image using the correct API endpoint and parameter
      final response = await apiClient.postWithForm(
        'api/edit-profile', // Updated API endpoint
        body,
        image: [selectedImage!.path],
        imageKey: 'profile_picture', // Updated image parameter
        showdialog: true,
      );
      
      print('Debug: API Response status: ${response.statusCode}');
      print('Debug: API Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Success - update local user data
        // Extract server image URL from response
        String? serverImageUrl;
        var data = jsonDecode(response.bodyString??"");
        print('AuthController: Parsed response data: $data');

        UserLoginData loginData = UserLoginData.fromJson(data);
        serverImageUrl=loginData.profileImage;
        // if (response.body != null && response.body['data'] != null) {
        //   serverImageUrl = response.body['data']['profile_picture'] ??
        //                   response.body['data']['profile_image'] ??
        //                   response.body['profile_picture'] ??
        //                   response.body['profile_image'];
        // }
        
        final updatedUser = UserLoginData(
          status: user.status,
          message: user.message,
          accessToken: user.accessToken,
          tokenType: user.tokenType,
          userId: user.userId,
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.email,
          profileImage: serverImageUrl ?? user.profileImage, // Save server path if available, otherwise keep existing
          address: user.address,
          deviceToken: user.deviceToken,
          createdAt: user.createdAt,
        );
        print('imageURL save Link${user.profileImage}');
        // Save updated user data
        await SharedPrefsHelper.saveUserLoginData(updatedUser);
        
        // Update the UI
        setState(() {
          userData = updatedUser;
          selectedImage = null;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile image updated successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // Handle error
        String errorMessage = 'Failed to update profile image';
        if (response.body != null && response.body['message'] != null) {
          errorMessage = response.body['message'];
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print('Error uploading profile image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading image. Please try again.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() {
        isPickingImage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white.withOpacity(.97),
        key: _scaffoldKey,
        drawer: DrawerCustom(),
        body: isLoading 
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                              Text2(text: 'Joined: ${_formatDate(userData?.createdAt)}',
                              fontSize: 12..sp,
                                fontWeight: FontWeight.w200,
                                color: Colors.black.withOpacity(.7),
                              ),
                              SvgPicture.asset('assets/svgIcons/31.svg'),
                            ],
                          ),
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  height: 115..h,
                                  width: 115..w,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.black.withOpacity(.1),
                                      width: 8
                                    ),
                                    image: selectedImage != null
                                      ? DecorationImage(
                                          image: FileImage(selectedImage!),
                                          fit: BoxFit.cover,
                                        )
                                      : userData?.profileImage != null && userData!.profileImage!.isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(userData!.profileImage!),
                                            fit: BoxFit.cover,
                                            onError: (exception, stackTrace) {
                                              // Fallback to default image if network image fails
                                            },
                                          )
                                        : DecorationImage(image: AssetImage('assets/images/image6.png'))
                                  ),
                                  child: selectedImage != null
                                    ? GestureDetector(
                                        onLongPress: _resetImage,
                                        child: Tooltip(
                                          message: 'Long press to reset image',
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(0.3),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.refresh,
                                                color: Colors.white,
                                                size: 30..sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : null,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: _pickImage,
                                    child: Tooltip(
                                      message: 'Tap to select profile image',
                                      child: Container(
                                        height: 35..h,
                                        width: 35..w,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 3,
                                          ),
                                        ),
                                        child: isPickingImage
                                          ? SizedBox(
                                              height: 20..h,
                                              width: 20..w,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                              ),
                                            )
                                          : Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 20..sp,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Save button for selected image
                          if (selectedImage != null)
                            Padding(
                              padding: EdgeInsets.only(top: 15..h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20..w, vertical: 8..h),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: GestureDetector(
                                      onTap: _saveProfileImage,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.save,
                                            color: Colors.white,
                                            size: 16..sp,
                                          ),
                                          SizedBox(width: 5..w),
                                          Text2(
                                            text: 'Save Image',
                                            color: Colors.white,
                                            fontSize: 14..sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10..w),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20..w, vertical: 8..h),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: GestureDetector(
                                      onTap: _resetImage,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.close,
                                            color: Colors.black87,
                                            size: 16..sp,
                                          ),
                                          SizedBox(width: 5..w),
                                          Text2(
                                            text: 'Cancel',
                                            color: Colors.black87,
                                            fontSize: 14..sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text1(text: '${userData?.firstName ?? 'User'} ${userData?.lastName ?? ''}',
                              fontSize: 20..sp,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(width: 10..w,),
                              SvgPicture.asset('assets/svgIcons/32.svg'),
                            ],
                          ),
                          if (userData?.email != null && userData!.email!.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: 5..h),
                              child: Text2(
                                text: userData!.email!,
                                fontSize: 14..sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(.6),
                              ),
                            ),
                          if (userData?.address != null && userData!.address!.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: 5..h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on, size: 16..sp, color: Colors.black.withOpacity(.6)),
                                  SizedBox(width: 5..w,),
                                  Text2(
                                    text: userData!.address!,
                                    fontSize: 12..sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(.6),
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(height: 15..h,),
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
                              Text2(text: userData!.totalDeals.toString()!,
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
                              Text2(text: userData!.totalComments.toString()!,
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
