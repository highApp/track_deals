import 'package:flutter/material.dart';

import '../constants/colors.dart';

class TextFieldCustom extends StatefulWidget {

  final String text;
  final String? text2;
  final TextEditingController? controller;
  final String? errorText;
  final bool obscureText;

  const TextFieldCustom({super.key,
    required this.text,
    this.text2,
    this.controller,
    this.errorText,
    this.obscureText = false,
  });

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {

  final FocusNode _usernameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(() {setState(() {});// Rebuild when focus changes
    });
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus){
        setState(() {});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: widget.controller,
            obscureText: widget.obscureText,
            focusNode: _usernameFocusNode,
            cursorColor: AppColors.primaryColor,
            decoration: InputDecoration(
              labelText: widget.text,
              hintText: widget.text2,
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(.3),
                fontSize: 12,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always, // Always float
              labelStyle: TextStyle(
                color: _usernameFocusNode.hasFocus ? AppColors.primaryColor : Color(0xFF6F6F6F),
              ),
              errorText: widget.errorText,
              errorStyle: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: widget.errorText != null ? Colors.red : Color(0xFF6F6F6F),
                  width: 1, // Border width
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                  width: 1, // Border width on focus
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10, // Field height control
              ),
            ),
          ),
        ],
      ),
    );
  }
}
