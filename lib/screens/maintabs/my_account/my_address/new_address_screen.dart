// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/address/create_address/create_address_cubit.dart';
import 'package:justbuyeight/blocs/address/delete_address/delete_address_cubit.dart';
import 'package:justbuyeight/blocs/address/get_address/get_address_cubit.dart';
import 'package:justbuyeight/blocs/update_address/update_address_cubit.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/utils/AlertDialog.dart';
import 'package:justbuyeight/utils/SnackBars.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/appbars/secondary_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:justbuyeight/models/myaddress/my_address_model.dart';

class NewAddressScreen extends StatefulWidget {
  final List<Datum> addressData;
  final String navigateFrom;
  final int index;
  const NewAddressScreen(
      {Key? key,
      required this.addressData,
      required this.navigateFrom,
      required this.index})
      : super(key: key);

  @override
  State<NewAddressScreen> createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen> {
  final TextEditingController _personNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  int billingAddressSelectedIndex = 0;
  int billingTypeSelectedIndex = 0;
  BuildContext? dialogueContext;
  final formGlobalKey = GlobalKey<FormState>();

  assigneValues() {
    _personNameController.text =
        widget.addressData[widget.index].contactPersonName;
    _addressController.text = widget.addressData[widget.index].address;
    _cityController.text = widget.addressData[widget.index].city;
    _zipController.text = widget.addressData[widget.index].zip;
    _phoneController.text = widget.addressData[widget.index].phone;
    if (widget.addressData[widget.index].isBilling == '0') {
      billingTypeSelectedIndex = 0;
    } else {
      billingTypeSelectedIndex = 1;
    }

    if (widget.addressData[widget.index].addressType == billingAddress[0]) {
      billingAddressSelectedIndex = 0;
    } else if (widget.addressData[widget.index].addressType ==
        billingAddress[1]) {
      billingAddressSelectedIndex = 1;
    } else {
      billingAddressSelectedIndex = 2;
    }
  }

  @override
  void initState() {
    if (widget.navigateFrom == 'Edit') {
      assigneValues();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateAddressCubit, CreateAddressState>(
          listener: (context, state) {
            if (state is CreateAddressLoading) {
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
            } else if (state is CreateAddressSuccessfull) {
              DismissLoadingDialog(dialogueContext);

              Navigator.of(context).pop();
              context.read<GetAddressCubit>().getAddress();
            } else if (state is CreateAddressInternetError) {
              SnackBars.Danger(context, AppText.internetError);
              DismissLoadingDialog(dialogueContext);
            } else if (state is CreateAddressFailed) {
              SnackBars.Danger(context, 'Address add failed');
              DismissLoadingDialog(dialogueContext);
            } else if (state is CreateAddressTimeout) {
              SnackBars.Danger(context, AppText.timeOut);
              DismissLoadingDialog(dialogueContext);
            }
          },
        ),
        BlocListener<UpdateAddressCubit, UpdateAddressState>(
          listener: (context, state) {
            if (state is UpdateAddressLoading) {
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
            } else if (state is UpdateAddressSuccessfull) {
              DismissLoadingDialog(dialogueContext);

              Navigator.of(context).pop();
              context.read<GetAddressCubit>().getAddress();
            } else if (state is UpdateAddressInternetError) {
              SnackBars.Danger(context, AppText.internetError);
              DismissLoadingDialog(dialogueContext);
            } else if (state is UpdateAddressFailed) {
              SnackBars.Danger(context, 'Address not updated');
              DismissLoadingDialog(dialogueContext);
            } else if (state is UpdateAddressTimeout) {
              SnackBars.Danger(context, AppText.timeOut);
              DismissLoadingDialog(dialogueContext);
            }
          },
        ),
        BlocListener<DeleteAddressCubit, DeleteAddressState>(
          listener: (context, state) {
            if (state is DeleteAddressLoading) {
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
            } else if (state is DeleteAddressSuccessfull) {
              DismissLoadingDialog(dialogueContext);

              Navigator.of(context).pop();
              context.read<GetAddressCubit>().getAddress();
            } else if (state is DeleteAddressInternetError) {
              SnackBars.Danger(context, AppText.internetError);
              DismissLoadingDialog(dialogueContext);
            } else if (state is DeleteAddressFailed) {
              SnackBars.Danger(context, 'Address not delete');
              DismissLoadingDialog(dialogueContext);
            } else if (state is DeleteAddressTimeout) {
              SnackBars.Danger(context, AppText.timeOut);
              DismissLoadingDialog(dialogueContext);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: PreferredSize(
          child: widget.navigateFrom == 'Edit'
              ? SecondaryAppbarWidget(
                  trailingIconOnPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return confirmAlertDialog(context, 'Confirm delete',
                              'Do you wanna delete this address?',
                              YesPressed: () async {
                            context.read<DeleteAddressCubit>().deleteAddress(
                                widget.addressData[widget.index].id);
                          }, NoPressed: () {
                            Navigator.of(context).pop();
                          });
                        });
                  },
                  leadingIconOnPressed: () {
                    Navigator.of(context).pop();
                  },
                  leadingIcon: Icons.arrow_back_ios,
                  title: 'Update Address',
                  trailingIcon: Icons.delete_outline)
              : BasicAppbarWidget(
                  title: 'Add New Address',
                ),
          preferredSize: Size.fromHeight(50.h),
        ),
        body: Padding(
          padding: EdgeInsets.all(12.w),
          child: SingleChildScrollView(
            child: Form(
              key: formGlobalKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                    width: context.width(),
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: billingAddress.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                billingAddressSelectedIndex = index;
                              });
                            },
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 3.0.w, right: 3.0.w),
                              child: Container(
                                width: 100.w,
                                margin: EdgeInsets.all(2.w),
                                child: Padding(
                                  padding: EdgeInsets.all(6.0.w),
                                  child: Center(
                                    child: Text(billingAddress[index],
                                        style:
                                            billingAddressSelectedIndex == index
                                                ? TextStyle(
                                                    fontSize: 16.sp,
                                                    fontFamily:
                                                        AppFonts.openSansLight,
                                                    color: Colors.white,
                                                  )
                                                : TextStyle(
                                                    fontSize: 16.sp,
                                                    fontFamily:
                                                        AppFonts.openSansLight,
                                                    color: Colors.grey,
                                                  )),
                                  ),
                                ),
                                decoration: billingAddressSelectedIndex == index
                                    ? BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.primaryColor),
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.r)))
                                    : BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.r))),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 50.h,
                    width: context.width(),
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: billingType.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                billingTypeSelectedIndex = index;
                              });
                            },
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 3.0.w, right: 3.0.w),
                              child: Container(
                                width: 100.w,
                                margin: EdgeInsets.all(2.w),
                                child: Padding(
                                  padding: EdgeInsets.all(6.0.w),
                                  child: Center(
                                    child: Text(billingType[index],
                                        style: billingTypeSelectedIndex == index
                                            ? TextStyle(
                                                fontSize: 16.sp,
                                                fontFamily:
                                                    AppFonts.openSansLight,
                                                color: Colors.white,
                                              )
                                            : TextStyle(
                                                fontSize: 16.sp,
                                                fontFamily:
                                                    AppFonts.openSansLight,
                                                color: Colors.grey,
                                              )),
                                  ),
                                ),
                                decoration: billingTypeSelectedIndex == index
                                    ? BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.primaryColor),
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.r)))
                                    : BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.r))),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFieldWidget(
                    controller: _personNameController,
                    label: 'Contact person name',
                    prefixIcon: Ionicons.person_outline,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter contact person name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFieldWidget(
                      controller: _phoneController,
                      prefixIcon: Ionicons.call_outline,
                      label: "Phone",
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter phone number";
                        } else if (val.length > 11) {
                          return "Password length should be equal to 11";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFieldWidget(
                    controller: _addressController,
                    label: 'Address',
                    prefixIcon: Ionicons.location_outline,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter address";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFieldWidget(
                    controller: _cityController,
                    label: 'City',
                    prefixIcon: Icons.location_city_outlined,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter city";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFieldWidget(
                    controller: _zipController,
                    label: 'Zip code',
                    prefixIcon: Ionicons.code,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter zip code";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  PrimaryButtonWidget(
                      width: context.width(),
                      height: 50.h,
                      caption: widget.navigateFrom == 'Edit'
                          ? AppText.updateInformation
                          : AppText.addInformation,
                      onPressed: () async {
                        if (formGlobalKey.currentState!.validate()) {
                          // String? userId =
                          //     await UserSecureStorage.fetchUserId();
                          // String? fetchToken =
                          //     await UserSecureStorage.fetchToken();

                          if (widget.navigateFrom == 'Edit') {
                            var newAddressMap = {
                              // "UserId": "$userId",
                              // "token": "$fetchToken",
                              "contact_person_name":
                                  _personNameController.text.trim(),
                              "address_id": widget.addressData[widget.index].id,
                              "address_type": billingAddressSelectedIndex == 0
                                  ? billingAddress[0]
                                  : billingAddressSelectedIndex == 1
                                      ? billingAddress[1]
                                      : billingAddress[2],
                              "address": _addressController.text.trim(),
                              "city": _cityController.text.trim(),
                              "zip": _zipController.text.trim(),
                              "phone": _phoneController.text.trim(),
                              "is_billing":
                                  billingTypeSelectedIndex == 0 ? '0' : '1',
                            };

                            context
                                .read<UpdateAddressCubit>()
                                .updateAddress(newAddressMap);
                          } else {
                            var newAddressMap = {
                              // "UserId": "$userId",
                              // "token": "$fetchToken",
                              "contact_person_name":
                                  _personNameController.text.trim(),
                              "address_type": billingAddressSelectedIndex == 0
                                  ? billingAddress[0]
                                  : billingAddressSelectedIndex == 1
                                      ? billingAddress[1]
                                      : billingAddress[2],
                              "address": _addressController.text.trim(),
                              "city": _cityController.text.trim(),
                              "zip": _zipController.text.trim(),
                              "phone": _phoneController.text.trim(),
                              "is_billing":
                                  billingTypeSelectedIndex == 0 ? '0' : '1',
                            };

                            context
                                .read<CreateAddressCubit>()
                                .createNewAddress(newAddressMap);
                          }
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
