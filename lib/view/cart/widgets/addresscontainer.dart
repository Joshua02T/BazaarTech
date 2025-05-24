import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/cart/controller/cartcontroller.dart';
import 'package:bazaartech/view/cart/widgets/addaddressdialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressContainer extends StatelessWidget {
  final String place;
  final String number;
  final String addressValue;
  final String address;
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
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
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
                Text(
                  address,
                  style: TextStyle(
                    fontSize: MediaQueryUtil.screenWidth / 25.75,
                    color: AppColors.black60,
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
                        isSelected: isSelected,
                        isFirstAddress: false,
                        onAdd: (updatedAddress) {
                          final updated = updatedAddress.copyWith(
                            id: addressValue,
                            isSelected: isSelected,
                          );
                          Get.find<CartController>().updateAddress(updated);
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
