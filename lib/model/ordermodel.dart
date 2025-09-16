class OrderModel {
  final int id;
  final String paymentMethodCode;
  final String status;
  final double totalPrice;
  final String orderDate;

  OrderModel({
    required this.id,
    required this.paymentMethodCode,
    required this.status,
    required this.totalPrice,
    required this.orderDate,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      paymentMethodCode: json['paymentMethodCode'],
      status: json['status'],
      totalPrice: double.tryParse(json['totalPrice'].toString()) ?? 0.0,
      orderDate: json['orderDate'],
    );
  }
}
