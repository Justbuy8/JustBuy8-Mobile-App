// import 'package:flutter_phoenix/generated/i18n.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_images.dart';

class AppText {
  static const String signInText = "Sign In";
  static const String addNewAddress = "Add New Address";
  static const String addInformation = "Add Informations";
  static const String updateInformation = "Update Informations";

  static const String forgetPassword = "Forget Password?";
  static const String email = "Email";
  static const String firstName = "First Name";
  static const String lastName = "Last Name";
  static const String phoneNumber = "Phone Number";

  static const String password = "Password";
  static const String confirmPassword = "Confirm password";
  static const String continueWith = "or continue with";
  static const String dontHaveAnAccount = "Don't have an account?";
  static const String alreadyHaveAnAccount = "Already have an account?";
  static const String signUp = "Sign Up";
  static const String updateChanges = "Updated Changes";
  static const String confirmOrder = "Confirm Order";
  static const String checkOut = "Checkout";

  static const String allow = "Allow";
  static const String shopNow = "Shop Now";
  static const String promoCode = "Add Promocode";

  static const String tryAgain = "Try again";
  static const String searchHereText = "Search here";
  static const String filterText = "Filter";

  static const String skip = "Skip";
  static const String forgetPasswordTitle =
      "Enter the email associated with your account and we'll send an email with instructions to reset your password.";
  static const String forgetPasswordAppBarTitle = "Forget Password";
  static const String resetPasswordAppBarTitle = "Reset Password";
  static const String sendInstruction = "Send Instructions";
  static const String changePassword = "Change Password";
  static const String verifyText = "Verify";
  static const String resetPasswordText =
      'Please enter the verification code we sent to your mobile';
  static const String notificationPermissionSubTitle =
      'Stay notified about new course update,\n scoreboard status and other updates';
  static const String notification = "Notifications";
  static const String accountCreated = "Account Created";
  static const String errorMessage = "Internet connection failed, Try again";

  static const String accountCreatedSubtitle = "Your account has been created";
  static const String enterNewPassword = "Enter new password and confirm.";
  static const String verifyEmailAddress = "Verify Email Address";

  static const String internetError = "Internet connection failed";
  static const String timeOut = "Request timeout";
  static const String loggedIn = "User loggedin successfully";
  static const String loggedInFailed = "There is no account with this email";
  static const String registered = "Email verified successfully";
  static const String registrationFailed = "Email verification failed";
  static const String emailExist = "Email already exist";
  static const String serverError = "Server error";

  static const String loadingText = "Loading...";
  static const String somethingWentWrong = "Something went wrong";

  //Home Page
  static const String featuredProductsText = "Featured Products";
  static const String topCategoriesText = "Top Categories";
  static const String chooseBrandsText = "Choose Brands";
  static const String newArrivalsText = "New Arrivals";
  static const String bestProductsText = "Best Products";
  static const String viewAll = "View All";

  // Main Tabs Screen
  static const String homeText = "Home";
  static const String searchText = "Search";
  static const String cartText = "Cart";
  static const String wishlistText = "Wishlist";
  static const String accountText = "Account";

  // Filter Screen
  static const String categoriesText = "Categories";
  static const String priceText = "Price";
  static const String ratingText = "Rating";

  // Product Details Screen
  static const String productDetailsText = "Product Details";
  static const String descriptionText = "Description";
  static const String sizeText = "Size";
  static const String colorText = "Color";
  static const String addToCartText = "Add To Cart";

  // other screens
  static const String allCategoriesText = "Categories";
  static const String itemsText = "Items";
  static const String saleText = "Sale";
  static const String trendingText = "Trending";
  static const String newText = "New";
  static const String yourCartIsEmptyText = "Your cart is empty!";
  static const String looksLikeYouHaventMadeYourOrderYetText =
      "Looks like you haven't made your order yet";

  // bloc text
  static const String noBrandsFountText = "No brands to load";
  static const String noArrivalsFound = "No arrivals found";
  static const String noProductsFound = "No Products found";
  static const String noCategoriesFoundText = "No Categories Found";
  static const String addedToWishlist = "Added to wishlist";
  static const String failedToAddToWishlist = "Failed to add to wishlist";

  // Widgets Texts
  static const String shopNowText = "Shop Now";

  ///PROMOCDODE TEXTS
  static const String dontHaveText = "You don't have";
  static const String promocodeText = " Promocodes Yet!";
  static const String promocodeSubTitleText =
      "Please Enter Coupon Code get ...............";

  /////contactus TEXT
  static const String contactUsText = "Contact Us";
  static const String contactUsSubtitle =
      "If you face any trouble for item ordering feel free to contact us.";

  static const String notificationOption = "Notification Options";
  static const String setting = "Settings";
}

const List<IoniconsData> myAccountListIcon = [
  Ionicons.wallet_outline,
  Ionicons.dice_outline,
  Ionicons.cash_outline,
  Ionicons.location_outline,
  Ionicons.gift_outline,
  Ionicons.log_out_outline,
];
const List<String> myAccountListTitle = [
  'My Wallet',
  'My Orders',
  'Payment Method',
  'Address',
  'Promocode & Gift Cards',
  'Logout',
];

const List<IoniconsData> settingListIcon = [
  Ionicons.notifications_outline,
  Ionicons.information_circle_outline,
  Ionicons.lock_closed_outline,
  Ionicons.information_outline,
  Ionicons.pencil_outline,
  Ionicons.call_outline,
];
const List<String> settingListTitle = [
  'Notification Options',
  'About Us',
  'Privacy Policy',
  'FAQs',
  'Send Feedback',
  'Contact Us',
];

const List<String> billingAddress = [
  'Permanent',
  'Home',
  'Office',
];

const List<String> billingType = [
  'Shipping',
  'Billing',
];

const List<String> notificationOptionTitle = [
  'General Notification',
  'Sound',
  'Vibration',
  'Special Offers',
  'Promo & Discount',
  'Payments',
  'App Updates',
  'New Product Available',
  'New Tips Available',
];

List<bool> notificationOptionStatus = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
];

const List<IoniconsData> checkOutTitleIcon = [
  Ionicons.location_outline,
  Ionicons.wallet_outline,
];
const List<String> checkOutTitle = [
  'Shipping Details',
  'Payment Method',
];

const List<String> chooseShippingDetailTitle = [
  'Home',
  'Work',
  'Other',
];

const List<String> paymentMethodIcon = [
  ImageAssets.walletImage,
  ImageAssets.visaImage,
  ImageAssets.cardImage,
  ImageAssets.applePayImage,
  ImageAssets.googlePayImage,
  ImageAssets.payPalImage,
  ImageAssets.amazonPayImage,
];
const List<String> paymentMethodTitle = [
  'My Wallet',
  '****8645',
  '****857',
  'Connected',
  'Connected',
  'Connected',
  'Connected',
];
