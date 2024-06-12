import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(String userName, String email, String password, String avatar, String role) async {
    try {
      // Thêm thông tin người dùng vào Firestore
      await _firestore.collection('Users').add({
        'userName': userName,
        'email': email,
        'avatar': avatar,
        'role': role,
        'password': password, // Thêm trường password
      });
    } catch (e) {
      print('Error adding user: $e');
      // Xử lý lỗi thêm người dùng
    }
  }

  Future<bool> authenticateUser(String email, String password, String role) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('Users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .where('role', isEqualTo: role)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error authenticating user: $e');
      return false;
    }
  }

  Future<bool> checkEmailExists(String email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('Users')
          .where('email', isEqualTo: email)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking email existence: $e');
      return false;
    }
  }

  Future<bool> checkUsernameExists(String userName) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('Users')
          .where('userName', isEqualTo: userName)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking username existence: $e');
      return false;
    }
  }

  Future<bool> updateUserRole(String email, String newRole) async {
    try {
      // Lấy reference của collection 'Users' và query người dùng dựa trên email
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Lấy document của người dùng đầu tiên (giả sử chỉ có 1 người dùng duy nhất có cùng email)
        DocumentSnapshot<Map<String, dynamic>> userSnapshot = snapshot.docs.first;

        DocumentReference userRef = userSnapshot.reference;

        await userRef.update({'role': newRole});

        return true; // Cập nhật thành công
      } else {
        print('Tài khoản không tồn tại');
        return false; // Tài khoản không tồn tại, cập nhật thất bại
      }
    } catch (e) {
      print('Lỗi khi cập nhật vai trò người dùng: $e');
      return false; // Cập nhật thất bại
    }
  }
}
