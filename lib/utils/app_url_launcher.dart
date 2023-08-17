import 'package:url_launcher/url_launcher.dart';

class AppUrlLauncher {
  // navigate to call

  static void call(String number) async {
    String url = 'tel:$number';
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  // navigate to email
  static void email(String email) async {
    String url = 'mailto:$email';
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
