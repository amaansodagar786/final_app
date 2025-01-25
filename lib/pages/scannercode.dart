// barcode_scanner_screen.dart
import 'package:final_app/pages/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(
    home: BarcodeScannerScreen(),
  ));
}

class BarcodeScannerScreen extends StatefulWidget {
  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  String _scannedBarcode = '';
  List<Map<String, dynamic>> cartItems = [];

  Future<void> _scanBarcode(BuildContext context) async {
    String barcode = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancel",
      true,
      ScanMode.BARCODE,
    );

    if (barcode != '-1') {
      if (barcode == '6001068587209') {
        _showProductDetails(context, 'Too Yumm', 'Masala Masti', 20.0);
      }
       else if (barcode == '9556001130136') {
        _showProductDetails(context, 'Playz Puffcorn', 'Yummy Cheese, Namkeen', 20.0);
      }
      else if (barcode == '8521459874523') {
        _showProductDetails(context, 'Namkeen chilli Chatka', 'KurKure', 40.0);
      }
      else if (barcode == '8521456978') {
        _showProductDetails(context, 'Gowardhan Pure Cow Ghee 1 L (Jar)', 'Gowardhan', 200.0);
      }
      else if (barcode == '4123659874') {
        _showProductDetails(context, 'Dal Makhani[READY TO EAT]', 'MTR Foods', 60.0);
      }
      else if (barcode == '2563236589') {
        _showProductDetails(context, 'Tomato Twist[Waffers]', 'Balaji', 20.0);
      }
      else if (barcode == '3656987456') {
        _showProductDetails(context, 'Salted Waffers', 'Balaji', 20.0);
      }
      else if (barcode == '7859865985') {
        _showProductDetails(context, 'Panner[500 Grams]', 'Amul The Taste of India', 250.0);
      }
      else if (barcode == '9636568987') {
        _showProductDetails(context, 'Processed Chesse[1Kg]', 'Amul The Taste of India', 550.0);
      }
      else if (barcode == '3269856325') {
        _showProductDetails(context, 'Panner Masala[READY TO EAT]', 'MTR Foods', 90.0);
      }
      else if (barcode == '8569856982') {
        _showProductDetails(context, 'Lassi[250 Grams]', 'Amul', 40.0);
      }
      else if (barcode == '5236986563') {
        _showProductDetails(context, 'Nachos', 'Too Yumm!', 25.0);
      }
      else if (barcode == '9638784523') {
        _showProductDetails(context, 'Cheese Balls', 'Too Yumm!', 25.0);
      }
      else if (barcode == '5632698745') {
        _showProductDetails(context, 'AmericanNuts Ice cream', 'Amul', 170.0);
      }
      else if (barcode == '3236569874') {
        _showProductDetails(context, 'Dark Chocolate', 'Amul', 40.0);
      }
      else if (barcode == '4563217896') {
        _showProductDetails(context, 'Idli[READY TO EAT 500 GRAMS]', 'MTR Foods', 50.0);
      }
      else if (barcode == '5698652315') {
        _showProductDetails(context, 'Butter Milk[100 Grams]', 'Vadilal', 20.0);
      }
      else if (barcode == '4569875622') {
        _showProductDetails(context, 'Diced Cheese[1Kg]', 'GOcheese', 650.0);
      }
      else if (barcode == '1324578956') {
        _showProductDetails(context, 'Solid Masti', 'KurKure', 20.0);
      }
      else if (barcode == '8904091129461') {
        _showProductDetails(context, 'Candid', 'Dustin Powder', 60.0);
      }
       else {
        _showError(context, 'No item found for scanned barcode.');
      }
    }
  }

  void _showProductDetails(
    BuildContext context,
    String productName,
    String productDescription,
    double productPrice,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(productName),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(productDescription),
              SizedBox(height: 10),
              Text('Price: \Rs.${productPrice.toStringAsFixed(2)}'),
              ElevatedButton(
                onPressed: () {
                  cartItems.add({
                    'name': productName,
                    'description': productDescription,
                    'price': productPrice.toString(),
                  });
                  Navigator.of(context).pop();
                  _navigateToCartScreen();
                },
                child: Text('Add to Cart'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showError(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToCartScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CartScreen(cartItems: cartItems, productDescription: '', productName: '', productPrice: '',),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScanShop - Barcode Scanner'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Welcome to ScanShop',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Scan the barcode to Buy products',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Image.asset(
                'assets/images/barcode_scanner.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _scanBarcode(context),
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  elevation: 5,
                  shadowColor: Colors.grey.withOpacity(0.5),
                ),
                child: Text(
                  'Scan Barcode',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 40),
              if (_scannedBarcode.isNotEmpty)
                Text(
                  'Scanned Barcode: $_scannedBarcode',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.9),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Benefits',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '1. No need to pay your bills on the Billing Counter',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '2. No need to stand in a queue with others',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '3. Scan any product and make a payment for all products',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '4. Once scanned, product details will be shown',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: BarcodeScannerScreen(),
//   ));
// }
