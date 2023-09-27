// Import necessary libraries and files
import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/cart/payment_gateway/payment_gateway.dart';

// Create an abstract class for PaymentGatewayController
abstract class PaymentGatewayController {
  // Static method to fetch payment gateways
  static Future<PaymentGateway> getPaymentGateways() async {
    // Create an instance of PaymentGateway to store the fetched data
    PaymentGateway gateways = PaymentGateway();

    // Make a GET request to fetch payment gateways
    final response = await ApiManager.getRequest(
      PaymentUrl.getPaymentGateways,
    );

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      // Check if the request was successful
      if (result['Success']) {
        // Extract the payment gateway data from the response and parse it
        final paymentsData = result['Data'];
        gateways = PaymentGateway.fromJson(paymentsData);
      } else {
        // If the request was not successful, set the gateways object to empty
        gateways = PaymentGateway();
      }
    } else {
      // If the response status code is not 200, set the gateways object to empty
      gateways = PaymentGateway();
    }

    // Return the PaymentGateway object containing payment gateway data
    return gateways;
  }
}
