import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/catelogies_model.dart';
class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> addCategory(String name) async {
    try {
      await _firestore.collection('categories').add({
        'name': name,
      });

      // Return true if the category was added successfully
      return true;
    } catch (e) {
      print('Error adding category: $e');
      // Return false if there was an error adding the category
      return false;
    }
  }

  Future<bool> doesCategoryExist(String name) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('categories')
          .where('name', isEqualTo: name)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking category existence: $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('categories').get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error getting categories: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getAllCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('categories').get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error getting all categories: $e');
      return [];
    }
  }
  Future<String?> getDocumentIdByFieldName(String fieldName, String fieldValue) async {
    try {
      // Tìm document trong collection có trường fieldName bằng giá trị fieldValue
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('categories')
          .where(fieldName, isEqualTo: fieldValue)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Lấy ID của document đầu tiên (nếu có nhiều document thì bạn có thể xử lý phù hợp)
        String documentId = snapshot.docs[0].id;
        return documentId;
      } else {
        // Trả về null nếu không tìm thấy document
        return null;
      }
    } catch (e) {
      print('Error getting document ID: $e');
      return null;
    }
  }


  Future<bool> updateCategory(String categoryId, String name) async {
    try {
      await _firestore.collection('categories').doc(categoryId).update({
        'name': name,
      });
      // Return true if the update was successful
      return true;
    } catch (e) {
      print('Error updating category: $e');
      // Return false if there was an error updating the category
      return false;
    }
  }


  Future<void> deleteCategory(String categoryId) async {
    try {
      await _firestore.collection('categories').doc(categoryId).delete();
    } catch (e) {
      print('Error deleting category: $e');
    }
  }

  Future<List<String>> getListCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await _firestore.collection('categories').get();

      List<String> categories =
      snapshot.docs.map((doc) => doc.get('name') as String).toList();

      return categories;
    } catch (e) {
      print('Error getting categories: $e');
      return [];
    }
  }

  Future<String?> findCategoryIdByName(String categoryName) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('categories')
          .where('name', isEqualTo: categoryName)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id; // Trả về categoryId nếu tìm thấy
      } else {
        return null; // Trả về null nếu không tìm thấy
      }
    } catch (e) {
      print('Lỗi khi tìm categoryId: $e');
      return null;
    }
  }

  Future<bool> removeCategory(String categoryId) async {
    try {
      await _firestore.collection('categories').doc(categoryId).delete();
      return true; // Xóa thành công
    } catch (e) {
      print('Lỗi khi xóa danh mục: $e');
      return false; // Xóa thất bại
    }
  }
}
