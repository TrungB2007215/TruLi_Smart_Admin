import 'package:flutter/material.dart';
import '../../services/brand_service.dart';
import '../../widgets/brand_list.dart';
import '../../widgets/search_bar.dart' as CustomSearchBar;

class RemoveBrandScreen extends StatefulWidget {
  @override
  _RemoveBrandScreenState createState() => _RemoveBrandScreenState();
}

class _RemoveBrandScreenState extends State<RemoveBrandScreen> {
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
    List<String> brands = await _brandService.getAllBrands();

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

  Future<void> _confirmDeleteBrand(String brandName) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Xác nhận xóa'),
        content: Text('Bạn có chắc chắn muốn xóa thương hiệu "$brandName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Không'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Có'),
          ),
        ],
      ),
    );

    if (confirmDelete == true) {
      bool success = await _brandService.removeBrand(brandName);

      if (success) {
        await _loadBrands();
        setState(() {
          _brands.remove(brandName);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đã xóa thành công thương hiệu $brandName')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Xóa thương hiệu $brandName thất bại')),
        );
      }
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
      return ListView.builder(
        itemCount: _brands.length,
        itemBuilder: (context, index) {
          final brandName = _brands[index];
          return ListTile(
            title: Text(brandName),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _confirmDeleteBrand(brandName),
            ),
          );
        },
      );
    }
  }
}
