import 'package:flutter/material.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = TextEditingController();
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
          ],
        ),
      ),
    );
  }
}
