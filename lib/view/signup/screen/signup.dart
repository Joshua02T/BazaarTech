import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:bazaartech/core/const_data/text_style.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/signup/controller/signupcontroller.dart';
import 'package:bazaartech/widget/custombutton.dart';
import 'package:bazaartech/widget/customconfirmpassword.dart';
import 'package:bazaartech/widget/customnamefield.dart';
import 'package:bazaartech/widget/customphonefield.dart';
import 'package:bazaartech/widget/emailfield.dart';
import 'package:bazaartech/widget/passwordfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryUtil.init(context);
    SignUpController controller = Get.put(SignUpController());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: MediaQueryUtil.screenWidth / 13.73,
                right: MediaQueryUtil.screenWidth / 13.73,
                top: MediaQueryUtil.screenHeight / 35,
              ),
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Create Account',
                          style: TextStyle(
                            fontFamily: FontFamily.russoOne,
                            color: AppColors.primaryOrangeColor,
                            fontSize: MediaQueryUtil.screenWidth / 20.6,
                          ),
                        ),
                        Text(
                          'It’s free and easy to set up',
                          style: TextStyle(
                            color: AppColors.primaryFontColor,
                            fontSize: MediaQueryUtil.screenWidth / 29.42,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQueryUtil.screenHeight / 33.76),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQueryUtil.screenWidth / 13.73,
                  ),
                  child: Form(
                    key: controller.globalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Full Name',
                            style: FontStyles.fieldTitleStyle(context)),
                        SizedBox(height: MediaQueryUtil.screenHeight / 100),
                        CustomNameField(contoller: controller.nameContoller),
                        SizedBox(height: MediaQueryUtil.screenHeight / 52.75),
                        Text('Email',
                            style: FontStyles.fieldTitleStyle(context)),
                        SizedBox(height: MediaQueryUtil.screenHeight / 100),
                        CustomEmailField(contoller: controller.emailContoller),
                        SizedBox(height: MediaQueryUtil.screenHeight / 52.75),
                        Text('Mobile Number',
                            style: FontStyles.fieldTitleStyle(context)),
                        SizedBox(height: MediaQueryUtil.screenHeight / 100),
                        CustomPhoneField(controller: controller.phoneContoller),
                        Text('Password',
                            style: FontStyles.fieldTitleStyle(context)),
                        SizedBox(height: MediaQueryUtil.screenHeight / 100),
                        CustomPasswordField(
                          textEditingController: controller.passwordContoller,
                          controller: controller,
                        ),
                        SizedBox(height: MediaQueryUtil.screenHeight / 52.75),
                        Text('Confirm Password',
                            style: FontStyles.fieldTitleStyle(context)),
                        SizedBox(height: MediaQueryUtil.screenHeight / 100),
                        CustomConfirmPasswordField(
                          textEditingController:
                              controller.confirmPasswordContoller,
                          controller: controller,
                        ),
                        SizedBox(height: MediaQueryUtil.screenHeight / 21.1),
                        CustomButton(
                            title: 'Sign Up',
                            onPressed: () => controller.signUp()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQueryUtil.screenHeight / 60,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already Have An Account?',
                    style: FontStyles.havingAccTextStyle(context),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Sign In',
                      style: FontStyles.havingAccSignStyle(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
