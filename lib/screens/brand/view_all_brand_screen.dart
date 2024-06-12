import 'package:flutter/material.dart';
import '../../services/brand_service.dart';
import '../../widgets/brand_list.dart';
import '../../widgets/search_bar.dart' as CustomSearchBar;

class ViewAllBrandsScreen extends StatefulWidget {
  @override
  _ViewAllBrandsScreenState createState() => _ViewAllBrandsScreenState();
}

class _ViewAllBrandsScreenState extends State<ViewAllBrandsScreen> {
  final BrandService _brandService = BrandService();
  late List<String> _brands = [];
  late List<String> _allBrands;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBrands();
  }

  Future<void> _loadBrands() async {
    List<String> brands = await _brandService.getAllBrands(); // Sử dụng dịch vụ để lấy danh sách thương hiệu

    setState(() {
      _brands = brands;
      _allBrands = brands;
    });
  }

  void _filterBrands(String query) {
    if (query.isEmpty) {
      setState(() {
        _brands = _allBrands;
      });
    } else {
      List<String> filteredBrands = _allBrands
          .where((brand) => brand.toLowerCase().contains(query.toLowerCase()))
          .toList();

      setState(() {
        _brands = filteredBrands;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách thương hiệu'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          CustomSearchBar.CustomSearchBar(
            controller: _searchController,
            onTextChanged: _filterBrands,
          ),
          Expanded(
            child: _buildBrandsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandsList() {
    if (_brands.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else {
      return BrandList(brands: _brands);
    }
  }
}
