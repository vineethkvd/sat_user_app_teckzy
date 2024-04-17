import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../configs/styles/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String? Function(String?)? validateInput;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? contentPadding;
  final bool obscureText;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    this.contentPadding = const EdgeInsets.fromLTRB(13, 14, 13, 14),
    this.controller,
    this.validateInput,
    this.obscureText = false,
    this.hintText,
    this.prefixIcon,
    this.keyboardType,
    this.suffixIcon,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      validator: widget.validateInput,
      controller: widget.controller,
      obscureText: widget.obscureText,

      cursorColor: AppColor.appMainColor, // Set the cursor color here
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        hintStyle: const TextStyle(
          color: Color(0xFF616161),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: widget.contentPadding,
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: const OutlineInputBorder(),
      ),
    );
  }
}
