import 'package:justbuyeight/constants/app_colors.dart';
import 'package:nb_utils/nb_utils.dart';

class AppToast {
  static success(message, [ToastGravity? gravity]) {
    _appToast(message, AppColors.successColor, gravity);
  }

  static danger(message, [ToastGravity? gravity]) {
    _appToast(message, AppColors.dangerColor, gravity);
  }

  static normal(message, [ToastGravity? gravity]) {
    _appToast(message, AppColors.primaryColor, gravity);
  }
}

void _appToast(message, color, [ToastGravity? gravity]) {
  toast(message,
      bgColor: color, length: Toast.LENGTH_LONG, gravity: ToastGravity.TOP);
}
