import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class LocationPickerController extends GetxController {
  final Rxn<LatLng> pickedLocation = Rxn<LatLng>();
  final TextEditingController searchController = TextEditingController();
  GoogleMapController? mapController;
  final RxString selectedAddressName = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingCurrentLocation = false.obs;

  LatLng defaultLocation = const LatLng(34.7325, 36.7135);

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void pickLocation(LatLng latLng) async {
    pickedLocation.value = latLng;
    selectedAddressName.value =
        await getAddressFromLatLng(latLng.latitude, latLng.longitude);
  }

  Future<void> moveToCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ToastUtil.showToast('Location Disabled, Please enable GPS.');

      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        ToastUtil.showToast(
            'Permission Denied, Location permission aren\'t granted.');

        return;
      }
    }
    isLoadingCurrentLocation.value = true;
    Position position = await Geolocator.getCurrentPosition();
    final currentLatLng = LatLng(position.latitude, position.longitude);
    pickedLocation.value = currentLatLng;
    selectedAddressName.value =
        await getAddressFromLatLng(position.latitude, position.longitude);
    mapController?.animateCamera(CameraUpdate.newLatLng(currentLatLng));
    isLoadingCurrentLocation.value = false;
  }

  Future<void> searchLocation() async {
    String query = searchController.text.trim();
    if (query.isEmpty) return;

    try {
      isLoading.value = true;
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final result = LatLng(locations[0].latitude, locations[0].longitude);
        pickedLocation.value = result;

        List<Placemark> placemarks = await placemarkFromCoordinates(
          result.latitude,
          result.longitude,
        );

        if (placemarks.isNotEmpty) {
          final Placemark place = placemarks[0];
          selectedAddressName.value =
              "${place.name}, ${place.locality}, ${place.country}";
        } else {
          selectedAddressName.value = "Unknown location";
        }

        mapController?.animateCamera(CameraUpdate.newLatLng(result));
        isLoading.value = false;
      } else {
        ToastUtil.showToast('Not found, No results for "$query"');
        isLoading.value = false;
      }
    } catch (e) {
      ToastUtil.showToast("Failed to find location");
      isLoading.value = false;
    }
  }

  Future<String> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        String city = placemark.locality ?? "";

        city = city.replaceAll(",", "").trim();

        return city.isEmpty ? "Unknown location" : city;
      } else {
        return "Unknown location";
      }
    } catch (e) {
      return "Location error";
    }
  }
}
