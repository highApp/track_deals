import 'package:flutter/material.dart';
import '../constants/colors.dart';

class DropDownList extends StatefulWidget {
  final String text;
  final String? text2;

  const DropDownList({
    super.key,
    required this.text,
    this.text2,
  });

  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  // Example list of options
  final List<String> options = ['Option 1', 'Option 2', 'Option 3'];

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

  void _showOptions() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: options.map((option) {
            return ListTile(
              title: Text(option),
              onTap: () {
                Navigator.pop(context, option);
              },
            );
          }).toList(),
        );
      },
    );

    if (selected != null) {
      setState(() {
        _controller.text = selected;
      });
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
        readOnly: true,
        onTap: _showOptions,
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
          suffixIcon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
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
