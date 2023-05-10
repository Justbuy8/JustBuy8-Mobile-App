import 'package:flutter/material.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';

class ViewAllButton extends StatelessWidget {
  const ViewAllButton({Key? key, this.onPressed}) : super(key: key);
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ??
          () {
            print("Clicked");
          },
      child: Row(
        children: const [
          SecondaryTextWidget(text: "View All"),
          Icon(Icons.arrow_forward_ios_rounded),
        ],
      ),
    );
  }
}
