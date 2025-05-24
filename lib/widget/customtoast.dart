import 'package:fluttertoast/fluttertoast.dart';
import 'package:bazaartech/core/const_data/app_colors.dart';

class ToastUtil {
  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.NONE,
        backgroundColor: AppColors.primaryFontColor,
        textColor: AppColors.white,
        fontSize: 14,
        fontAsset: 'assets/fonts/Montserrat-Medium.ttf');
  }
}
