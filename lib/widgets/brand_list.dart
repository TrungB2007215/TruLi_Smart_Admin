import 'package:flutter/material.dart';

class BrandList extends StatelessWidget {
  final List<String> brands;

  const BrandList({Key? key, required this.brands}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: brands.length,
      itemBuilder: (context, index) {
        String brandName = brands[index];
        return ListTile(
          title: Text(brandName),
          // Các thông tin khác của thương hiệu có thể hiển thị ở đây
        );
      },
    );
  }
}
