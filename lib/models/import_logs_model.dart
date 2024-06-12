class ImportLogsModel {
  final String importId;
  final String productId;
  final String userId;
  final DateTime importDate;
  final int quantity;
  final double cost;

  ImportLogsModel({
    required this.importId,
    required this.productId,
    required this.userId,
    required this.importDate,
    required this.quantity,
    required this.cost,
  });

  Map<String, dynamic> toMap() {
    return {
      'import_id': importId,
      'product_id': productId,
      'user_id': userId,
      'import_date': importDate.toIso8601String(),
      'quantity': quantity,
      'cost': cost,
    };
  }

  factory ImportLogsModel.fromMap(Map<String, dynamic> map) {
    return ImportLogsModel(
      importId: map['import_id'],
      productId: map['product_id'],
      userId: map['user_id'],
      importDate: DateTime.parse(map['import_date']),
      quantity: map['quantity'],
      cost: map['cost'],
    );
  }
}
