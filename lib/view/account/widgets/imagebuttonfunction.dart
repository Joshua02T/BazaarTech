import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/account/controller/accountcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

void showImageBottomSheet() {
  AccountController controller = Get.find<AccountController>();
  final hasImage = controller.profileImageUrl.value != '';

  Get.bottomSheet(
    Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQueryUtil.screenWidth / 41.2,
        vertical: MediaQueryUtil.screenHeight / 42.2,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(MediaQueryUtil.screenWidth / 20.6),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          hasImage
              ? Column(
                  children: [
                    ListTile(
                        leading: const Icon(Icons.visibility,
                            color: AppColors.primaryOrangeColor),
                        title: const Text("See profile picture"),
                        onTap: () {
                          Get.back();
                          Future.delayed(const Duration(milliseconds: 200), () {
                            showDialog(
                                context: Get.context!,
                                builder: (context) {
                                  return Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: InteractiveViewer(
                                          child: AspectRatio(
                                              aspectRatio: 1,
                                              child: Image.network(
                                                  controller
                                                      .profileImageUrl.value,
                                                  fit: BoxFit.contain))));
                                });
                          });
                        }),
                    ListTile(
                      leading: const Icon(Icons.image,
                          color: AppColors.primaryOrangeColor),
                      title: const Text("Choose profile picture"),
                      onTap: () {
                        Get.back();
                        Future.delayed(const Duration(milliseconds: 200), () {
                          controller.showPictureSourceBottomSheet();
                        });
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.delete,
                          color: AppColors.primaryOrangeColor),
                      title: const Text("Remove picture"),
                      onTap: () {
                        Get.back();
                        Future.delayed(const Duration(milliseconds: 200), () {
                          controller.removeProfileImage();
                        });
                      },
                    )
                  ],
                )
              : Column(
                  children: [
                    Text(
                      "Choose picture source",
                      style: TextStyle(
                        fontSize: MediaQueryUtil.screenWidth / 22.88,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryFontColor,
                      ),
                    ),
                    SizedBox(height: MediaQueryUtil.screenHeight / 84.4),
                    ListTile(
                      leading: const Icon(Icons.camera_alt,
                          color: AppColors.primaryOrangeColor),
                      title: const Text("Camera"),
                      onTap: () {
                        Get.back();
                        controller.pickImage(ImageSource.camera);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.photo_library,
                          color: AppColors.primaryOrangeColor),
                      title: const Text("Gallery"),
                      onTap: () {
                        Get.back();
                        controller.pickImage(ImageSource.gallery);
                      },
                    ),
                  ],
                )
        ],
      ),
    ),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(MediaQueryUtil.screenWidth / 20.6),
      ),
    ),
  );
}
