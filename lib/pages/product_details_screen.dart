// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'cart.dart';

// class ProductDetailsScreen extends StatefulWidget {
//   final String barcode;

//   ProductDetailsScreen({required this.barcode});

//   @override
//   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// }

// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//   final auth = FirebaseAuth.instance;
//   final _databaseReference = FirebaseDatabase.instance.ref().child('products');

//   @override
//   void initState() {
//     super.initState();
//     _listenToProducts();
//   }

//   void _listenToProducts() {
//     _databaseReference.onChildChanged.listen((event) {
//       setState(() {
//         // Perform any update logic if needed
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ScanShop - Product Details'),
//         backgroundColor: Colors.teal,
//         centerTitle: true,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: FirebaseAnimatedList(
//               query: _databaseReference,
//               itemBuilder: (context, snapshot, animation, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Card(
//                     elevation: 4, // Add a shadow to the card
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             snapshot.child('name').value.toString(),
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             snapshot.child('description').value.toString(),
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           SizedBox(height: 8),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Price: \Rs.${snapshot.child('price').value.toString()}',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.green,
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   Fluttertoast.showToast(
//                                     msg: "Product added",
//                                     toastLength: Toast.LENGTH_SHORT,
//                                     gravity: ToastGravity.BOTTOM,
//                                   );
//                                   // You can add your logic to handle the addition to the cart here.
//                                   // Navigate to the CartScreen
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => CartScreen(
//                                         productName: snapshot.child('name').value.toString(),
//                                         productDescription: snapshot.child('description').value.toString(),
//                                         productPrice: snapshot.child('price').value.toString(), 
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 child: Icon(Icons.add_circle_outline, color: Colors.green, size: 30),
//                               ),
//                               SizedBox(width: 30),
//                               GestureDetector(
//                                 onTap: () {
//                                   Fluttertoast.showToast(
//                                     msg: "Product deleted successfully",
//                                     toastLength: Toast.LENGTH_SHORT,
//                                     gravity: ToastGravity.BOTTOM,
//                                   );
//                                   // You can add your logic to handle the deletion of the product here.
//                                   int productId = int.parse(snapshot.key!);
//                                   _databaseReference.child('$productId').remove();
//                                 },
//                                 child: Icon(Icons.delete_forever_sharp, color: Colors.green, size: 30),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           // Display the product image using an appropriate widget.
//           // (You might need to use CachedNetworkImage or Image.network).
//           // For example: Image.network(productDetails['imageURL']),
//         ],
//       ),
//     );
//   }
// }
