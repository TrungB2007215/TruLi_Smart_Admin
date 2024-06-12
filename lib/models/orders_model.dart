class OrdersModel {
  final String orderId;
  final String userId;
  final String name;
  final String phone;
  final DateTime orderDate;
  final String orderStatus;
  final double totalValue;
  final int addressId;

  OrdersModel({
    required this.orderId,
    required this.userId,
    required this.name,
    required this.phone,
    required this.orderDate,
    required this.orderStatus,
    required this.totalValue,
    required this.addressId,
  });

  Map<String, dynamic> toMap() {
    return {
      'order_id': orderId,
      'user_id': userId,
      'name': name,
      'phone': phone,
      'order_date': orderDate.toIso8601String(),
      'order_status': orderStatus,
      'total_value': totalValue,
      'address_id': addressId,
    };
  }

  factory OrdersModel.fromMap(Map<String, dynamic> map) {
    return OrdersModel(
      orderId: map['order_id'],
      userId: map['user_id'],
      name: map['name'],
      phone: map['phone'],
      orderDate: DateTime.parse(map['order_date']),
      orderStatus: map['order_status'],
      totalValue: map['total_value'],
      addressId: map['address_id'],
    );
  }
}
