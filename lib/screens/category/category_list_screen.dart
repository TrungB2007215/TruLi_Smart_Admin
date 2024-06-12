// import 'package:flutter/material.dart';
// import '../../models/catelogies_model.dart';
// import '../../services/category_service.dart';
// import 'edit_category_screen.dart';
//
// class CategoryListScreen extends StatefulWidget {
//   @override
//   _CategoryListScreenState createState() => _CategoryListScreenState();
// }
//
// class _CategoryListScreenState extends State<CategoryListScreen> {
//   final CategoryService _categoryService = CategoryService();
//   List<Catelogies>? _categories;
//   List<Catelogies>? _allCategories;
//   TextEditingController _searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadCategories();
//   }
//
//   Future<void> _loadCategories() async {
//     List<Catelogies> categories = (await _categoryService.getAllCategories())
//         .map((categoryMap) => Catelogies.fromMap(categoryMap))
//         .toList();
//
//     setState(() {
//       _categories = categories;
//       _allCategories = categories;
//     });
//   }
//
//   void _filterCategories(String query) {
//     if (_allCategories == null) return;
//
//     if (query.isEmpty) {
//       setState(() {
//         _categories = _allCategories;
//       });
//     } else {
//       List<Catelogies> filteredCategories = _allCategories!
//           .where((category) =>
//           category.name.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//
//       setState(() {
//         _categories = filteredCategories;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Danh sách danh mục'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _searchController,
//               onChanged: _filterCategories,
//               decoration: InputDecoration(
//                 labelText: 'Tìm kiếm',
//                 prefixIcon: Icon(Icons.search),
//               ),
//             ),
//           ),
//           Expanded(
//             child: _buildCategoriesList(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCategoriesList() {
//     if (_categories == null) {
//       return Center(child: CircularProgressIndicator());
//     } else if (_categories!.isEmpty) {
//       return Center(child: Text('Không có danh mục nào.'));
//     } else {
//       return ListView.builder(
//         itemCount: _categories!.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: ListTile(
//               title: Text(_categories![index].name),
//               trailing: IconButton(
//                 icon: Icon(Icons.edit),
//                 onPressed: _categories![index].id != null
//                     ? () async {
//                   String categoryId = _categories![index].id!;
//                   await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => EditCategoryScreen(
//                         categoryId: categoryId,
//                       ),
//                     ),
//                   ).then((_) {
//                     // Refresh danh sách sau khi chỉnh sửa
//                     _loadCategories();
//                   });
//                 }
//                     : null,
//               ),
//             ),
//           );
//         },
//       );
//     }
//   }
//
// }
