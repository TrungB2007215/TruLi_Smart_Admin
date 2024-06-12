import 'package:flutter/material.dart';
import '../../utils/routes.dart';
import '../../services/category_service.dart';

class AddCategoryScreen extends StatelessWidget {
  final TextEditingController _categoryNameController = TextEditingController();
  final CategoryService _categoryService = CategoryService();

  void _addCategory(BuildContext context) async {
    String categoryName = _categoryNameController.text.trim();

    if (categoryName.isNotEmpty) {
      // Kiểm tra xem danh mục đã tồn tại chưa
      bool categoryExists = await _categoryService.doesCategoryExist(categoryName);

      if (categoryExists) {
        // Hiển thị thông báo nếu danh mục đã tồn tại
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Danh mục đã tồn tại. Vui lòng nhập một tên khác.'),
        ));
      } else {
        // Thực hiện logic thêm danh mục vào cơ sở dữ liệu
        bool success = await _categoryService.addCategory(categoryName);

        if (success) {
          // Sau khi thêm thành công, bạn có thể chuyển về màn hình quản lý danh mục hoặc thực hiện các hành động khác
          Navigator.pop(context); // Đóng màn hình thêm danh mục
        } else {
          // Xử lý trường hợp thêm không thành công (hiển thị thông báo lỗi, v.v.)
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Thêm danh mục không thành công. Vui lòng thử lại.'),
          ));
        }
      }
    } else {
      // Xử lý trường hợp tên danh mục trống
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Vui lòng nhập tên danh mục.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm danh mục mới'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _categoryNameController,
              decoration: InputDecoration(
                labelText: 'Tên danh mục',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addCategory(context);
              },
              child: Text('Thêm danh mục'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Màu nền của nút
                onPrimary: Colors.white, // Màu chữ của nút
              ),
            ),
          ],
        ),
      ),
    );
  }
}
