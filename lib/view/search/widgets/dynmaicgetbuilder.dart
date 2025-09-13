import 'package:bazaartech/view/search/controller/bazaarfiltercontroller.dart';
import 'package:bazaartech/view/search/controller/productfilercontroller.dart';
import 'package:bazaartech/view/search/controller/storefiltercontroller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DynamicGetBuilder extends StatelessWidget {
  final String controllerKind;
  final Widget Function(dynamic) builder;

  const DynamicGetBuilder({
    super.key,
    required this.controllerKind,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    switch (controllerKind) {
      case 'product':
        return GetBuilder<ProductFilterController>(
          builder: (c) => builder(c),
        );
      case 'store':
        return GetBuilder<StoreFilterController>(
          builder: (c) => builder(c),
        );
      case 'bazaar':
      default:
        return GetBuilder<BazaarFilterController>(
          builder: (c) => builder(c),
        );
    }
  }
}
