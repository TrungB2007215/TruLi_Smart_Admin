class TechnicalSpecificationsModel {
  final String tsId;
  final String productId;
  final String operatingSystem;
  final String processor;
  final int ram;
  final int rom;
  final double screenSize;
  final String camera;
  final String batteryCapacity;
  final double weight;

  TechnicalSpecificationsModel({
    required this.tsId,
    required this.productId,
    required this.operatingSystem,
    required this.processor,
    required this.ram,
    required this.rom,
    required this.screenSize,
    required this.camera,
    required this.batteryCapacity,
    required this.weight,
  });

  Map<String, dynamic> toMap() {
    return {
      'ts_id': tsId,
      'product_id': productId,
      'operating_system': operatingSystem,
      'processor': processor,
      'ram': ram,
      'rom': rom,
      'screen_size': screenSize,
      'camera': camera,
      'battery_capacity': batteryCapacity,
      'weight': weight,
    };
  }

  factory TechnicalSpecificationsModel.fromMap(Map<String, dynamic> map) {
    return TechnicalSpecificationsModel(
      tsId: map['ts_id'],
      productId: map['product_id'],
      operatingSystem: map['operating_system'],
      processor: map['processor'],
      ram: map['ram'],
      rom: map['rom'],
      screenSize: map['screen_size'],
      camera: map['camera'],
      batteryCapacity: map['battery_capacity'],
      weight: map['weight'],
    );
  }
}
