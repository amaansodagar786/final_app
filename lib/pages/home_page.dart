
// import 'package:final_app/pages/cart.dart';
// import 'package:final_app/pages/cart.dart';
// import 'package:final_app/pages/cart.dart';
import 'package:final_app/pages/cart.dart';
// import 'package:final_app/pages/categories.dart';
// import 'package:final_app/pages/product_details_screen.dart';
// import 'package:final_app/pages/product_details_screen.dart';
import 'package:final_app/pages/scannercode.dart';
import 'package:final_app/pages/user_account_details.dart';

import 'package:final_app/pages/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

// import 'ProductDetailsScreen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex=0;

   final  List _pages = [
       BarcodeScannerScreen(),
       CartScreen(productDescription: '', productName: '', productPrice: '', cartItems: [],),
       SimpleScreen(),
      const UserScreen()
    ];

    void _selectedPage(int index){
      setState(() {
        _selectedIndex = index;
      });
    }
  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }



  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed ,
        currentIndex: _selectedIndex,
        onTap: _selectedPage,
        items:const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon:Icon(IconlyLight.scan),
          label: "Scan",
          ),
          BottomNavigationBarItem(
            icon:Icon(IconlyLight.buy),
            label: "Cart"
           ),
            BottomNavigationBarItem(
            icon:Icon(IconlyLight.shieldDone),
          label: "Show",
          ),
          BottomNavigationBarItem(
            icon:Icon(IconlyLight.user3),
          label: "User",
          ),
        ]
        ),
      
    );
  }
}
