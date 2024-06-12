import 'package:flutter/material.dart';
import '../../services/category_service.dart';
import '../../models/catelogies_model.dart';
import '../../widgets/category_list.dart';
import '../../widgets/search_bar.dart' as CustomSearchBar;

class ViewAllCategoriesScreen extends StatefulWidget {
  @override
  _ViewAllCategoriesScreenState createState() => _ViewAllCategoriesScreenState();
}

class _ViewAllCategoriesScreenState extends State<ViewAllCategoriesScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách danh mục'),
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
      return CategoryList(categories: _categories);
    }
  }
}
