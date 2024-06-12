import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../models/user_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        // Check user credentials in Firestore
        // Assume you have a method in FirestoreService to authenticate users
        bool isAuthenticated = await UserService().authenticateUser(email, password, 'admin');

        if (isAuthenticated) {
          // Login successful
          // Navigate to the home screen or admin management screen
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          // Login failed, display error message
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Sai email hoặc mật khẩu.'),
          ));
        }
      } else {
        // Login failed, display error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Vui lòng điền đầy đủ thôn tin.'),
        ));
      }
    } catch (e) {
      // Handle login failure
      print('Login failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Đăng nhập không thành công vui lòng kiểm tra lại email và password.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng nhập'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30.0),
            Container(
              child: Image.asset(
                'assets/images/logo.png',
                width: 150,
                height: 150,
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  child: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                ),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              obscureText: !_isPasswordVisible,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Center(
                  child: Text(
                    'Đăng nhập',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
