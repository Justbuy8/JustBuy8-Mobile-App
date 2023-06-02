// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/myaccount/myaccount_cubit.dart';
import 'package:justbuyeight/blocs/update_user_profile/update_user_profile_cubit.dart';
import 'package:justbuyeight/blocs/upload_image/upload_image_cubit.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/models/myaccount/myaccount_model.dart';
import 'package:justbuyeight/utils/AlertDialog.dart';
import 'package:justbuyeight/utils/SnackBars.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/images/avatar_file_image_widget.dart';
import 'package:justbuyeight/widgets/components/images/avatar_image_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class EditProfileScreen extends StatefulWidget {
  List<MyAccountModel> myAccountModel;
  final BuildContext previousContext;

  EditProfileScreen(
      {required this.myAccountModel, required this.previousContext});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final formGlobalKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberContorller = TextEditingController();
  final ImagePicker picker = ImagePicker();
  late MyaccountCubit myaccountCubit;
  String? pickedImage;
  File? file;
  BuildContext? dialogueContext;

  assigneValues() {
    _firstNameController.text = widget.myAccountModel.first.data.firstName;
    _emailController.text = widget.myAccountModel.first.data.email;
    _phoneNumberContorller.text = widget.myAccountModel.first.data.phone;
    _lastNameController.text = widget.myAccountModel.first.data.lastName;
  }

  @override
  void initState() {
    assigneValues();
    myaccountCubit = context.read<MyaccountCubit>();
    super.initState();
  }

  popFtn() {
    widget.previousContext.read<MyaccountCubit>().myAccount();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => popFtn(),
      child: Scaffold(
        appBar: const BasicAppbarWidget(
          title: 'Profile Edit',
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<UploadImageCubit, UploadImageState>(
              listener: (context, state) async {
                if (state is UploadImageLoading) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (ctx) {
                        dialogueContext = ctx;
                        return Container(
                          color: Colors.transparent,
                          child: Center(
                            child: SpinKitThreeBounce(
                              color: AppColors.primaryColor,
                              size: 30.0,
                            ),
                          ),
                        );
                      });
                } else if (state is UploadImageUploaded) {
                  SnackBars.Success(context, 'Image uploaded sucessfully');

                  context.read<MyaccountCubit>().myAccount();

                  DismissLoadingDialog(dialogueContext);
                } else if (state is UploadImageInternetError) {
                  SnackBars.Danger(context, AppText.internetError);
                  DismissLoadingDialog(dialogueContext);
                } else if (state is UploadImageFailed) {
                  SnackBars.Danger(context, 'Image uploading failed');
                  DismissLoadingDialog(dialogueContext);
                } else if (state is UploadImageTimeout) {
                  SnackBars.Danger(context, AppText.timeOut);
                  DismissLoadingDialog(dialogueContext);
                }
              },
            ),
            BlocListener<UpdateUserProfileCubit, UpdateUserProfileState>(
              listener: (context, state) async {
                if (state is UpdateUserProfileLoading) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (ctx) {
                        dialogueContext = ctx;
                        return Container(
                          color: Colors.transparent,
                          child: Center(
                            child: SpinKitThreeBounce(
                              color: AppColors.primaryColor,
                              size: 30.0,
                            ),
                          ),
                        );
                      });
                } else if (state is UpdateUserProfileSuccess) {
                  SnackBars.Success(
                      context, 'User profile updated sucessfully');
                  context.read<MyaccountCubit>().myAccount();

                  DismissLoadingDialog(dialogueContext);
                } else if (state is UpdateUserProfileInternetError) {
                  SnackBars.Danger(context, AppText.internetError);
                  DismissLoadingDialog(dialogueContext);
                } else if (state is UpdateUserProfileFailed) {
                  SnackBars.Danger(context, 'User profile updating failed');
                  DismissLoadingDialog(dialogueContext);
                } else if (state is UpdateUserProfileTimeout) {
                  SnackBars.Danger(context, AppText.timeOut);
                  DismissLoadingDialog(dialogueContext);
                }
              },
            ),
          ],
          child: Form(
            key: formGlobalKey,
            child: ListView(
              padding: EdgeInsets.only(
                  left: 15.w, right: 15.w, bottom: 20.h, top: 20.h),
              physics: BouncingScrollPhysics(),
              children: [
                Center(
                  child: Stack(
                    children: [
                      pickedImage == null
                          ? AvatarImageWidget(
                              imageUrl:
                                  widget.myAccountModel.first.data.profileImage)
                          : AvatarImageFileWidget(
                              imageUrl: File(pickedImage.toString()),
                            ),
                      Positioned(
                        bottom: 0,
                        right: 1,
                        child: GestureDetector(
                          onTap: () async {
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              file = File(image.path);
                              setState(() {
                                pickedImage = image.path;
                              });

                              context
                                  .read<UploadImageCubit>()
                                  .uploadImage(file!.path);
                            }
                          },
                          child: ClipOval(
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              color: AppColors.primaryColor,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                  readOnly: true,
                  label: 'Email',
                  controller: _emailController,
                  prefixIcon: Ionicons.mail_outline,
                ),
                SizedBox(height: 30.h),
                TextFieldWidget(
                  prefixIcon: Ionicons.call_outline,
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
                        await context
                            .read<UpdateUserProfileCubit>()
                            .updateUserProfile(
                                _firstNameController.text.trim(),
                                _lastNameController.text.trim(),
                                _phoneNumberContorller.text.trim());
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
