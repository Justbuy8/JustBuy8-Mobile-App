import 'package:flutter/material.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button.dart';
import 'package:justbuyeight/widgets/components/otp/otp_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/mobile_number_text_field.dart';
import 'package:justbuyeight/widgets/components/text_fields/password_text_field_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JustBuy8'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryButtonWidget(
                  caption: "Sign in with Password", onPressed: () {}),
              const SizedBox(height: 10),
              const PrimaryTextWidget(text: "Primary Text"),
              const SizedBox(height: 10),
              const SecondaryTextWidget(text: 'Secondary Text'),
              const SizedBox(height: 10),
              PasswordTextFieldWidget(
                controller: controller,
                label: "Password",
                prefixIcon: Icons.lock,
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                controller: controller2,
                label: "Email",
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: 10),
              OtpWidget(
                controller: controller3,
                length: 6,
              ),
              const SizedBox(height: 10),
              MobileNumberTextField(controller: controller4)
            ],
          ),
        ),
      ),
    );
  }
}
