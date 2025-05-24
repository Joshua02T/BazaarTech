import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/view/cart/models/addressmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressDialog extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String? initialPlace;
  final String? initialNumber;
  final String? initialAddress;
  final Function(AddressModel) onAdd;
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
  });

  @override
  State<AddAddressDialog> createState() => _AddAddressDialogState();
}

class _AddAddressDialogState extends State<AddAddressDialog> {
  late TextEditingController placeController;
  late TextEditingController numberController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    placeController = TextEditingController(text: widget.initialPlace);
    numberController = TextEditingController(text: widget.initialNumber);
    addressController = TextEditingController(text: widget.initialAddress);
  }

  @override
  void dispose() {
    placeController.dispose();
    numberController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: AlertDialog(
        title: const Text("Add Address",
            style: TextStyle(color: AppColors.black70)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              style: const TextStyle(color: AppColors.black60),
              controller: placeController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "Place",
                floatingLabelStyle:
                    TextStyle(color: AppColors.primaryOrangeColor),
                hintText: 'Home, Office, etc..',
                focusedBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
                errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.black60)),
                focusedErrorBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
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
            TextFormField(
              style: const TextStyle(color: AppColors.black60),
              controller: numberController,
              maxLength: 10,
              keyboardType: TextInputType.phone,
              validator: (phoneNumber) {
                if (phoneNumber!.isEmpty) {
                  return 'Phone number cannot be empty';
                }
                if (!RegExp(r'^09\d{8}$').hasMatch(phoneNumber)) {
                  return 'Phone number must start with 09 and be exactly 10 digits';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: "Phone Number",
                floatingLabelStyle:
                    TextStyle(color: AppColors.primaryOrangeColor),
                hintText: '09**',
                focusedBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
                errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.black60)),
                focusedErrorBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            TextFormField(
              style: const TextStyle(color: AppColors.black60),
              controller: addressController,
              keyboardType: TextInputType.streetAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter an address';
                }

                final regex = RegExp(r'^[A-Za-z\s,]{2,30}$');
                if (!regex.hasMatch(value.trim())) {
                  return 'Enter a valid address (e.g. Talkalakh, Homs)';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: "Address",
                floatingLabelStyle:
                    TextStyle(color: AppColors.primaryOrangeColor),
                hintText: 'Talkalakh, Homs',
                focusedBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
                errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.black60)),
                focusedErrorBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              "Cancel",
              style: TextStyle(color: AppColors.primaryOrangeColor),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (widget.formKey.currentState!.validate()) {
                final newAddress = AddressModel(
                  place: placeController.text,
                  number: numberController.text,
                  address: addressController.text,
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  isSelected: widget.isSelected ?? widget.isFirstAddress,
                );
                widget.onAdd(newAddress);
                Get.back();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOrangeColor,
              foregroundColor: AppColors.white,
            ),
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
