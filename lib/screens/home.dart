import 'package:flutter/material.dart';
import 'package:justbuyeight/widgets/components/otp/otp_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';
import 'package:otp_text_field/otp_text_field.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = TextEditingController();
  final otpController = OtpFieldController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JustBuy8'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWidget(
              controller: controller,
              label: "Email",
              prefixIcon: Icons.email,
              suffixIcon: Icons.visibility,
              obscureText: true,
            ),
            const SizedBox(height: 10),
            OtpWidget(
              controller: otpController,
              length: 4,
            ),
          ],
        ),
      ),
    );
  }
}
