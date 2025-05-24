import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/core/service/routes.dart';
import 'package:bazaartech/view/reportaproblem/controller/reportcontroller.dart';
import 'package:bazaartech/view/reportaproblem/widgets/textformfield.dart';
import 'package:bazaartech/widget/customappbarwithback.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportaProblem extends StatelessWidget {
  const ReportaProblem({super.key});

  @override
  Widget build(BuildContext context) {
    ReportaProblemController controller = Get.put(ReportaProblemController());
    MediaQueryUtil.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBarWithBack(text: 'Report A Problem'),
      body: Form(
        key: controller.key,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQueryUtil.screenHeight / 26.375,
                  right: MediaQueryUtil.screenWidth / 20.6,
                  left: MediaQueryUtil.screenWidth / 20.6),
              child: Column(
                children: [
                  IssueTextField(controller: controller),
                  SizedBox(height: MediaQueryUtil.screenHeight / 42.2),
                  MaterialButton(
                      minWidth: MediaQueryUtil.screenWidth / 1.03,
                      height: MediaQueryUtil.screenHeight / 21.1,
                      color: AppColors.borderLightGrey,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              MediaQueryUtil.screenWidth / 34.33)),
                      onPressed: () {},
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppImages.cardImageIcon, width: 24),
                            SizedBox(width: MediaQueryUtil.screenWidth / 41.2),
                            Text('Upload From Phone',
                                style: TextStyle(
                                    fontSize:
                                        MediaQueryUtil.screenWidth / 29.42,
                                    color: AppColors.primaryFontColor,
                                    fontWeight: FontWeight.w500))
                          ])),
                  MaterialButton(
                      minWidth: MediaQueryUtil.screenWidth / 1.03,
                      height: MediaQueryUtil.screenHeight / 21.1,
                      color: AppColors.borderLightGrey,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              MediaQueryUtil.screenWidth / 34.33)),
                      onPressed: () => controller.key.currentState!.validate(),
                      child: Text('Send',
                          style: TextStyle(
                              fontSize: MediaQueryUtil.screenWidth / 29.42,
                              color: AppColors.primaryFontColor,
                              fontWeight: FontWeight.w500))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Learn more about our',
                        style: TextStyle(
                            fontSize: MediaQueryUtil.screenWidth / 25.75,
                            color: AppColors.darkGrey),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.privacy);
                        },
                        child: Text('Privacy Policy.',
                            style: TextStyle(
                                fontSize: MediaQueryUtil.screenWidth / 25.75,
                                color: AppColors.primaryOrangeColor,
                                fontWeight: FontWeight.w500)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
