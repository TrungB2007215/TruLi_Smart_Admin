class OrderDetailsModel {
  final String orderDetailId;
  final String orderId;
  final String productId;
  final String quantity;
  final double price;

  OrderDetailsModel({
    required this.orderDetailId,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'order_detail_id': orderDetailId,
      'order_id': orderId,
      'product_id': productId,
      'quantity': quantity,
      'price': price,
    };
  }

  factory OrderDetailsModel.fromMap(Map<String, dynamic> map) {
    return OrderDetailsModel(
      orderDetailId: map['order_detail_id'],
      orderId: map['order_id'],
      productId: map['product_id'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }
}
