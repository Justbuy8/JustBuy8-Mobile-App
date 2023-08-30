import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/cart/payment_gateway/payment_gateway.dart';

abstract class PaymentGatewayController {
  static Future<PaymentGateway> getPaymentGateways() async {
    PaymentGateway gateways = PaymentGateway();

    final response = await ApiManager.getRequest(
      PaymentUrl.getPaymentGateways,
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['Success']) {
        final paymentsData = result['Data'];
        gateways = PaymentGateway.fromJson(paymentsData);
      } else {
        gateways = PaymentGateway();
      }
    } else {
      gateways = PaymentGateway();
    }
    return gateways;
  }
}
