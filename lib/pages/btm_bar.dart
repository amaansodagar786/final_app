// import 'package:final_app/pages/home_page.dart';
// import 'package:final_app/pages/users.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// // import 'package:flutter/src/widgets/framework.dart';
// // import 'package:flutter/src/widgets/placeholder.dart';

// import 'auth_page.dart';
// import 'cart.dart';
// import 'categories.dart';

// class BottomBarScreen extends StatefulWidget {
//   const BottomBarScreen({super.key});

//   @override
//   State<BottomBarScreen> createState() => _BottState();
// }

// class _BottState extends State<BottomBarScreen> {
// int _selectedIndex = 0;

// final List _pages = [
//   const AuthPage(),
//    HomePage(),
//   const CategoriesScreen(),
//   const CartScreen(),
//   const UserScreen(),
// ];

// void _selectedPage(int index){
//   setState(() {
//     _selectedIndex = index;
//   });

// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:_pages[_selectedIndex],
//       bottomNavigationBar:BottomNavigationBar(
//         currentIndex:_selectedIndex,
//         onTap: _selectedPage,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(icon: Icon(IconlyLight.home),
//           label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(IconlyLight.category),
//           label: 'categories'),
//         ]

//       ),
//     );
//   }
// }