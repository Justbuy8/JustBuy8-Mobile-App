// ignore_for_file: sort_child_properties_last, use_build_context_synchronously, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/blocs/myaccount/myaccount_cubit.dart';
import 'package:justbuyeight/blocs/update_user_profile/update_user_profile_cubit.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/constants/bloc_provider.dart';
import 'package:justbuyeight/screens/authentication/signin_screen.dart';
import 'package:justbuyeight/screens/maintabs/my_account/edit_profile_screen.dart';
import 'package:justbuyeight/utils/AlertDialog.dart';
import 'package:justbuyeight/utils/Navigator.dart';
import 'package:justbuyeight/widgets/components/appbars/secondary_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/images/avatar_image_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:justbuyeight/utils/Secure_Storage.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  void initState() {
    context.read<MyaccountCubit>().myAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserProfileCubit, UpdateUserProfileState>(
      listener: (context, state) {
        print('state of update is $state');
        if (state is UpdateUserProfileSuccess) {
          context.read<MyaccountCubit>().myAccount();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const SecondaryAppbarWidget(
          trailingIcon: Icons.notifications_outlined,
          leadingIcon: Icons.settings_outlined,
          title: 'My Account',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<MyaccountCubit, MyaccountState>(
                  builder: (context, state) {
                print(state);
                if (state is MyaccountLoading) {
                  return AppCircularSpinner();
                } else if (state is MyaccountLoaded) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AvatarImageWidget(
                              height: 80.h,
                              width: 80.w,
                              imageUrl:
                                  state.accountData.first.data.profileImage,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryTextWidget(
                                    text:
                                        "${state.accountData.first.data.firstName} ${state.accountData.first.data.lastName}"),
                                SecondaryTextWidget(
                                  text: state.accountData.first.data.email,
                                  fontColor: Colors.grey,
                                  fontSize: 13,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            MaterialButton(
                              onPressed: () {
                                TabNavigator.withoutTabNavigator(
                                    context: context,
                                    screen: MultiBlocProvider(
                                      providers: BlocProviders.providers,
                                      child: EditProfileScreen(
                                        myAccountModel: state.accountData,
                                        previousContext: context,
                                      ),
                                    ));
                              },
                              color: AppColors.iconbackgroundColor,
                              textColor: Colors.white,
                              child: Icon(
                                Icons.mode_edit,
                                size: 15.sp,
                                color: AppColors.primaryColor,
                              ),
                              padding: EdgeInsets.all(5.w),
                              shape: const CircleBorder(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (state is MyaccountFailed) {
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
                } else if (state is MyaccountInternetError) {
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
              }),
              SizedBox(
                height: 10.h,
              ),
              ListView.builder(
                  itemCount: myAccountListTitle.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (index == 5) {
                          [
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return confirmAlertDialog(
                                    context,
                                    'Confirm Logout',
                                    'Are you sure you want to logout?',
                                    YesPressed: () async {
                                  await UserSecureStorage.deleteSecureStorage();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              MultiBlocProvider(
                                                  providers:
                                                      BlocProviders.providers,
                                                  child: const SignInScreen())),
                                      (route) => false);
                                }, NoPressed: () {
                                  Navigator.of(context).pop();
                                });
                              },
                            ),
                          ];
                        }
                      },
                      child: Column(
                        children: [
                          ListTile(
                            title: PrimaryTextWidget(
                              text: myAccountListTitle[index],
                              fontSize: 14,
                            ),
                            leading: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.iconbackgroundColor,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  myAccountListIcon[index],
                                  color: AppColors.primaryColor,
                                ),
                              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
