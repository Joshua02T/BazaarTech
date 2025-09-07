import 'package:bazaartech/mainpage.dart';
import 'package:bazaartech/view/aboutapp/aboutapp.dart';
import 'package:bazaartech/view/account/screen/account.dart';
import 'package:bazaartech/view/bazaardetails/screens/bazaardetails.dart';
import 'package:bazaartech/view/bazaardetails/screens/bazaarproducts.dart';
import 'package:bazaartech/view/bazaardetails/screens/bazaarreviews.dart';
import 'package:bazaartech/view/cart/screen/cartpage.dart';
import 'package:bazaartech/view/cart/screen/checkoutpage.dart';
import 'package:bazaartech/view/cart/screen/confirmationpage.dart';
import 'package:bazaartech/view/help/screen/helpcenter.dart';
import 'package:bazaartech/view/login/screen/login.dart';
import 'package:bazaartech/view/privacy/screen/privacy.dart';
import 'package:bazaartech/view/productdetails/screens/productdetails.dart';
import 'package:bazaartech/view/productdetails/screens/productcomments.dart';
import 'package:bazaartech/view/recoverpassword/screen/recoverpass.dart';
import 'package:bazaartech/view/reportaproblem/screen/reportproblem.dart';
import 'package:bazaartech/view/settings/screen/settings.dart';
import 'package:bazaartech/view/signup/screen/signup.dart';
import 'package:bazaartech/view/splash/screen/splash.dart';
import 'package:bazaartech/view/storedetails/screen/storedetails.dart';
import 'package:bazaartech/view/storedetails/screen/storeproducts.dart';
import 'package:bazaartech/view/storedetails/screen/storereviews.dart';
import 'package:bazaartech/view/supportcenter/screen/supportcenter.dart';
import 'package:get/get.dart';
import 'package:bazaartech/view/home/screen/home_screen.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      name: "/homeScreen",
      page: () => const HomeScreen(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: "/login",
      page: () => const Login(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: "/signup",
      page: () => const SignUp(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: "/recoverpass",
      page: () => const RecoverPassword(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: "/account",
      page: () => const Account(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: "/settings",
      page: () => const Settings(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: "/helpcenter",
      page: () => const HelpCenter(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: "/splash",
      page: () => const Splash(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: "/aboutapp",
      page: () => const AboutApp(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: "/reportaproblem",
      page: () => const ReportaProblem(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: "/privacy",
      page: () => const Privacy(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: "/supportcenter",
      page: () => const CallSupportCenter(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: "/productcomments",
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return ProductComments(id: args["id"].toString());
      },
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: "/storereviews",
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return StoreReviews(id: args["id"].toString());
      },
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: "/cartpage",
      page: () => const CartPage(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: "/confirmationpage",
      page: () => const ConfirmationPage(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: "/checkoutpage",
      page: () => const CheckoutPage(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: "/storeproducts",
      page: () => const StoreProducts(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: "/mainpage",
      page: () => const MainPage(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
    name: "/productdetails",
    page: () {
      final args = Get.arguments as Map<String, dynamic>;
      return ProductDetails(id: args["id"].toString());
    },
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: "/storedetails",
    page: () {
      final args = Get.arguments as Map<String, dynamic>;
      return StoreDetails(id: args["id"].toString());
    },
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: "/bazaardetails",
    page: () {
      final args = Get.arguments as Map<String, dynamic>;
      return BazaarDetails(id: args["id"]);
    },
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
      name: "/bazaarproducts",
      page: () => const BazaarProducts(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: "/bazaarreviews",
      page: () => const BazaarReviews(),
      transition: Transition.rightToLeftWithFade),
];
