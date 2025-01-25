import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Screen Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SimpleScreen(),
    );
  }
}

class SimpleScreen extends StatefulWidget {
  @override
  State<SimpleScreen> createState() => _SimpleScreenState();
}

class _SimpleScreenState extends State<SimpleScreen> {
  List<CartItemModel> cartItems = [];
  late DatabaseReference _userCartReference; // Reference to the user's cart items

  @override
  void initState() {
    super.initState();

    // Get the current user's UID from Firebase Authentication
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      // Initialize the reference to the user's cart items
      _userCartReference =
          FirebaseDatabase.instance.ref().child('users/$userId/new_cart_items');

      // Listen to real-time changes in the user's cart items
      _userCartReference.onValue.listen((event) {
        _fetchCartItems(event.snapshot);
      });
    }
  }

  // Fetch cart items for the user
  void _fetchCartItems(DataSnapshot snapshot) {
    // Clear the existing list
    cartItems.clear();

    // Process each data item and add it to the list
    if (snapshot.value != null) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, item) {
        cartItems.add(CartItemModel(
          name: item['name'],
          description: item['description'],
          price: item['price'],
        ));
      });
    }

    // Update the state to trigger a re-build and display the fetched data
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Products"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItems[index].name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  cartItems[index].description,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Price: \Rs.${cartItems[index].price}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    
                  ],
                ),
              ],
            ),
          );
        },
      ),
     
    );
  }

}

class CartItemModel {
  final String name;
  final String description;
  final String price;

  CartItemModel({
    required this.name,
    required this.description,
    required this.price,
  });
}


