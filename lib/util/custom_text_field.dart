import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.height,
    this.borderRadius,
    this.maxLines,
    this.padding,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final double? height;
  final BorderRadius? borderRadius;
  final int? maxLines;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
      ),
      child: TextFormField(
        autofocus: true,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
        controller: controller,
      ),
    );
  }
}