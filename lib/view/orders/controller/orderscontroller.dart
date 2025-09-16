import 'package:bazaartech/core/repositories/orderrepo.dart';
import 'package:bazaartech/model/ordermodel.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  final OrderRepo _orderRepo = OrderRepo();

  bool isLoading = false;
  List<OrderModel> orders = <OrderModel>[];

  Future<void> fetchOrders() async {
    try {
      isLoading = true;
      update();
      final fetchedOrders = await _orderRepo.fetchOrders();
      orders.assignAll(fetchedOrders);
    } catch (e) {
      print("Error fetching orders: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }
}
