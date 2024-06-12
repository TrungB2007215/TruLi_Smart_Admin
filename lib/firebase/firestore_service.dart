import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(Map<String, dynamic> userData) async {
    await _firestore.collection('Users').add(userData);
  }

  Future<void> addCart(Map<String, dynamic> cartData) async {
    await _firestore.collection('Cart').add(cartData);
  }

  Future<void> addCatelogies(Map<String, dynamic> catelogiesData) async {
    await _firestore.collection('Catelogies').add(catelogiesData);
  }

  Future<void> addImportLogs(Map<String, dynamic> importLogsData) async {
    await _firestore.collection('Import_logs').add(importLogsData);
  }

  Future<void> addReviews(Map<String, dynamic> reviewsData) async {
    await _firestore.collection('Reviews').add(reviewsData);
  }

  Future<void> addProducts(Map<String, dynamic> productsData) async {
    await _firestore.collection('Products').add(productsData);
  }

  Future<void> addImage(Map<String, dynamic> imageData) async {
    await _firestore.collection('Image').add(imageData);
  }

  Future<void> addBrand(Map<String, dynamic> brandData) async {
    await _firestore.collection('Brand').add(brandData);
  }

  Future<void> addTechnicalSpecifications(Map<String, dynamic> technicalSpecificationsData) async {
    await _firestore.collection('TechnicalSpecifications').add(technicalSpecificationsData);
  }

  Future<void> addOrderDetails(Map<String, dynamic> orderDetailsData) async {
    await _firestore.collection('Order_Details').add(orderDetailsData);
  }

  Future<void> addOrders(Map<String, dynamic> ordersData) async {
    await _firestore.collection('Orders').add(ordersData);
  }

  Future<void> addProductColors(Map<String, dynamic> productColorsData) async {
    await _firestore.collection('Product_Colors').add(productColorsData);
  }

  Future<void> addColor(Map<String, dynamic> colorData) async {
    await _firestore.collection('Color').add(colorData);
  }

  Future<void> addAddresses(Map<String, dynamic> addressesData) async {
    await _firestore.collection('Addresses').add(addressesData);
  }

  Future<void> addProvinces(Map<String, dynamic> provincesData) async {
    await _firestore.collection('Provinces').add(provincesData);
  }

  Future<void> addDistricts(Map<String, dynamic> districtsData) async {
    await _firestore.collection('Districts').add(districtsData);
  }

  Future<void> addWards(Map<String, dynamic> wardsData) async {
    await _firestore.collection('Wards').add(wardsData);
  }
}
