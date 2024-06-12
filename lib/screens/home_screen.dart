import 'package:flutter/material.dart';
import '../utils/routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang chủ'),
        backgroundColor: Colors.blue,
      ),
      body: _getBody(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tôi',
          ),
        ],
        selectedItemColor: Colors.blue,
      ),
    );
  }

  Widget _getBody(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return _buildHomeScreen();
      case 1:
        return _buildProfileScreen();
      default:
        return Container();
    }
  }

  Widget _buildHomeScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to User Management Screen
              Navigator.pushNamed(context, Routes.userManagement);
            },
            icon: Icon(Icons.person, size: 40),
            label: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Text(
                'Quản lý người dùng',
                style: TextStyle(fontSize: 20),
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue, // Button color
              onPrimary: Colors.white,
              padding: EdgeInsets.all(18), // Text color
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to Category Management Screen
              Navigator.pushNamed(context, Routes.categoryManagement);
            },
            icon: Icon(Icons.category, size: 40),
            label: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Text(
                'Quản lý danh mục',
                style: TextStyle(fontSize: 20),
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // Button color
              onPrimary: Colors.white,
              padding: EdgeInsets.all(18), // Text color
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to Brand Management Screen
              Navigator.pushNamed(context, Routes.brandManagement);
            },
            icon: Icon(Icons.label, size: 40),
            label: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Text(
                'Quản lý nhãn hàng',
                style: TextStyle(fontSize: 20),
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.orange, // Button color
              onPrimary: Colors.white,
              padding: EdgeInsets.all(18), // Text color
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // Xử lý sự kiện khi nhấn nút Đăng xuất
              Navigator.pushNamed(context, Routes.login);
            },
            icon: Icon(Icons.logout, size: 40),
            label: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Text(
                'Đăng xuất',
                style: TextStyle(fontSize: 20),
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.red, // Button color
              onPrimary: Colors.white, // Text color
            ),
          ),
        ],
      ),
    );
  }
}
