import 'package:admin/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'utils/routes.dart';
import 'services/user_service.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/register_screen.dart';
import 'screens/confirm_seller_screen.dart';
import 'screens/category/category_maneger_screen.dart';
import 'screens/category/add_catelogy_screen.dart';
import 'screens/category/category_list_screen.dart';
import 'screens/category/view_all_categories_screen.dart';
import 'screens/category/remove_categories_screen.dart';
import 'screens/brand/brand_manager_screen.dart';
import 'screens/brand/add_brand_screen.dart';
import 'screens/brand/view_all_brand_screen.dart';
import 'screens/brand/remove_brand_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // UserService userService = UserService();
  // await userService.addUser(
  //   'Minh Trung',
  //   'trung@gmail.com',
  //   '123',
  //   'avatar_url',
  //   'admin',
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop TruLi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              // User is logged in
              return HomeScreen();
            } else {
              // User is not logged in
              return LoginScreen();
            }
          }
        },
      ),
      routes: {
        Routes.home: (context) => HomeScreen(),
        Routes.login: (context) => LoginScreen(),
        Routes.register: (context) => RegisterScreen(),
        Routes.userManagement: (context) => ConfirmSellerScreen(),
        Routes.categoryManagement: (context) => CategoryManagerScreen(),
        Routes.brandManagement: (context) => BrandManagerScreen(),
        Routes.viewAllCategories: (context) => ViewAllCategoriesScreen(),
        Routes.addCategory: (context) => AddCategoryScreen(),
        Routes.removeCategory: (context) => RemoveCategoriesScreen(),
        Routes.addBrand: (context) => AddBrandScreen(),
        Routes.viewAllBrands: (context) => ViewAllBrandsScreen(),
        Routes.removeBrand: (context) => RemoveBrandScreen(),
      },
    );
  }
}
