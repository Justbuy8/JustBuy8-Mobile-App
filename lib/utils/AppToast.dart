import 'package:justbuyeight/constants/app_colors.dart';
import 'package:nb_utils/nb_utils.dart';

class AppToast {
  static success(message) => _appToast(message, AppColors.successColor);
  static danger(message) => _appToast(message, AppColors.dangerColor);
  static normal(message) => _appToast(message, AppColors.primaryColor);
}

void _appToast(message, color) {
  toast(message, bgColor: color, length: Toast.LENGTH_LONG);
}
