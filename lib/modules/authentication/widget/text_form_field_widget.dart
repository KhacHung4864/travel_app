import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/configs/app_fonts.dart';
import 'package:travel_app/configs/palette.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.icon,
    required this.validator,
    required this.title,
    this.keyboardType,
    this.maxline,
  });
  final int? maxline;
  final String title;
  final TextEditingController controller;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.title == 'Password' ? isObsecure : false,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
          errorStyle: AppFont.t.red.s(13),
          hintText: widget.title,
          suffixIcon: widget.title == 'Password'
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isObsecure = !isObsecure;
                    });
                  },
                  child: Icon(
                    isObsecure ? Icons.visibility : Icons.visibility_off,
                    color: Palette.black7C838D,
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.sp),
            borderSide: const BorderSide(color: Colors.white60),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.sp),
            borderSide: const BorderSide(color: Colors.white60),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.sp),
            borderSide: const BorderSide(color: Colors.white60),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.sp),
            borderSide: const BorderSide(color: Colors.white60),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 18,
          ),
          fillColor: Palette.blackF6F6F8,
          filled: true),
      validator: widget.validator,
    );
  }
}
