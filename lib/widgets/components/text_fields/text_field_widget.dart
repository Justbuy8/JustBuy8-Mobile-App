import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:nb_utils/nb_utils.dart';

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
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final FocusNode? focusNode;
  final IconData? prefixIcon, suffixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height() / 15,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: AppColors.appGreyColor,
      ),
      alignment: Alignment.center,
      child: TextFormField(
        controller: widget.controller,
        style: const TextStyle(fontSize: 18),
        //focusNode: widget.focusNode ?? FocusNode(),
        //onFieldSubmitted: (value) => widget.focusNode?.nextFocus(),
        textInputAction: widget.textInputAction ?? TextInputAction.done,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        validator: widget.validator ?? (value) => null,
        decoration: InputDecoration(
          hintText: widget.label ?? "",
          prefixIcon: Icon(widget.prefixIcon,size: 28,color: AppColors.primaryColor,),
          suffixIcon: Icon(widget.suffixIcon,size:  28,),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
