import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/user_service.dart';
class ConfirmSellerScreen extends StatefulWidget {
  @override
  _ConfirmSellerScreenState createState() => _ConfirmSellerScreenState();
}

class _ConfirmSellerScreenState extends State<ConfirmSellerScreen> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _usersStream;

  @override
  void initState() {
    super.initState();
    _usersStream = FirebaseFirestore.instance
        .collection('Users')
        .where('role', isEqualTo: 'confirming_seller')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xác nhận thành người bán hàng'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _usersStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final userData = users[index].data() as Map<String, dynamic>;
              final email = userData['email'];
              final name = userData['userName'];

              return ListTile(
                title: Text(name),
                subtitle: Text(email),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.check, color: Colors.green),
                      onPressed: () {
                        _confirmSellerDialog(context, name, email);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        _rejectSellerDialog(context, name, email);
                      },
                    ),
                  ],
                ),
              );
            },
          );

        },
      ),
    );
  }
  void _confirmSellerDialog(BuildContext context, String name, String email) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Xác nhận người bán hàng'),
        content: Text('Bạn có chắc chắn muốn xác nhận người bán hàng $name?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog
              _confirmSeller(email);
            },
            child: Text('Xác nhận'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog
            },
            child: Text('Hủy'),
          ),
        ],
      ),
    );
  }

  void _rejectSellerDialog(BuildContext context, String name, String email) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Từ chối người bán hàng'),
        content: Text('Bạn có chắc chắn muốn từ chối người bán hàng $name?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog
              _rejectSeller(email);
            },
            child: Text('Từ chối'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog
            },
            child: Text('Hủy'),
          ),
        ],
      ),
    );
  }

  void _confirmSeller(String email) async {
    String newRole = 'seller';

    bool success = await UserService().updateUserRole(email, newRole);
    if (success) {
      print('Cập nhật vai trò thành công');
    } else {
      print('Cập nhật vai trò thất bại');
    }
  }



  void _rejectSeller(String email) async {
    String newRole = 'user';

    bool success = await UserService().updateUserRole(email, newRole);
    if (success) {
      print('Cập nhật vai trò thành công');
    } else {
      print('Cập nhật vai trò thất bại');
    }
  }

}
