import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/cart/controller/checkoutcontroller.dart';
import 'package:bazaartech/view/cart/widgets/addaddressdialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressContainer extends StatelessWidget {
  final String id;
  final String place;
  final String number;
  final String addressValue;
  final String address;
  final double latitude;
  final double longitude;
  final bool isSelected;
  final VoidCallback onSelect;

  const AddressContainer({
    super.key,
    required this.place,
    required this.number,
    required this.address,
    required this.addressValue,
    required this.isSelected,
    required this.onSelect,
    required this.latitude,
    required this.longitude,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      onLongPress: () {
        Get.defaultDialog(
            title: 'Delete!',
            titleStyle: const TextStyle(color: AppColors.red),
            middleText: 'You sure you want to delete this address?',
            middleTextStyle: const TextStyle(color: AppColors.red),
            backgroundColor: AppColors.white,
            buttonColor: AppColors.red,
            cancelTextColor: AppColors.primaryFontColor,
            textConfirm: 'Delete!',
            textCancel: 'Cancel',
            confirmTextColor: AppColors.white,
            onConfirm: () async {
              await Get.find<CheckoutController>().deleteAddress(id);
            },
            onCancel: () {});
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius:
              BorderRadius.circular(MediaQueryUtil.screenWidth / 51.5),
        ),
        padding: EdgeInsets.all(MediaQueryUtil.screenWidth / 25.75),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place,
                  style: TextStyle(
                    fontSize: MediaQueryUtil.screenWidth / 22.88,
                    color: AppColors.black,
                    fontFamily: FontFamily.russoOne,
                  ),
                ),
                Text(
                  number,
                  style: TextStyle(
                    fontSize: MediaQueryUtil.screenWidth / 25.75,
                    color: AppColors.black60,
                  ),
                ),
                SizedBox(
                  width: MediaQueryUtil.screenWidth / 2,
                  child: Text(
                    address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: MediaQueryUtil.screenWidth / 25.75,
                      color: AppColors.black60,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    final editFormKey = GlobalKey<FormState>();
                    showDialog(
                      context: context,
                      builder: (context) => AddAddressDialog(
                        formKey: editFormKey,
                        initialPlace: place,
                        initialNumber: number,
                        initialAddress: address,
                        initialLatLng: LatLng(latitude, longitude),
                        isSelected: isSelected,
                        isFirstAddress: false,
                        onAdd: (updatedAddress) {
                          final updated = updatedAddress.copyWith(
                            id: addressValue,
                            isSelected: isSelected,
                          );
                          Get.find<CheckoutController>().updateAddress(updated);
                        },
                      ),
                    );
                  },
                  child: Image.asset(
                    AppImages.editIcon,
                    width: MediaQueryUtil.screenWidth / 25.75,
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, MediaQueryUtil.screenHeight / 56.26),
                  child: Radio(
                    activeColor: AppColors.primaryOrangeColor,
                    value: addressValue,
                    groupValue: isSelected ? addressValue : null,
                    onChanged: (context) => onSelect(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
