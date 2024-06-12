import 'package:flutter/material.dart';
import '../../utils/routes.dart';

class CategoryManagerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý danh mục'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, Routes.viewAllCategories);
            },
            icon: Icon(Icons.view_list, size: 30),
            label: Text(
              'Xem tất cả danh mục',
              style: TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue, // Màu nền của nút
              onPrimary: Colors.white, // Màu chữ của nút
              padding: EdgeInsets.all(20), // Đặt kích thước padding tùy chỉnh
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to Add Category Screen
              Navigator.pushNamed(context, Routes.addCategory);
            },
            icon: Icon(Icons.add, size: 30),
            label: Text(
              'Thêm danh mục mới',
              style: TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // Màu nền của nút
              onPrimary: Colors.white, // Màu chữ của nút
              padding: EdgeInsets.all(20),
            ),
          ),
          SizedBox(height: 20),
          // ElevatedButton.icon(
          //   onPressed: () {
          //     // Navigate to Edit Category Screen
          //     Navigator.pushNamed(context, Routes.editCategory);
          //   },
          //   icon: Icon(Icons.edit, size: 30),
          //   label: Text(
          //     'Chỉnh sửa danh mục',
          //     style: TextStyle(fontSize: 18),
          //   ),
          //   style: ElevatedButton.styleFrom(
          //     primary: Colors.orange, // Màu nền của nút
          //     onPrimary: Colors.white, // Màu chữ của nút
          //     padding: EdgeInsets.all(20), // Đặt kích thước padding tùy chỉnh
          //   ),
          // ),
          // SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to Remove Category Screen
              Navigator.pushNamed(context, Routes.removeCategory);
            },
            icon: Icon(Icons.delete, size: 30),
            label: Text(
              'Xóa danh mục',
              style: TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.red, // Màu nền của nút
              onPrimary: Colors.white, // Màu chữ của nút
              padding: EdgeInsets.all(20), // Đặt kích thước padding tùy chỉnh
            ),
          ),
        ],
      ),
    );
  }
}