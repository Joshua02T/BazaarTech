import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/search/widgets/dynmaicgetbuilder.dart';
import 'package:flutter/material.dart';

class CustomLocationField extends StatelessWidget {
  final String controllerKind;
  final List<String> locations;
  final TextEditingController locationController;
  final void Function(String) onFieldSubmitted;
  const CustomLocationField(
      {super.key,
      required this.locations,
      required this.locationController,
      required this.onFieldSubmitted,
      required this.controllerKind});

  @override
  Widget build(BuildContext context) {
    return DynamicGetBuilder(
        controllerKind: controllerKind,
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (locations.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQueryUtil.screenHeight / 105.5),
                  child: Wrap(
                    spacing: MediaQueryUtil.screenWidth / 68.6,
                    children: locations.map((location) {
                      return Chip(
                        side: BorderSide.none,
                        color: const WidgetStatePropertyAll(
                            AppColors.secondaryOrangeColor),
                        label: Text(
                          location,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: AppColors.black),
                        ),
                        onDeleted: () {
                          controller.itemLocation.remove(location);
                          controller.update();
                        },
                        deleteIcon: Icon(Icons.close,
                            size: MediaQueryUtil.screenWidth / 22.88),
                      );
                    }).toList(),
                  ),
                ),
              TextFormField(
                style: const TextStyle(color: AppColors.black),
                controller: locationController,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (value) {
                  onFieldSubmitted(value.trim());
                  print(controllerKind);
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.all(MediaQueryUtil.screenWidth / 34.33),
                  fillColor: AppColors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(
                      MediaQueryUtil.screenWidth / 51.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(
                      MediaQueryUtil.screenWidth / 51.5,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      MediaQueryUtil.screenWidth / 51.5,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
