class PaymentGateway {
  CashOnDelivery? cashOnDelivery;
  Paypal? paypal;
  Stripe? stripe;
  Paysera? paysera;

  PaymentGateway({this.cashOnDelivery, this.paypal, this.stripe, this.paysera});

  PaymentGateway.fromJson(Map<String, dynamic> json) {
    cashOnDelivery = json['cash_on_delivery'] != null
        ? new CashOnDelivery.fromJson(json['cash_on_delivery'])
        : null;
    paypal =
        json['paypal'] != null ? new Paypal.fromJson(json['paypal']) : null;
    stripe =
        json['stripe'] != null ? new Stripe.fromJson(json['stripe']) : null;
    paysera =
        json['paysera'] != null ? new Paysera.fromJson(json['paysera']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cashOnDelivery != null) {
      data['cash_on_delivery'] = this.cashOnDelivery!.toJson();
    }
    if (this.paypal != null) {
      data['paypal'] = this.paypal!.toJson();
    }
    if (this.stripe != null) {
      data['stripe'] = this.stripe!.toJson();
    }
    if (this.paysera != null) {
      data['paysera'] = this.paysera!.toJson();
    }
    return data;
  }
}

class CashOnDelivery {
  String? status;

  CashOnDelivery({this.status});

  CashOnDelivery.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}

class Paypal {
  String? status;
  String? environment;
  String? paypalClientId;
  String? paypalSecret;

  Paypal(
      {this.status, this.environment, this.paypalClientId, this.paypalSecret});

  Paypal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    environment = json['environment'];
    paypalClientId = json['paypal_client_id'];
    paypalSecret = json['paypal_secret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['environment'] = this.environment;
    data['paypal_client_id'] = this.paypalClientId;
    data['paypal_secret'] = this.paypalSecret;
    return data;
  }
}

class Stripe {
  String? status;
  String? apiKey;
  String? publishedKey;

  Stripe({this.status, this.apiKey, this.publishedKey});

  Stripe.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    apiKey = json['api_key'];
    publishedKey = json['published_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['api_key'] = this.apiKey;
    data['published_key'] = this.publishedKey;
    return data;
  }
}

class Paysera {
  String? status;
  String? projectId;
  String? signPassword;
  bool? testMode;

  Paysera({this.status, this.projectId, this.signPassword, this.testMode});

  Paysera.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    projectId = json['project_id'];
    signPassword = json['sign_password'];
    testMode = json['test_mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['project_id'] = this.projectId;
    data['sign_password'] = this.signPassword;
    data['test_mode'] = this.testMode;
    return data;
  }
}
