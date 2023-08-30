import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/blocs/cart/payment_gateway/payment_gateway_bloc.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/models/cart/payment_gateway/payment_gateway.dart';
import 'package:justbuyeight/screens/maintabs/cart/confirmation_screen.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:velocity_x/velocity_x.dart';

enum payment { cashOnDelivery, paypal, stripe, paysera }

class ChoosePaymentScreen extends StatefulWidget {
  const ChoosePaymentScreen({Key? key}) : super(key: key);

  @override
  State<ChoosePaymentScreen> createState() => _ChoosePaymentScreenState();
}

class _ChoosePaymentScreenState extends State<ChoosePaymentScreen> {
  // Payment enum
  final PaymentGatewayBloc paymentGatewayBloc = PaymentGatewayBloc();

  List paymentGateways = [];
  int selectedPayment = 0;

  // Payment Gateway model
  PaymentGateway _paymentGateway = PaymentGateway();

  @override
  void initState() {
    paymentGatewayBloc.add(GetPaymentGateways());
    super.initState();
  }

  @override
  void dispose() {
    paymentGatewayBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbarWidget(title: AppText.choosePaymentMethodText),
      body: BlocListener<PaymentGatewayBloc, PaymentGatewayState>(
        bloc: paymentGatewayBloc,
        listener: (context, state) {
          if (state is PaymentGatewayLoaded) {
            _paymentGateway = state.paymentGateways;
          }
        },
        child: Column(
          children: [
            RadioListTile(
              value: payment.cashOnDelivery.index,
              groupValue: selectedPayment,
              onChanged: (value) {
                setState(() {
                  selectedPayment = value as int;
                });
              },
              title: Row(
                children: [
                  Image.asset(
                    ImageAssets.walletImage,
                    height: 30,
                    width: 30,
                  ),
                  10.widthBox,
                  paymentMethodTitle[0].text.make(),
                ],
              ),
            ).visible(_paymentGateway.cashOnDelivery?.status == 1),
            10.height,
            RadioListTile(
              value: payment.paypal.index,
              groupValue: selectedPayment,
              onChanged: (value) {
                setState(() {
                  selectedPayment = value as int;
                });
              },
              title: Row(
                children: [
                  Image.asset(
                    ImageAssets.payPalImage,
                    height: 30,
                    width: 30,
                  ),
                  10.widthBox,
                  paymentMethodTitle[1].text.make(),
                ],
              ),
            ).visible(_paymentGateway.paypal?.status == 1),
            10.height,
            RadioListTile(
              value: payment.stripe.index,
              groupValue: selectedPayment,
              onChanged: (value) {
                setState(() {
                  selectedPayment = value as int;
                });
              },
              title: Row(
                children: [
                  Image.asset(
                    ImageAssets.stripe,
                    height: 30,
                    width: 30,
                  ),
                  10.widthBox,
                  paymentMethodTitle[2].text.make(),
                ],
              ),
            ).visible(_paymentGateway.stripe?.status == 1),
            10.height,
            RadioListTile(
              value: payment.paysera.index,
              groupValue: selectedPayment,
              onChanged: (value) {
                setState(() {
                  selectedPayment = value as int;
                });
              },
              title: Row(
                children: [
                  Image.asset(
                    ImageAssets.paysera,
                    height: 30,
                    width: 30,
                  ),
                  10.widthBox,
                  paymentMethodTitle[3].text.make(),
                ],
              ),
            ).visible(_paymentGateway.paysera?.status == 1),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 20.h),
              child: PrimaryButtonWidget(
                  width: context.width(),
                  height: 50.h,
                  caption: AppText.confirmOrder,
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (builder) => ConfirmationScreen(),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
