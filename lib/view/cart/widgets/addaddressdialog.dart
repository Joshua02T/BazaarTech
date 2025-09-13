import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/view/cart/controller/locationpicker.dart';
import 'package:bazaartech/view/cart/models/addressmodel.dart';
import 'package:bazaartech/view/cart/screen/getlocationpage.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressDialog extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String? initialPlace;
  final String? initialNumber;
  final String? initialAddress;
  final Function(AddressModel) onAdd;
  final LatLng? initialLatLng;
  final bool isFirstAddress;
  final bool? isSelected;

  const AddAddressDialog({
    super.key,
    required this.formKey,
    this.initialPlace,
    this.initialNumber,
    this.initialAddress,
    this.isFirstAddress = false,
    this.isSelected,
    required this.onAdd,
    this.initialLatLng,
  });

  @override
  State<AddAddressDialog> createState() => _AddAddressDialogState();
}

class _AddAddressDialogState extends State<AddAddressDialog> {
  late TextEditingController placeController;
  late TextEditingController numberController;

  LatLng? selectedLocation;
  String locationAddress = '';

  final LocationPickerController locationController =
      Get.find<LocationPickerController>();

  @override
  void initState() {
    super.initState();
    placeController = TextEditingController(text: widget.initialPlace);
    numberController = TextEditingController(text: widget.initialNumber);
    locationAddress = widget.initialAddress ?? '';
    selectedLocation = widget.initialLatLng;
  }

  @override
  void dispose() {
    placeController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: AlertDialog(
        backgroundColor: AppColors.white,
        title: const Text("Add Address",
            style: TextStyle(color: AppColors.black70)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Place Name
              TextFormField(
                controller: placeController,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: AppColors.black60),
                decoration: const InputDecoration(
                  labelText: "Place Name",
                  hintText: "Home, Office, etc..",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a place';
                  }
                  final regex = RegExp(r'^[A-Za-z\s,]{2,30}$');
                  if (!regex.hasMatch(value.trim())) {
                    return 'Enter a valid place (e.g. Home, Office)';
                  }
                  return null;
                },
              ),

              // Phone Number
              TextFormField(
                controller: numberController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                style: const TextStyle(color: AppColors.black60),
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  hintText: "09**",
                ),
                validator: (phoneNumber) {
                  if (phoneNumber == null || phoneNumber.isEmpty) {
                    return 'Phone number cannot be empty';
                  }
                  if (!RegExp(r'^09\d{8}$').hasMatch(phoneNumber)) {
                    return 'Phone number must start with 09 and be exactly 10 digits';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              ElevatedButton.icon(
                icon: const Icon(Icons.map),
                label: Text(
                  selectedLocation == null
                      ? "Pick location on map"
                      : "Location Selected",
                ),
                onPressed: () async {
                  LatLng? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const LocationPickerPage()),
                  );
                  if (result != null) {
                    final address =
                        await locationController.getAddressFromLatLng(
                            result.latitude, result.longitude);
                    setState(() {
                      selectedLocation = result;
                      locationAddress = address;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedLocation == null
                      ? AppColors.primaryOrangeColor
                      : Colors.green,
                  foregroundColor: AppColors.white,
                ),
              ),

              if (selectedLocation != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          locationAddress,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: AppColors.black60),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 20),
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: locationAddress));
                          ToastUtil.showToast("Copied to clipboard");
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (widget.formKey.currentState!.validate()) {
                if (selectedLocation == null) {
                  ToastUtil.showToast("Please pick a location.");
                  return;
                }
                final newAddress = AddressModel(
                    id: "",
                    place: placeController.text.trim(),
                    number: numberController.text.trim(),
                    address: locationAddress,
                    latitude: selectedLocation!.latitude,
                    longitude: selectedLocation!.longitude);

                widget.onAdd(newAddress);
                Get.back();
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
