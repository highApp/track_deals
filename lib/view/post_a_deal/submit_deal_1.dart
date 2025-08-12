import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/customText.dart';
import 'package:trackdeal/customWidgets/custom_button.dart';
import 'package:trackdeal/utils/text_field_custom.dart';
import 'package:trackdeal/view/post_a_deal/submit_deal2.dart';
import 'package:http/http.dart' as http;

class SubmitDeal1 extends StatefulWidget {
  const SubmitDeal1({super.key});

  @override
  State<SubmitDeal1> createState() => _SubmitDeal1State();
}

class _SubmitDeal1State extends State<SubmitDeal1> {
  final TextEditingController _dealLinkController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _dealLinkError;
  bool _isValidating = false;

  Future<bool> _isValidUrl(String url) async {
    if (url.isEmpty) return false;
    
    // First check if it's a valid URL format
    try {
      Uri uri = Uri.parse(url);
      // Check if it has a scheme (http/https)
      if (uri.scheme.isEmpty) {
        // Try adding https:// if no scheme is provided
        url = 'https://$url';
        uri = Uri.parse(url);
      }
    } catch (e) {
      return false;
    }
    
    // Then check if the URL is actually accessible
    try {
      setState(() {
        _isValidating = true;
      });
      
      final response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 10),
      );
      
      setState(() {
        _isValidating = false;
      });
      
      // Check if response is successful (status code 200-299)
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      setState(() {
        _isValidating = false;
      });
      return false;
    }
  }

  void _validateAndNavigate() async {
    setState(() {
      _dealLinkError = null;
    });

    if (_dealLinkController.text.trim().isEmpty) {
      setState(() {
        _dealLinkError = 'Deal link is required';
      });
      return;
    }

    String urlToValidate = _dealLinkController.text.trim();
    
    // Check if URL is accessible
    bool isValid = await _isValidUrl(urlToValidate);
    
    if (!isValid) {
      setState(() {
        _dealLinkError = 'Please enter a valid and accessible URL';
      });
      return;
    }

    // Get the final validated URL (might have https:// added)
    String finalUrl = urlToValidate;
    if (!urlToValidate.startsWith('http://') && !urlToValidate.startsWith('https://')) {
      finalUrl = 'https://$urlToValidate';
    }

    // Print the deal link
    print('Deal Link: $finalUrl');
    
    // Navigate to SubmitDeal2 with the deal link
    if (mounted) {
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => SubmitDeal2(dealLink: finalUrl),
        )
      );
    }
  }

  @override
  void dispose() {
    _dealLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
            child: Form(
              key: _formKey,
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
                            Container(
                              width: MediaQuery.of(context).size.width*.23,
                              height: 2..h,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.1)
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
                                  color: Colors.black.withOpacity(.1),
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
                            ),
                            Container(
                              height: 10..h,
                              width: 10..w,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.1),
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
                  Text2(text: 'Share a deal with millions of people',
                  fontSize: 20..sp,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.start,
                  ),
                  Text2(text: 'Paste link to where other users can get more information on the deal',
                  fontSize: 14..sp,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 25..h,),
                  TextFieldCustom(
                    text: 'Deal Link',
                    text2: 'https://www.site.com/greatdeal...',
                    controller: _dealLinkController,
                    errorText: _dealLinkError,
                  ),
                  _dealLinkError != null
                      ? Padding(
                          padding: EdgeInsets.only(top: 8..h, left: 15..w),
                          child: Text(
                            _dealLinkError!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12..sp,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  SizedBox(height: 50..h,),
                  GestureDetector(
                      onTap: _isValidating ? null : _validateAndNavigate,
                      child: Button1(
                        text: _isValidating ? 'Validating...' : 'Get Started',
                      ),
                    ),
                  SizedBox(height: 30..h,),
                  Text2(text: 'I don\'t have link',
                  fontSize: 16..sp,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
