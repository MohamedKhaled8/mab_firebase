import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonLocal extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final double higth;
  final double width;
  final Color colorText;
  final double size;
  final Color? colorButtom;
  const CustomButtonLocal({
    Key? key,
    required this.text,
    this.onTap,
    required this.higth,
    required this.width,
    required this.colorText,
    required this.size,
    this.colorButtom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: higth.h,
        width: width.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: colorButtom),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: colorText, fontSize: size),
          ),
        ),
      ),
    );
  }
}
