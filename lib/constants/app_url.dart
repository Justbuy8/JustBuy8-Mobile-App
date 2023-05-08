// ignore_for_file: prefer_interpolation_to_compose_strings

class AppUrl {
  static const String testBaseUrl = "http://127.0.0.1:8000/api";
  static const String liveBaseUrl = "https://api.goget8.com/api";
  static const String BaseUrl = liveBaseUrl;
}

class BannerUrl {
  static const String getMainBanners = AppUrl.BaseUrl+"/banners/get-main-banners";
}
