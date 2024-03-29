// ignore_for_file: constant_identifier_names

class AppConstants {
  static const String APP_NAME = 'DBfood';
  static const int APP_VERSION = 1;
// https://mvs.bslmeiyu.com
  // static const String BASE_URL = "http://127.0.0.1:8000";
  static const String BASE_URL =
      "http://192.168.0.105/food-delivery-app/public";
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";
  static const String UPLOAD_URL = "/uploads/";

//! Auth end points
  static const String REGISTRATION_URI = "/api/v1/auth/register";
  static const String LOGIN_URI = "/api/v1/auth/login";

  static const String TOKEN = "user_token";
  static const String PHONE = "phone";
  static const String PASSWORD = "password";
  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";
}
