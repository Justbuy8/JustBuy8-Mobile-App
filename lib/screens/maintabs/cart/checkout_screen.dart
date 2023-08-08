import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/blocs/address/get_address/get_address_cubit.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/screens/maintabs/cart/confirmation_screen.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final TextEditingController _messageController = TextEditingController();
  int? selectedRadioTile;
  late GetAddressCubit getAddressCubit;

  initCubit() {
    getAddressCubit = context.read<GetAddressCubit>();
    getAddressCubit.getAddress();
  }

  @override
  void initState() {
    initCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: BasicAppbarWidget(
        title: AppText.checkOut,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: ListView(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimaryTextWidget(
                      text: 'My Order',
                      fontSize: 16,
                      fontFamily: AppFonts.robotoBold,
                    ),
                    PrimaryTextWidget(
                      text: '\$255.00',
                      fontSize: 16,
                      fontFamily: AppFonts.robotoBold,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SecondaryTextWidget(
                      text: 'Premium Women George',
                      fontSize: 16,
                      fontFamily: AppFonts.robotoLight,
                    ),
                    SecondaryTextWidget(
                      text: '1 x \$300.00',
                      fontSize: 16,
                      fontFamily: AppFonts.robotoLight,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SecondaryTextWidget(
                      text: 'Go Buzz Women George',
                      fontSize: 16,
                      fontFamily: AppFonts.robotoLight,
                    ),
                    SecondaryTextWidget(
                      text: '1 x \$300.00',
                      fontSize: 16,
                      fontFamily: AppFonts.robotoLight,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: SecondaryTextWidget(
                      text: 'Discount',
                      fontSize: 16,
                      fontFamily: AppFonts.robotoLight,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: PrimaryTextWidget(
                      text: '\$0.00',
                      fontSize: 16,
                      fontFamily: AppFonts.robotoLight,
                      fontColor: Colors.green,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: SecondaryTextWidget(
                      text: 'Delivery',
                      fontSize: 16,
                      fontFamily: AppFonts.robotoLight,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: PrimaryTextWidget(
                      text: '+\$15.00',
                      fontSize: 16,
                      fontFamily: AppFonts.robotoLight,
                      fontColor: Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              ListView.builder(
                  itemCount: checkOutTitle.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          shopDetailAlertDialogue(context);
                        } else if (index == 1) {
                          paymentDetailAlertDialogue(context);
                        }
                      },
                      child: Column(
                        children: [
                          ListTile(
                            title: PrimaryTextWidget(
                              text: checkOutTitle[index],
                              fontSize: 14,
                            ),
                            leading: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.iconbackgroundColor,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  checkOutTitleIcon[index],
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            subtitle: SecondaryTextWidget(
                              text: 'shoping subtitle',
                              fontSize: 14,
                            ),
                            trailing: const Icon(
                              Icons.navigate_next,
                              color: Colors.black,
                            ),
                          ),
                          const Divider()
                        ],
                      ),
                    );
                  }),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: TextFieldWidget(
                    controller: _messageController,
                    maxLine: 6,
                    label: 'Additional Notes',
                  )),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
                child: PrimaryButtonWidget(
                    width: context.width(),
                    height: 50.h,
                    caption: AppText.confirmOrder,
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => ConfirmationScreen()));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void shopDetailAlertDialogue(context) {
    Dialog fancyDialog = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h, left: 20.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryTextWidget(
                                  text: 'Choose Shipping Details',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(),
                StatefulBuilder(builder: (context, setcheckboxstate) {
                  return BlocBuilder<GetAddressCubit, GetAddressState>(
                    builder: (context, state) {
                      if (state is GetAddressLoading) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [AppCircularSpinner()],
                        );
                      }
                      if (state is GetAddressLoaded) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.addressData.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: RadioListTile(
                                            contentPadding: EdgeInsets.all(0),
                                            title: PrimaryTextWidget(
                                              text: state.addressData.first
                                                  .data[index].addressType,
                                              fontSize: 14,
                                            ),
                                            subtitle: SecondaryTextWidget(
                                              text:
                                                  '${state.addressData.first.data[index].address}\n,${state.addressData.first.data[index].city}',
                                              fontSize: 12,
                                            ),
                                            value: index,
                                            groupValue: selectedRadioTile,
                                            onChanged: (val) {
                                              print("Radio Tile pressed $val");
                                              setcheckboxstate(() {
                                                selectedRadioTile = val as int?;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  index == 2 ? SizedBox() : Divider(),
                                ],
                              );
                            });
                      } else if (state is GetAddressFailed) {
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
                      } else if (state is GetNoAddressFound) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(LottieAssets.error, height: 200.h),
                            Center(
                              child: PrimaryTextWidget(
                                text: 'No Address Found',
                              ),
                            )
                          ],
                        );
                      } else if (state is GetAddressInternetError) {
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
                  );
                }),
              ],
            ),
          ),
        ));
    showDialog(
      context: context,
      builder: (BuildContext context) => BlocProvider(
        create: (context) => GetAddressCubit()..getAddress(),
        child: fancyDialog,
      ),
    );
  }

  void paymentDetailAlertDialogue(context) {
    Dialog fancyDialog = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h, left: 20.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryTextWidget(
                                  text: 'Choose Payment Method',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(),
                StatefulBuilder(builder: (context, setcheckboxstate) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: paymentMethodTitle.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: RadioListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      title: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                                border: Border.all(
                                                    color: AppColors
                                                        .appGreyColor)),
                                            child: Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Image.asset(
                                                paymentMethodIcon[index],
                                                height: 30.h,
                                                width: 30.w,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          PrimaryTextWidget(
                                            text: paymentMethodTitle[index],
                                            fontSize: 14,
                                          ),
                                        ],
                                      ),
                                      value: index,
                                      groupValue: selectedRadioTile,
                                      onChanged: (val) {
                                        print("Radio Tile pressed $val");
                                        setcheckboxstate(() {
                                          selectedRadioTile = val as int?;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            index == 6 ? SizedBox() : Divider(),
                          ],
                        );
                      });
                }),
              ],
            ),
          ),
        ));
    showDialog(
      context: context,
      builder: (BuildContext context) => fancyDialog,
    );
  }
}
