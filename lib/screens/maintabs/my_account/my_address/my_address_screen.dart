// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/address/get_address/getaddress_cubit.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/screens/maintabs/my_account/my_address/new_address_screen.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:page_transition/page_transition.dart';

class MyAdressScreen extends StatefulWidget {
  const MyAdressScreen({Key? key}) : super(key: key);

  @override
  State<MyAdressScreen> createState() => _MyAdressScreenState();
}

class _MyAdressScreenState extends State<MyAdressScreen> {
  @override
  void initState() {
    context.read<GetaddressCubit>().getAddress();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: BasicAppbarWidget(
        title: 'My Address',
        titleColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<GetaddressCubit, GetaddressState>(
              builder: (context, state) {
                if (state is GetaddressLoading) {
                  return AppCircularSpinner();
                } else if (state is GetaddressLoaded) {
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: state.addressData.first.data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.w),
                              child: ListTile(
                                leading: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.iconbackgroundColor,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.w),
                                    child: Icon(
                                      Ionicons.location_outline,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PrimaryTextWidget(
                                      text:
                                          '${state.addressData.first.data[index].contactPersonName}',
                                      fontSize: 16.sp,
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    SecondaryTextWidget(
                                      text:
                                          '${state.addressData.first.data[index].address}, ${state.addressData.first.data[index].city}',
                                      fontColor: Colors.black54,
                                      fontSize: 14.sp,
                                    ),
                                  ],
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                NewAddressScreen(
                                                  addressData: state
                                                      .addressData.first.data,
                                                  navigateFrom: 'Edit',
                                                  index: index,
                                                )));
                                  },
                                  child: Icon(
                                    Icons.edit_note,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const Divider()
                          ],
                        );
                      });
                } else if (state is GetaddressFailed) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(LottieAssets.error, height: 200.h),
                      Center(
                        child: PrimaryTextWidget(
                          text: 'Loading data failed',
                        ),
                      )
                    ],
                  );
                } else if (state is GetaddressInternetError) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(LottieAssets.error, height: 200.h),
                      Center(
                        child: PrimaryTextWidget(
                          text: 'Internet connection failed',
                        ),
                      )
                    ],
                  );
                }
                return SizedBox();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
            child: PrimaryButtonWidget(
                width: context.width(),
                height: 50.h,
                caption: AppText.addNewAddress,
                onPressed: () async {
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: const Duration(milliseconds: 400),
                          type: PageTransitionType.rightToLeft,
                          child: NewAddressScreen(
                            index: 0,
                            addressData: const [],
                            navigateFrom: 'Button',
                          )));
                }),
          ),
        ],
      ),
    );
  }
}
