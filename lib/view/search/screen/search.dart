import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/const_data/lists.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/search/controller/searchcontroller.dart';
import 'package:bazaartech/view/search/screen/bazaarfilter.dart';
import 'package:bazaartech/view/search/widgets/customsearchcategory.dart';
import 'package:bazaartech/view/search/screen/productfilter.dart';
import 'package:bazaartech/view/search/screen/storefilter.dart';
import 'package:bazaartech/widget/defaultappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    SearchCController controller = Get.find<SearchCController>();

    MediaQueryUtil.init(context);
    return Scaffold(
      appBar: const DefaultAppBar(title: 'Search'),
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQueryUtil.screenHeight / 52.75,
                left: MediaQueryUtil.screenWidth / 20.6,
                right: MediaQueryUtil.screenWidth / 20.6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQueryUtil.screenHeight / 22.81,
                  child: ListView.builder(
                    clipBehavior: Clip.none,
                    itemCount: searchCategoryItem.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(onTap: () {
                        controller.updateSelectedIndex(index);
                        controller.categoryTitle = searchCategoryItem[index];
                        controller.pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 1),
                          curve: Curves.fastOutSlowIn,
                        );
                      }, child: GetBuilder<SearchCController>(
                        builder: (controller) {
                          final isSelected = controller.selectedIndex == index;
                          return CustomSearchCategory(
                            title: searchCategoryItem[index],
                            isSelected: isSelected,
                          );
                        },
                      ));
                    },
                  ),
                ),
                SizedBox(height: MediaQueryUtil.screenHeight / 52.75),
                Row(
                  children: [
                    Expanded(child: GetBuilder<SearchCController>(
                      builder: (controller) {
                        return SizedBox(
                          height: MediaQueryUtil.screenHeight / 19.18,
                          child: TextField(
                            style: const TextStyle(color: AppColors.black),
                            controller: controller.searchText,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(
                                  MediaQueryUtil.screenWidth / 34.33),
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
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(
                                    MediaQueryUtil.screenWidth / 34.33),
                                child: SizedBox(
                                  width: MediaQueryUtil.screenWidth / 20.6,
                                  height: MediaQueryUtil.screenHeight / 42.2,
                                  child: Image.asset(
                                      AppImages.searchNavBarUnSelected,
                                      fit: BoxFit.contain),
                                ),
                              ),
                              prefixIconConstraints: BoxConstraints(
                                  minWidth: MediaQueryUtil.screenWidth / 20.6,
                                  minHeight:
                                      MediaQueryUtil.screenHeight / 42.2),
                              hintText:
                                  '${controller.categoryTitle.substring(0, controller.categoryTitle.length - 1)} Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    MediaQueryUtil.screenWidth / 51.5),
                              ),
                            ),
                          ),
                        );
                      },
                    )),
                    SizedBox(width: MediaQueryUtil.screenWidth / 25.75),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          showDragHandle: true,
                          backgroundColor: AppColors.backgroundColor,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return FractionallySizedBox(
                              heightFactor: 0.73,
                              child: controller.selectedIndex == 0
                                  ? const ProductSearchFilter()
                                  : controller.selectedIndex == 1
                                      ? const StoreSearchFilter()
                                      : const BazaarSearchFilter(),
                            );
                          },
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.all(MediaQueryUtil.screenWidth / 41.2),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(
                              MediaQueryUtil.screenWidth / 51.5),
                        ),
                        child: Image.asset(AppImages.filterIcon,
                            width: MediaQueryUtil.screenWidth / 17.16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQueryUtil.screenHeight / 26.375),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: (index) {
                controller.updateSelectedIndex(index);
                controller.categoryTitle = searchCategoryItem[index];
              },
              children: List.generate(
                searchCategoryItem.length,
                (index) => Padding(
                  padding: EdgeInsets.only(
                      left: MediaQueryUtil.screenWidth / 20.6,
                      right: MediaQueryUtil.screenWidth / 20.6),
                  child: const SingleChildScrollView(
                    child: Column(
                      children: [],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
