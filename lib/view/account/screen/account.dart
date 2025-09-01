import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/const_data/text_style.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:bazaartech/view/account/controller/accountcontroller.dart';
import 'package:bazaartech/view/account/widgets/accountappbar.dart';
import 'package:bazaartech/view/account/widgets/agefield.dart';
import 'package:bazaartech/view/account/widgets/emailfield.dart';
import 'package:bazaartech/view/account/widgets/genderfield.dart';
import 'package:bazaartech/view/account/widgets/namefield.dart';
import 'package:bazaartech/view/account/widgets/numberfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    AccountController controller = Get.find<AccountController>();
    MediaQueryUtil.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const AccountAppBar(),
      body: Form(
        key: controller.globalKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQueryUtil.screenHeight / 42.2,
                  right: MediaQueryUtil.screenWidth / 20.6,
                  left: MediaQueryUtil.screenWidth / 20.6,
                  bottom: MediaQueryUtil.screenHeight / 42.2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    Text('Photo', style: FontStyles.fieldTitleStyle(context)),
                    Center(
                      child: Column(
                        children: [
                          Obx(() => GestureDetector(
                                onTap: () => controller.imageButtonFunction(),
                                child: CircleAvatar(
                                  radius: MediaQueryUtil.screenWidth / 10,
                                  backgroundColor: Colors.grey.shade200,
                                  child: ClipOval(
                                    child: controller.profileImage.value != null
                                        ? Image.file(
                                            controller.profileImage.value!,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          )
                                        : controller.profileImageUrl.isNotEmpty
                                            ? CachedNetworkImage(
                                                imageUrl: controller
                                                    .profileImageUrl.value,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          strokeWidth: 2),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset(
                                                  AppImages.profilephoto,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                ),
                                              )
                                            : Image.asset(
                                                AppImages.profilephoto,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                              ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    )
                  ]),
                  SizedBox(height: MediaQueryUtil.screenHeight / 25),
                  const NameField(),
                  SizedBox(height: MediaQueryUtil.screenHeight / 15),
                  const AgeField(),
                  SizedBox(height: MediaQueryUtil.screenHeight / 15),
                  const EmailField(),
                  SizedBox(height: MediaQueryUtil.screenHeight / 15),
                  const NumberField(),
                  SizedBox(height: MediaQueryUtil.screenHeight / 15),
                  const GenderField(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
