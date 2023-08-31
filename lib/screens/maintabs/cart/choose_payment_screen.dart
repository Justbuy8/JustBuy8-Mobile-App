import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/blocs/cart/payment_gateway/payment_gateway_bloc.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/models/cart/payment_gateway/payment_gateway.dart';
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

  // Cash on delivery
  void cashOnDelivery() {
    print('Cash on delivery');
  }

  // Paypal
  void paypal() {
    var environment = _paymentGateway.paypal?.environment;
    var clientId = _paymentGateway.paypal?.paypalClientId;
    var paypalSecret = _paymentGateway.paypal?.paypalSecret;

    print('Paypal $environment $clientId $paypalSecret');
  }

  // Stripe
  void stripe() {
    var apiKey = _paymentGateway.stripe?.apiKey;
    var publishedKey = _paymentGateway.stripe?.publishedKey;
    print('Stripe $apiKey $publishedKey');
  }

  // Paysera
  void paysera() {
    var projectId = _paymentGateway.paysera?.projectId;
    var signInPassword = _paymentGateway.paysera?.signPassword;
    var testMode = _paymentGateway.paysera?.testMode;
    print('Paysera $projectId $signInPassword $testMode');
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
                    ImageAssets.cashOnDelivery,
                    height: 40,
                    width: 40,
                  ),
                  10.width,
                  paymentMethodTitle[0].text.make(),
                ],
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
            ).visible(_paymentGateway.cashOnDelivery?.status != 0),
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
                    height: 40,
                    width: 40,
                  ),
                  10.width,
                  paymentMethodTitle[1].text.make(),
                ],
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
            ).visible(_paymentGateway.paypal?.status != 0),
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
                    height: 40,
                    width: 40,
                  ),
                  10.width,
                  paymentMethodTitle[2].text.make(),
                ],
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
            ).visible(_paymentGateway.stripe?.status != 0),
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
                    height: 40,
                    width: 40,
                  ),
                  10.width,
                  paymentMethodTitle[3].text.make(),
                ],
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
            ).visible(_paymentGateway.paysera?.status != 0),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 20.h),
              child: PrimaryButtonWidget(
                  width: context.width(),
                  height: 50.h,
                  caption: AppText.confirmOrder,
                  onPressed: () async {
                    if (payment.cashOnDelivery.index == selectedPayment) {
                      cashOnDelivery();
                    } else if (payment.paypal.index == selectedPayment) {
                      paypal();
                    } else if (payment.stripe.index == selectedPayment) {
                      stripe();
                    } else if (payment.paysera.index == selectedPayment) {
                      paysera();
                    }
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (builder) => ConfirmationScreen(),
                    //   ),
                    // );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
