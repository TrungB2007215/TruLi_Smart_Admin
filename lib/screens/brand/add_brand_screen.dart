import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/brand_service.dart';
import '../../services/category_service.dart';

class AddBrandScreen extends StatefulWidget {
  @override
  _AddBrandScreenState createState() => _AddBrandScreenState();
}

class _AddBrandScreenState extends State<AddBrandScreen> {
  final TextEditingController _brandNameController = TextEditingController();
  Uint8List? _imageData;
  BrandService _brandService = BrandService();
  CategoryService _categoryService = CategoryService();

  List<String> categories = [];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      List<String> categoryList = await _categoryService.getListCategories();

      setState(() {
        categories = categoryList;
      });
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  void _addBrand(BuildContext context) async {
    String brandName = _brandNameController.text.trim();

    if (_imageData != null && brandName.isNotEmpty && selectedCategory != null) {
      bool brandExists = await _brandService.doesBrandExist(brandName);

      if (brandExists) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Thương hiệu đã tồn tại. Vui lòng nhập một tên khác.'),
        ));
      } else {
        try {
          // Use the null-aware operator `!` to assert that `_imageData` is not null
          await _brandService.addBrand(brandName, _imageData!, selectedCategory!);
          Navigator.pop(context); // Close the add brand screen
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Lỗi khi thêm thương hiệu: $e'),
          ));
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Vui lòng điền đầy đủ thông tin.'),
      ));
    }
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
        File imageFile = File(pickedFile.path!);
        Uint8List imageData = await imageFile.readAsBytes();

        setState(() {
          _imageData = imageData;
        });
      } catch (e) {
        print("Error loading image: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm thương hiệu mới'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40),
            GestureDetector(
              onTap: () async {
                await _getImage();
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(),
                  shape: BoxShape.circle,
                ),
                child: _imageData != null
                    ? Image.memory(
                  _imageData!,
                  fit: BoxFit.fill,
                )
                    : Center(
                  child: Icon(Icons.camera_alt, size: 50),
                ),
              ),
            ),

            SizedBox(height: 20),
            TextField(
              controller: _brandNameController,
              decoration: InputDecoration(
                labelText: 'Tên thương hiệu',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text('Chọn danh mục tương ứng:'),
            SizedBox(height: 8),
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
              items: categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addBrand(context);
              },
              child: Text('Thêm thương hiệu'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
