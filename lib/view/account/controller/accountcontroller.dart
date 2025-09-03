import 'dart:convert';

import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/link.dart';
import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:bazaartech/helper/appconfig.dart';
import 'package:bazaartech/model/usermodel.dart';
import 'package:bazaartech/view/account/widgets/imagebuttonfunction.dart';
import 'package:bazaartech/view/account/widgets/showpicturesource.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
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

  // Remove local File reference since we're backend-only
  RxString selectedGender = ''.obs;
  var user = Rx<UserModel?>(null);
  var isLoading = false.obs;
  RxString profileImageUrl = ''.obs;

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

      final dynamic data = jsonDecode(response.body);

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
        if (user.value!.profileImage != null) {
          String url = user.value!.profileImage!;
          if (url.contains("127.0.0.1")) {
            url =
                url.replaceAll("http://127.0.0.1:8000", AppConfig.getBaseUrl());
          }
          profileImageUrl.value = url;
          print('Profile Image URL:---- ${profileImageUrl.value}');
        }
        print('outside ------ --------- ${profileImageUrl.value}');
      } else {
        Get.snackbar("Error", data["message"] ?? "Failed to load profile");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
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

      final hasTextChanged = nameController.text != (user.value?.name ?? "") ||
          emailController.text != (user.value?.email ?? "") ||
          phoneController.text != (user.value?.phoneNumber ?? "") ||
          ageController.text != (user.value?.age?.toString() ?? "") ||
          selectedGender.value != (user.value?.gender?.toString() ?? "");

      if (!hasTextChanged) {
        ToastUtil.showToast("No changes to update");
        return;
      }

      final response = await http.post(
        Uri.parse(AppLink.profile),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          '_method': 'PUT',
          'name': nameController.text,
          'email': emailController.text,
          'number': phoneController.text,
          'age': ageController.text,
          'gender': selectedGender.value,
        }),
      );

      final dynamic data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        user.value = UserModel.fromJson(data["data"]);
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

  Future<void> uploadProfileImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile == null) return;

      final prefs = myService.sharedPreferences;
      final token = prefs.getString(SharedPreferencesKey.tokenKey);

      if (token == null) {
        Get.snackbar("Error", "No token found, please login again");
        return;
      }

      ToastUtil.showToast('Uploading profile picture...');

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(AppLink.profile),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.fields['_method'] = "PUT";

      request.fields['name'] = nameController.text;
      request.fields['email'] = emailController.text;
      request.fields['number'] = phoneController.text;
      request.fields['age'] = ageController.text;
      request.fields['gender'] = selectedGender.value;

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          pickedFile.path,
          filename: 'profile_image.jpg',
        ),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Image upload response: ${response.statusCode}');
      print('Response body: ${response.body}');

      final contentType = response.headers['content-type'] ?? '';
      if (!contentType.contains('application/json')) {
        throw FormatException('Expected JSON but got: $contentType');
      }

      final dynamic data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        // Update user data with the new image
        user.value = UserModel.fromJson(data["data"]);

        if (user.value!.profileImage != null) {
          String url = user.value!.profileImage!;
          if (url.contains("127.0.0.1")) {
            url =
                url.replaceAll("http://127.0.0.1:8000", AppConfig.getBaseUrl());
          }
          profileImageUrl.value = url;
        }

        ToastUtil.showToast('Profile picture updated successfully');
      } else {
        Get.snackbar("Error", data["message"] ?? "Failed to upload image");
      }
    } on FormatException catch (e) {
      print('JSON parsing failed: $e');
      Get.snackbar(
          "Server Error", "Please check if the API endpoint is correct");
    } catch (e) {
      print('Upload error: $e');
      Get.snackbar("Error", "Failed to upload image");
    }
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
        Get.back();
        await deleteProfileImage();
      },
      onCancel: () {},
    );
  }

  void imageButtonFunction() => showImageBottomSheet();

  void showPictureSourceBottomSheet() => showHelperPictureSourceBottomSheet();

  Future<void> deleteProfileImage() async {
    try {
      final prefs = myService.sharedPreferences;
      final token = prefs.getString(SharedPreferencesKey.tokenKey);

      final response = await http.delete(
        Uri.parse(AppLink.deleteProfileImage),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        profileImageUrl.value = '';
        Get.snackbar("Success", "Profile image deleted successfully");
      } else {
        Get.snackbar(
            "Error", "Failed to delete Profile image (${response.statusCode})");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  void onInit() {
    loadUserData();
    super.onInit();
  }
}
