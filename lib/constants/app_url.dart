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

  static const String verifyEmail =
      "${AppUrl.baseUrl}/authentication/verify-email";

  static const String resetPassword =
      "${AppUrl.baseUrl}/authentication/reset-pass";

  static const String sendOtp = "${AppUrl.baseUrl}/authentication/request-otp";
  static const String registration =
      "${AppUrl.baseUrl}/authentication/register";

  static const String login = "${AppUrl.baseUrl}/authentication/login";
}

class ProductsUrl {
  static const String featuredProducts =
      "${AppUrl.baseUrl}/product/get-featured-products";
  static const String newArrivals =
      "${AppUrl.baseUrl}/product/get-new-arrivals";

  static const String bestProducts =
      "${AppUrl.baseUrl}/product/get-best-products";
}

class CategoriesUrl {
  static const String topCategories =
      "${AppUrl.baseUrl}/category/get-top-main-cat";
  static const String subCategories = "${AppUrl.baseUrl}/category/get-sub-cat";
  static const String mainCategories =
      "${AppUrl.baseUrl}/category/get-main-cat";
}

class BrandsUrl {
  static const String brands = "${AppUrl.baseUrl}/brands/get-brands";
}

class MyAccountUrl {
  static const String myAccountUrl =
      "${AppUrl.baseUrl}/user-account/get-user-profile";
  static const String updateProfileImage =
      "${AppUrl.baseUrl}/user-account/update-profile-image";
  static const String updateUserProfileUrl =
      "${AppUrl.baseUrl}/user-account/update-user-profile";
}

class AddressUrl {
  static const String createAddress =
      "${AppUrl.baseUrl}/address/add-user-address";
}
