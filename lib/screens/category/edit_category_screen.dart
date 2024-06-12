// import 'package:flutter/material.dart';
// import '../../models/catelogies_model.dart';
// import '../../services/category_service.dart';
//
// class EditCategoryScreen extends StatefulWidget {
//   final String catelogyId;
//
//   EditCategoryScreen({Key? key, required this.catelogyId}) : super(key: key);
//
//   @override
//   _EditCategoryScreenState createState() => _EditCategoryScreenState();
// }
//
// class _EditCategoryScreenState extends State<EditCategoryScreen> {
//   final CategoryService _categoryService = CategoryService();
//   final TextEditingController _categoryNameController = TextEditingController();
//   late Catelogies _category;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadCategory();
//   }
//
//   Future<void> _loadCategory() async {
//     Catelogies? category = await _categoryService.getCategoryById(widget.catelogyId);
//
//     if (category != null) {
//       setState(() {
//         _category = category;
//         _categoryNameController.text = _category.name;
//       });
//     } else {
//       // Handle the case when the category is null, such as showing an error message or returning to the previous screen.
//       // You may want to navigate back or show an error message here.
//       _showSnackBar('Không tìm thấy danh mục. Đã quay lại danh sách danh mục.');
//       Navigator.pop(context);
//     }
//   }
//
//   Future<void> _updateCategory() async {
//     if (_category == null) {
//       // Handle the case when the category is null, such as showing an error message or returning to the previous screen.
//       // You may want to navigate back or show an error message here.
//       _showSnackBar('Không tìm thấy danh mục. Đã quay lại danh sách danh mục.');
//       Navigator.pop(context);
//       return;
//     }
//
//     String categoryName = _categoryNameController.text.trim();
//
//     if (categoryName.isNotEmpty) {
//       if (categoryName == _category.name) {
//         // Do nothing if the category name is not changed
//         _showSnackBar('Tên danh mục không thay đổi.');
//       } else {
//         bool categoryExists = await _categoryService.doesCategoryExist(categoryName);
//
//         if (categoryExists) {
//           // Show a message if the category name is a duplicate
//           _showSnackBar('Tên danh mục đã tồn tại. Vui lòng chọn tên khác.');
//         } else {
//           // Perform the category update if not a duplicate
//           bool success = await _categoryService.updateCategory(widget.catelogyId, categoryName);
//
//           if (success) {
//             // Show a success message using Snackbar
//             _showSnackBar('Cập nhật thành công.');
//
//             // Optionally, you can navigate back to the previous screen after a successful update
//             Navigator.pop(context);
//           } else {
//             // Show an error message using Snackbar
//             _showSnackBar('Cập nhật thất bại. Vui lòng thử lại.');
//           }
//         }
//       }
//     } else {
//       // Show a message if the category name is empty
//       _showSnackBar('Vui lòng điền giá trị.');
//     }
//   }
//
//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chỉnh sửa danh mục'),
//         backgroundColor: Colors.orange,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Category ID: ${widget.catelogyId}'), // Log the category ID
//             SizedBox(height: 20),
//             TextField(
//               controller: _categoryNameController,
//               decoration: InputDecoration(
//                 labelText: 'Tên danh mục',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _updateCategory,
//               child: Text('Cập nhật'),
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.orange, // Button color
//                 onPrimary: Colors.white, // Text color
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
