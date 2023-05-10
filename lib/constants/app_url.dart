class AppUrl {
  static const String testBaseUrl = "http://127.0.0.1:8000/api";
  static const String liveBaseUrl = "https://api.goget8.com/api";
  static const String baseUrl = liveBaseUrl;
}

class BannerUrl {
  static const String getMainBanners =
      "${AppUrl.baseUrl}/banners/get-main-banners";
  static const String getFooterBanners =
      "${AppUrl.baseUrl}/banners/get-footer-banners";
}

class AuthUrl {
  static const String validateEmail =
      "${AppUrl.baseUrl}/authentication/validate-email";

  static const String sendOtp = "${AppUrl.baseUrl}/authentication/request-otp";
}
