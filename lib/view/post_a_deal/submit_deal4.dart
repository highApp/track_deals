import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/customText.dart';
import 'package:trackdeal/customWidgets/custom_button.dart';
import 'package:trackdeal/utils/text_field_custom.dart';
import 'package:trackdeal/view/post_a_deal/submit_deal2.dart';
import 'package:trackdeal/view/post_a_deal/submit_deal5.dart';

class SubmitDeal4 extends StatefulWidget {
  final Map<String, dynamic> dealData;
  
  const SubmitDeal4({super.key, required this.dealData});

  @override
  State<SubmitDeal4> createState() => _SubmitDeal4State();
}

class _SubmitDeal4State extends State<SubmitDeal4> {
  final TextEditingController _descriptionController = TextEditingController();

  void _navigateToSubmitDeal5() {
    // Validate description
    String description = _descriptionController.text.trim();
    
    if (description.isEmpty) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a description for your deal'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }
    
    if (description.length < 20) {
      // Show error message for too short description
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Description must be at least 20 characters long'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }
    
    // Create updated deal data with description
    Map<String, dynamic> updatedDealData = Map.from(widget.dealData);
    updatedDealData['description'] = description;
    
    // Print data for debugging
    print('=== SubmitDeal4 - Data being passed to SubmitDeal5 ===');
    print('Description: ${updatedDealData['description']}');
    print('Description length: ${updatedDealData['description'].length}');
    print('Total data keys: ${updatedDealData.keys.toList()}');
    print('===============================');
    
    // Navigate to SubmitDeal5 with all data
    Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitDeal5(dealData: updatedDealData)));
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: 80..h,
          decoration: BoxDecoration(
              color: Colors.white
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  height: 45..h,
                  width: 130..w,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xFF6F6F6F),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text2(text: 'Back',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 70..w,),
              GestureDetector(
                onTap: _navigateToSubmitDeal5,
                child: Container(
                  height: 45..h,
                  width: 130..w,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text2(text: 'Next',
                      fontSize: 12,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    Text2(text: 'Submit a deal',
                      fontSize: 20..sp,
                    ),
                    SizedBox(width: 50,)
                  ],
                ),
                SizedBox(height: 30..h,),
                Stack(
                  children: [
                    Positioned(
                      top: 4..h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*.23,
                            height: 2..h,
                            decoration: BoxDecoration(
                                color:AppColors.primaryColor
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*.23,
                            height: 2..h,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*.23,
                            height: 2..h,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*.23,
                            height: 2..h,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.1)
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 10..h,
                            width: 10..w,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle
                            ),
                          ),
                          Container(
                            height: 10..h,
                            width: 10..w,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle
                            ),
                          ),
                          Container(
                            height: 10..h,
                            width: 10..w,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle
                            ),
                          ),
                          Container(
                            height: 10..h,
                            width: 10..w,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle
                            ),
                          ),
                          Container(
                            height: 10..h,
                            width: 10..w,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.1),
                                shape: BoxShape.circle
                            ),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 20..h,),
                Text2(text: 'Description',
                  fontSize: 20..sp,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 20..h,),
                
                // Display previous form data summary
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15..w),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text2(
                        text: 'Deal Summary',
                        fontSize: 16..sp,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 10..h),
                      Text('Link: ${widget.dealData['dealLink']}', style: TextStyle(fontSize: 12..sp)),
                      Text('Title: ${widget.dealData['title']}', style: TextStyle(fontSize: 12..sp)),
                      Text('Price: \$${widget.dealData['price']}', style: TextStyle(fontSize: 12..sp)),
                      widget.dealData['nextBestPrice'] != null
                          ? Text('Next Best Price: \$${widget.dealData['nextBestPrice']}', style: TextStyle(fontSize: 12..sp))
                          : SizedBox.shrink(),
                      widget.dealData['couponCode'].isNotEmpty
                          ? Text('Coupon: ${widget.dealData['couponCode']}', style: TextStyle(fontSize: 12..sp))
                          : SizedBox.shrink(),
                      Text('Type: ${widget.dealData['availability']}', style: TextStyle(fontSize: 12..sp)),
                      Text('Location: ${widget.dealData['location']}', style: TextStyle(fontSize: 12..sp)),
                      widget.dealData['shippingFrom'] != null
                          ? Text('Shipping: ${widget.dealData['shippingFrom']}', style: TextStyle(fontSize: 12..sp))
                          : SizedBox.shrink(),
                      Text('Images: ${widget.dealData['images']?.length ?? 0} images', style: TextStyle(fontSize: 12..sp)),
                    ],
                  ),
                ),
                SizedBox(height: 20..h,),
                
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 380..h,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xFF6F6F6F),
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: null,
                    maxLength: 500,
                    onChanged: (value) {
                      setState(() {
                        // Trigger rebuild to update character count
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Here you can describe the deal i our own words and explain to other users why it’s a god deal! Please give as much useful info as yo can...',
                      hintStyle: TextStyle(
                        fontSize: 14..sp,
                        color: Colors.black.withOpacity(.5)
                      )
                    ),
                  ),
                ),
                
                // Character counter and validation
                SizedBox(height: 10..h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text2(
                      text: '${_descriptionController.text.length}/500 characters',
                      fontSize: 12..sp,
                      color: _descriptionController.text.length >= 20 
                          ? Colors.green 
                          : _descriptionController.text.length > 0 
                              ? Colors.orange 
                              : Colors.grey,
                    ),
                    if (_descriptionController.text.isNotEmpty)
                      Row(
                        children: [
                          Icon(
                            _descriptionController.text.length >= 20 
                                ? Icons.check_circle 
                                : Icons.warning,
                            color: _descriptionController.text.length >= 20 
                                ? Colors.green 
                                : Colors.orange,
                            size: 16..sp,
                          ),
                          SizedBox(width: 5..w),
                          Text2(
                            text: _descriptionController.text.length >= 20 
                                ? 'Valid' 
                                : 'Min 20 chars',
                            fontSize: 12..sp,
                            color: _descriptionController.text.length >= 20 
                                ? Colors.green 
                                : Colors.orange,
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
