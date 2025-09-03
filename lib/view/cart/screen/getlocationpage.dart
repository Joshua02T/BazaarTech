import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/cart/widgets/getlocationappbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:bazaartech/view/cart/controller/locationpicker.dart';

class LocationPickerPage extends StatelessWidget {
  const LocationPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LocationPickerController>();

    return Scaffold(
      appBar: GetLocationAppbar(controller: controller),
      body: Stack(
        children: [
          Obx(() => GoogleMap(
                trafficEnabled: true,
                onMapCreated: controller.onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: controller.pickedLocation.value ??
                      controller.defaultLocation,
                  zoom: 14,
                ),
                onTap: controller.pickLocation,
                markers: controller.pickedLocation.value != null
                    ? {
                        Marker(
                          markerId: const MarkerId('picked'),
                          position: controller.pickedLocation.value!,
                        )
                      }
                    : {},
              )),
          Positioned(
            top: MediaQueryUtil.screenHeight / 84.4,
            left: MediaQueryUtil.screenWidth / 27.46,
            right: MediaQueryUtil.screenWidth / 27.46,
            child: Material(
              elevation: 4,
              borderRadius:
                  BorderRadius.circular(MediaQueryUtil.screenWidth / 51.5),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: AppColors.black),
                      controller: controller.searchController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: MediaQueryUtil.screenWidth / 25.75,
                            vertical: MediaQueryUtil.screenHeight / 70.33),
                        hintText: "Search location...",
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => controller.searchLocation(),
                    ),
                  ),
                  Obx(() => controller.isLoading.value
                      ? CircularProgressIndicator(
                          color: AppColors.primaryOrangeColor,
                          strokeWidth: MediaQueryUtil.screenWidth / 206,
                        )
                      : IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: controller.searchLocation,
                        )),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(() => controller.pickedLocation.value != null
          ? FloatingActionButton.extended(
              tooltip: 'Confirm your location!',
              backgroundColor: AppColors.secondaryOrangeColor,
              label: const Text(
                "Confirm Location",
                style: TextStyle(color: AppColors.primaryOrangeColor),
              ),
              icon:
                  const Icon(Icons.check, color: AppColors.primaryOrangeColor),
              onPressed: () {
                Navigator.pop(context, controller.pickedLocation.value);
              },
            )
          : const SizedBox.shrink()),
    );
  }
}
