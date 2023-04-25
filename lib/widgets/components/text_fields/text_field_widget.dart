import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_colors.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    Key? key,
    required this.controller,
    this.label,
    this.focusNode,
    this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputAction,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final FocusNode? focusNode;
  final bool? obscureText;
  final IconData? prefixIcon, suffixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool? isObscure;
  @override
  void initState() {
    isObscure = widget.obscureText ?? false;
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: AppColors.appGreyColor,
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode ?? FocusNode(),
        obscureText: isObscure!,
        textInputAction: widget.textInputAction ?? TextInputAction.done,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        validator: widget.validator ?? (value) => null,
        decoration: InputDecoration(
          labelText: widget.label ?? "",
          prefixIcon: Icon(widget.prefixIcon),
          suffixIcon: GestureDetector(
            onTap: () {
              if (widget.suffixIcon == Icons.visibility_off) {
                setState(() {
                  isObscure = !isObscure!;
                });
              } else if (widget.suffixIcon == Icons.visibility) {
                setState(() {
                  isObscure = !isObscure!;
                });
              }
            },
            child: widget.suffixIcon == Icons.visibility
                ? isObscure!
                    ? Icon(widget.suffixIcon)
                    : const Icon(
                        Icons.visibility_off,
                      )
                : Icon(widget.suffixIcon),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsetsDirectional.only(start: 20, end: 20),
        ),
      ),
    );
  }
}
