import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  CartScreen({required this.cartItems, required String productDescription, required String productName, required String productPrice});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final String stripeCheckoutSessionLink = 'https://buy.stripe.com/test_8wM9DB9JId80cog8ww';

  double getTotalPayment() {
    double totalPayment = 0.0;
    for (var item in widget.cartItems) {
      double? itemPrice = double.tryParse(item['price']);
      if (itemPrice != null) {
        totalPayment += itemPrice;
      }
    }
    return totalPayment;
  }

  void _showPaymentConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Payment Confirmation"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total Items: ${widget.cartItems.length}"),
              Text("Total Price: Rs.${getTotalPayment().toStringAsFixed(2)}"),

            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Add your payment logic here.
                // Open the Stripe Checkout Session link.
                openStripeCheckout();

                // Call the _storeCartItems function to store cart items in the database.
                _storeCartItems();

                // Clear the cart items list.
                widget.cartItems.clear();

                Navigator.of(context).pop(); // Pop the payment confirmation dialog.
                Navigator.of(context).pop(); // Pop the cart screen.
              },
              child: Text("Pay Now"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _storeCartItems() {
    final userUid = FirebaseAuth.instance.currentUser!.uid;
    final databaseReference = FirebaseDatabase.instance.reference();
    final newCartItemsReference = databaseReference.child('users').child(userUid).child('new_cart_items');

    // Add each cart item to the user's new_cart_items node.
    for (int i = 0; i < widget.cartItems.length; i++) {
      newCartItemsReference.child('item_$i').set({
        'name': widget.cartItems[i]['name'],
        'description': widget.cartItems[i]['description'],
        'price': widget.cartItems[i]['price'],
      }).then((_) {
        // Successfully added item to the user's new_cart_items.
        Fluttertoast.showToast(
          msg: "Redirecting For Payment Process",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }).catchError((error) {
        Fluttertoast.showToast(
          msg: "Failed to add product to new_cart_items: $error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      });
    }
  }

  void openStripeCheckout() async {
    if (await canLaunch(stripeCheckoutSessionLink)) {
      await launch(stripeCheckoutSessionLink);
    } else {
      throw 'Could not launch $stripeCheckoutSessionLink';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cartItems[index]['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.cartItems[index]['description'],
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price: \Rs.${widget.cartItems[index]['price']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Total: \Rs.${getTotalPayment().toStringAsFixed(2)}"),
              ElevatedButton(
                onPressed: () {
                  // Show the payment confirmation dialog
                  _showPaymentConfirmation(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                ),
                child: Text("Make Payment"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
