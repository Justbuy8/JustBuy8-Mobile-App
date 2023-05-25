// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/utils/Secure_Storage.dart';
import 'package:justbuyeight/screens/authentication/signin_screen.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button.dart';

class SecondaryAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const SecondaryAppbarWidget({
    Key? key,
    required this.title,
    required this.leadingIcon,
    required this.trailingIcon,
    this.leadingIconOnPressed,
    this.trailingIconOnPressed,
  }) : super(key: key);
  final String title;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final VoidCallback? leadingIconOnPressed;
  final VoidCallback? trailingIconOnPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appWhiteColor,
      foregroundColor: AppColors.appBlackColor,
      elevation: 0.0,
      automaticallyImplyLeading: true,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          // fontWeight: FontWeight.bold,
          fontFamily: AppFonts.robotoMonoBold,
        ),
      ),
      leading: IconButton(
        onPressed: leadingIconOnPressed ?? () {},
        icon: Icon(leadingIcon),
      ),
      actions: [
        IconButton(
          onPressed: trailingIconOnPressed ?? () {},
          icon: Icon(trailingIcon),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
