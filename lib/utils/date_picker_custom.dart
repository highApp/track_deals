import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart'; // For formatting the date
import '../constants/colors.dart';

class DatePickerCustom extends StatefulWidget {
  final String text;
  final String? text2;

  const DatePickerCustom({
    super.key,
    required this.text,
    this.text2,
  });

  @override
  State<DatePickerCustom> createState() => _DatePickerCustomState();
}

class _DatePickerCustomState extends State<DatePickerCustom> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      _controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {});
      },
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        readOnly: true, // Prevent keyboard from opening
        onTap: () => _selectDate(context),
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          labelText: widget.text,
          hintText: widget.text2,
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(.3),
            fontSize: 12,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(
            color: _focusNode.hasFocus ? AppColors.primaryColor : const Color(0xFF6F6F6F),
          ),
          suffixIcon: Container(
              padding: EdgeInsets.all(15),
              child: SvgPicture.asset('assets/svgIcons/39.svg')),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFF6F6F6F),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 1,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
        ),
      ),
    );
  }
}
