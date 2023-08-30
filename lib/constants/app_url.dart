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

class WishListUrl {
  static const String getUserWishList =
      "${AppUrl.baseUrl}/wishlist/get-user-wlist";
  static const String addToWishlist =
      "${AppUrl.baseUrl}/wishlist/add-to-wishlist";

  static const String deleteFromWishlist =
      "${AppUrl.baseUrl}/wishlist/delete-from-wishlist";
}

class ProductsUrl {
  static const String featuredProducts =
      "${AppUrl.baseUrl}/product/get-featured-products";
  static const String newArrivals =
      "${AppUrl.baseUrl}/product/get-new-arrivals";

  static const String bestProducts =
      "${AppUrl.baseUrl}/product/get-best-products";

  static const String getProductsByMainCategory =
      "${AppUrl.baseUrl}/product/by-main-category";

  static const String getProductDetails =
      "${AppUrl.baseUrl}/product/get-product-details";

  static const String getProductReviews =
      "${AppUrl.baseUrl}/product/get-product-reviews";
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

class ShopsUrl {
  static const String getAllShops = "${AppUrl.baseUrl}/shop/all-shops";
  static const String newShops = "${AppUrl.baseUrl}/shop/latest-shop";
  static const String getShopDetails = "${AppUrl.baseUrl}/shop/shop-details";
  static const String getProductsByShopUrl =
      "${AppUrl.baseUrl}/shop/get-products-by-shop";
}

class PaymentUrl {
  static const getPaymentGateways = "${AppUrl.baseUrl}/payments/get-gateways";
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
  static const String getAddress =
      "${AppUrl.baseUrl}/address/get-user-addresses";
  static const String updateAddress =
      "${AppUrl.baseUrl}/address/update-user-address";
  static const String deleteAddress =
      "${AppUrl.baseUrl}/address/delete-user-addresses";
}

class SupportUrl {
  static const String getSupport = "${AppUrl.baseUrl}/support/get-contact";
  static const String postContact = "${AppUrl.baseUrl}/support/contact";
}

class RefreshTokenUrl {
  static const String refreshToken = "${AppUrl.baseUrl}/token/refresh-token";
}

class CartUrl {
  static const String getCartUrl = "${AppUrl.baseUrl}/cart/get-cart";
  static const String incrementUrl = "${AppUrl.baseUrl}/cart/product/increase";
  static const String decrementUrl = "${AppUrl.baseUrl}/cart/product/decrease";
  static const String deleteUrl = "${AppUrl.baseUrl}/cart/remove-product";
}
