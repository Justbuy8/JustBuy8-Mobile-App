// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/models/myaccount/myaccount_model.dart';
import 'package:justbuyeight/screens/maintabs/my_account/widgets/profile_widget.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/mobile_number_text_field.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class EditProfileScreen extends StatefulWidget {
  List<MyAccountModel> myAccountModel;

  EditProfileScreen({required this.myAccountModel});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final formGlobalKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberContorller = TextEditingController();

  assigneValues() {
    _firstNameController.text = widget.myAccountModel.first.data.firstName;
    _emailController.text = widget.myAccountModel.first.data.email;
    _phoneNumberContorller.text = widget.myAccountModel.first.data.phone;
    _lastNameController.text = widget.myAccountModel.first.data.lastName;
  }

  @override
  void initState() {
    assigneValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbarWidget(
        title: 'Profile Edit',
      ),
      body: Form(
        key: formGlobalKey,
        child: ListView(
          padding:
              EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h, top: 20.h),
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: widget.myAccountModel.first.data.profileImage,
              isEdit: true,
              onClicked: () async {},
            ),
            SizedBox(height: 30.h),
            TextFieldWidget(
              controller: _firstNameController,
              prefixIcon: Ionicons.person_outline,
              label: AppText.firstName,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Please enter first name";
                }
                return null;
              },
            ),
            SizedBox(height: 30.h),
            TextFieldWidget(
              controller: _lastNameController,
              prefixIcon: Ionicons.person_outline,
              label: AppText.lastName,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Please enter last name";
                }
                return null;
              },
            ),
            SizedBox(height: 30.h),
            TextFieldWidget(
              label: 'Email',
              controller: _emailController,
              prefixIcon: Ionicons.mail_outline,
            ),
            SizedBox(height: 30.h),
            MobileNumberTextField(
              controller: _phoneNumberContorller,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Please enter phone number";
                }
                return null;
              },
            ),
            SizedBox(height: 30.h),
            PrimaryButtonWidget(
                width: context.width(),
                height: 50.h,
                caption: AppText.updateChanges,
                onPressed: () async {
                  if (formGlobalKey.currentState!.validate()) {
                    // await validateEmailCubit
                    //     .validateEmail(_emailController.text.trim());
                  }
                }),
          ],
        ),
      ),
    );
  }
}
