import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/brand_model.dart';

class BrandService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> doesBrandExist(String brandName) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('brands')
          .where('name', isEqualTo: brandName)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking brand existence: $e");
      return false;
    }
  }

  Future<void> addBrand(String brandName, Uint8List imageData, String category) async {
    try {
      await FirebaseFirestore.instance.collection('brands').add({
        'name': brandName,
        'image': imageData,
        'category': category,
      });
    } catch (e) {
      print("Error adding brand: $e");
      throw Exception("Error adding brand");
    }
  }

  Future<List<String>> getAllBrands() async {
    List<String> brands = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firestore.collection('brands').get();

      querySnapshot.docs.forEach((doc) {
        String brandName = doc.data()['name'];
        brands.add(brandName);
      });

      return brands;
    } catch (e) {
      print('Error fetching brands: $e');
      return [];
    }
  }

  Future<bool> removeBrand(String brandName) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('brands')
          .where('name', isEqualTo: brandName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Lặp qua các tài liệu thương hiệu có tên trùng khớp
        for (DocumentSnapshot document in querySnapshot.docs) {
          // Xóa tài liệu thương hiệu khỏi Firestore
          await document.reference.delete();
        }
        return true; // Trả về true nếu xóa thành công
      } else {
        // Không tìm thấy thương hiệu để xóa
        return false;
      }
    } catch (e) {
      print('Error removing brand: $e');
      return false; // Trả về false nếu có lỗi xảy ra trong quá trình xóa
    }
  }


}
