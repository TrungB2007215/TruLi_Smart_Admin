import 'package:flutter/material.dart';
import '../../services/category_service.dart';
import '../../models/catelogies_model.dart';
import '../../widgets/category_list.dart';
import '../../widgets/search_bar.dart' as CustomSearchBar;

class RemoveCategoriesScreen extends StatefulWidget {
  @override
  _RemoveCategoriesScreenState createState() => _RemoveCategoriesScreenState();
}

class _RemoveCategoriesScreenState extends State<RemoveCategoriesScreen> {
  final CategoryService _categoryService = CategoryService();
  late List<Catelogies> _categories = [];
  late List<Catelogies> _allCategories;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    List<Catelogies> categories = (await _categoryService.getAllCategories())
        .map((categoryMap) => Catelogies.fromMap(categoryMap))
        .toList();

    setState(() {
      _categories = categories;
      _allCategories = categories;
    });
  }

  void _filterCategories(String query) {
    if (query.isEmpty) {
      setState(() {
        _categories = _allCategories;
      });
    } else {
      List<Catelogies> filteredCategories = _allCategories
          .where((category) =>
          category.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      setState(() {
        _categories = filteredCategories;
      });
    }
  }

  void _removeCategoryByName(String categoryName) async {
    String? categoryId = await _categoryService.findCategoryIdByName(categoryName);

    if (categoryId != null) {
      bool success = await _categoryService.removeCategory(categoryId);
      if (success) {
        // Xóa thành công, cập nhật lại danh sách danh mục
        _loadCategories();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đã xóa danh mục $categoryName')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Xóa danh mục $categoryName thất bại')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không tìm thấy danh mục $categoryName')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xóa danh mục'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          CustomSearchBar.CustomSearchBar(
            controller: _searchController,
            onTextChanged: _filterCategories,
          ),
          Expanded(
            child: _buildCategoriesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesList() {
    if (_categories == null) {
      return Center(child: CircularProgressIndicator());
    } else if (_categories.isEmpty) {
      return Center(child: Text('Không có danh mục nào.'));
    } else {
      return ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return ListTile(
            title: Text(category.name),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _showConfirmationDialog(category.name); // Hiển thị hộp thoại xác nhận trước khi xóa
              },
            ),
          );
        },
      );
    }
  }


  void _showConfirmationDialog(String categoryName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Xác nhận xóa danh mục'),
        content: Text('Bạn có chắc chắn muốn xóa danh mục $categoryName không?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog
              _removeCategoryByName(categoryName); // Gọi hàm xóa danh mục
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


}
