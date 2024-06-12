import 'package:flutter/material.dart';
import '../../utils/routes.dart';

class BrandManagerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý thương hiệu'),
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to View All Brands Screen
              Navigator.pushNamed(context, Routes.viewAllBrands);
            },
            icon: Icon(Icons.view_list, size: 30),
            label: Text(
              'Xem tất cả thương hiệu',
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
              // Navigate to Add Brand Screen
              Navigator.pushNamed(context, Routes.addBrand);
            },
            icon: Icon(Icons.add, size: 30),
            label: Text(
              'Thêm thương hiệu mới',
              style: TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // Màu nền của nút
              onPrimary: Colors.white, // Màu chữ của nút
              padding: EdgeInsets.all(20), // Đặt kích thước padding tùy chỉnh
            ),
          ),
          // SizedBox(height: 20),
          // ElevatedButton.icon(
          //   onPressed: () {
          //     // Navigate to Edit Brand Screen
          //     Navigator.pushNamed(context, Routes.editBrand);
          //   },
          //   icon: Icon(Icons.edit, size: 30),
          //   label: Text(
          //     'Chỉnh sửa thương hiệu',
          //     style: TextStyle(fontSize: 18),
          //   ),
          //   style: ElevatedButton.styleFrom(
          //     primary: Colors.orange, // Màu nền của nút
          //     onPrimary: Colors.white, // Màu chữ của nút
          //     padding: EdgeInsets.all(20), // Đặt kích thước padding tùy chỉnh
          //   ),
          // ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to Remove Brand Screen
              Navigator.pushNamed(context, Routes.removeBrand);
            },
            icon: Icon(Icons.delete, size: 30),
            label: Text(
              'Xóa thương hiệu',
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
