import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/link.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:bazaartech/model/usermodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AccountController extends GetxController {
  final myService = Get.find<MyService>();

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Rx<File?> profileImage = Rx<File?>(null);
  RxString selectedGender = ''.obs;
  var user = Rx<UserModel?>(null);
  var isLoading = false.obs;

  Future<void> loadUserData() async {
    try {
      isLoading.value = true;

      final prefs = myService.sharedPreferences;
      final token = prefs.getString(SharedPreferencesKey.tokenKey);

      if (token == null) {
        Get.snackbar("Error", "No token found, please login again");
        return;
      }

      final response = await http.get(
        Uri.parse(AppLink.profile),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        user.value = UserModel.fromJson(data["data"]);
        nameController.text = user.value!.name;
        emailController.text = user.value!.email;
        phoneController.text = user.value!.phoneNumber;
        if (user.value!.age != null) {
          ageController.text = user.value!.age.toString();
        }
        if (user.value!.gender != null) {
          selectedGender.value = user.value!.gender.toString();
        }
      } else {
        Get.snackbar("Error", data["message"] ?? "Failed to load profile");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void loadProfileImage() {
    final base64Image = myService.sharedPreferences
        .getString(SharedPreferencesKey.userImageKey);

    if (base64Image?.isNotEmpty ?? false) {
      try {
        final bytes = base64Decode(base64Image!);
        final tempDir = Directory.systemTemp;
        final file = File('${tempDir.path}/profile_image.jpg');
        file.writeAsBytesSync(bytes);
        profileImage.value = file;
      } catch (e) {
        ToastUtil.showToast("Failed to decode profile image: $e");
      }
    }
  }

  Future<void> saveInfo() async {
    try {
      isLoading.value = true;

      final prefs = myService.sharedPreferences;
      final token = prefs.getString(SharedPreferencesKey.tokenKey);

      if (token == null) {
        Get.snackbar("Error", "No token found, please login again");
        return;
      }

      final response = await http.put(
        Uri.parse(AppLink.profile),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "name": nameController.text,
          "email": emailController.text,
          "number": phoneController.text,
          "age": ageController.text,
          "gender": selectedGender.value,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        //data coming from put profile api are all String which is different from User model which has int types age and gender
        // user.value = UserModel.fromJson(data["data"]);
        loadUserData();
        ToastUtil.showToast('Account information updated');
      } else {
        Get.snackbar("Error", data["message"] ?? "Failed to update profile");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final compressedBytes = await compressImage(imageFile);

      if (compressedBytes != null) {
        final base64Image = base64Encode(compressedBytes);
        await myService.sharedPreferences.setString(
          SharedPreferencesKey.userImageKey,
          base64Image,
        );

        final tempDir = Directory.systemTemp;
        final tempFile = File(
            '${tempDir.path}/profile_image_${DateTime.now().millisecondsSinceEpoch}.jpg');
        await tempFile.writeAsBytes(compressedBytes);

        final isFirstTime = profileImage.value == null;
        profileImage.value = tempFile;

        ToastUtil.showToast(
          isFirstTime ? 'Profile picture added!' : 'Profile picture updated!',
        );
      }
    }
  }

  Future<Uint8List?> compressImage(File file) async {
    return await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 300,
      quality: 60,
      format: CompressFormat.jpeg,
    );
  }

  void selectGender(String gender) {
    selectedGender.value = gender;
  }

  Future<void> removeProfileImage() async {
    Get.defaultDialog(
        title: 'Remove picture',
        titleStyle: const TextStyle(color: AppColors.primaryFontColor),
        middleText: 'You sure you want to remove your picture?',
        middleTextStyle: const TextStyle(color: AppColors.primaryOrangeColor),
        backgroundColor: AppColors.white,
        buttonColor: AppColors.primaryOrangeColor,
        cancelTextColor: AppColors.primaryFontColor,
        textConfirm: 'Yes!',
        textCancel: 'Cancel',
        confirmTextColor: AppColors.white,
        onConfirm: () async {
          final prefs = myService.sharedPreferences;
          await prefs.remove(SharedPreferencesKey.userImageKey);
          final tempFile =
              File('${Directory.systemTemp.path}/profile_image.jpg');
          if (await tempFile.exists()) {
            await tempFile.delete();
          }
          profileImage.value = null;
          ToastUtil.showToast("Profile picture removed!");
          Get.back();
        },
        onCancel: () {});
  }

  void imageButtonFunction() {
    final hasImage = profileImage.value != null;

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
                            Future.delayed(const Duration(milliseconds: 200),
                                () {
                              showDialog(
                                  context: Get.context!,
                                  builder: (context) {
                                    return Dialog(
                                        backgroundColor: Colors.transparent,
                                        child: InteractiveViewer(
                                            child: AspectRatio(
                                                aspectRatio: 1,
                                                child: Image.file(
                                                    profileImage.value!,
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
                            showPictureSourceBottomSheet();
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
                            removeProfileImage();
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
                          pickImage(ImageSource.camera);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.photo_library,
                            color: AppColors.primaryOrangeColor),
                        title: const Text("Gallery"),
                        onTap: () {
                          Get.back();
                          pickImage(ImageSource.gallery);
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

  void showPictureSourceBottomSheet() {
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
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library,
                  color: AppColors.primaryOrangeColor),
              title: const Text("Gallery"),
              onTap: () {
                Get.back();
                pickImage(ImageSource.gallery);
              },
            ),
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

  @override
  void onInit() {
    loadUserData();
    loadProfileImage();
    super.onInit();
  }
}
