import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_colors.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    Key? key,
    required this.controller,
    this.label,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.readOnly,
    this.maxLine,
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final FocusNode? focusNode;
  final IconData? prefixIcon, suffixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final int? maxLine;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLine ?? 1,
      readOnly: widget.readOnly ?? false,
      controller: widget.controller,
      style: const TextStyle(fontSize: 18),
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      validator: widget.validator ?? (value) => null,
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        fillColor: AppColors.appGreyColor,
        filled: true,
        hintText: widget.label ?? "",
        prefixIcon: widget.prefixIcon != ""
            ? Icon(
                widget.prefixIcon,
                size: 28,
                color: AppColors.primaryColor,
              )
            : SizedBox(),
        suffixIcon: Icon(
          widget.suffixIcon,
          size: 28,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
