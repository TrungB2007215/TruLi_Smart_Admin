import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase/firebase_config.dart';
import '../firebase/firestore_service.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(Map<String, dynamic> userData) async {
    await _firestore.collection('Users').add(userData);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await _firestore.collection('Users').get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> updateUser(String userId, Map<String, dynamic> userData) async {
    await _firestore.collection('Users').doc(userId).update(userData);
  }

  Future<void> deleteUser(String userId) async {
    await _firestore.collection('Users').doc(userId).delete();
  }

  Future<void> addProducts(Map<String, dynamic> productData) async {
    await _firestore.collection('Products').add(productData);
  }
}
