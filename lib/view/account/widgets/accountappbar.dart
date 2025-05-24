import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/account/controller/accountcontroller.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AccountAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    AccountController controller = Get.find<AccountController>();
    MediaQueryUtil.init(context);
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(MediaQueryUtil.screenHeight / 24.14)),
      child: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(top: MediaQueryUtil.screenHeight / 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.translate(
                offset: Offset(-MediaQueryUtil.screenWidth / 41.2, 0),
                child: Row(children: [
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: Image.asset(AppImages.appbarArrowBack,
                          width: MediaQueryUtil.screenWidth / 17.16)),
                  Text(
                    'Account',
                    style: TextStyle(
                      fontSize: MediaQueryUtil.screenWidth / 12.875,
                      fontFamily: FontFamily.russoOne,
                    ),
                  ),
                ]),
              ),
              Transform.translate(
                offset: Offset(MediaQueryUtil.screenWidth / 82.4, 0),
                child: IconButton(
                    onPressed: () {
                      if (controller.globalKey.currentState!.validate()) {
                        if (controller.selectedGender.value != '') {
                          controller.saveInfo();
                        } else {
                          ToastUtil.showToast(
                              'Please select a gender before saving!');
                        }
                      }
                    },
                    icon: Image.asset(AppImages.sendreportIcon,
                        width: MediaQueryUtil.screenWidth / 15.84)),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(MediaQueryUtil.screenHeight / 12);
}
