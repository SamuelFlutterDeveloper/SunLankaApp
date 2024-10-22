import 'package:flutter/material.dart';


import 'package:sun_lunka_app/pages/app_page.dart';
import 'package:sun_lunka_app/pages/customs/colors.dart';
import 'package:sun_lunka_app/pages/customs/dialogue.dart'; // Assuming you have a dialog helper

class PackagePayment extends StatefulWidget {
  final double grandTotal; // Add a field to hold the total amount

  const PackagePayment({super.key, required this.grandTotal}); // Constructor to pass the total amount

  @override
  State<PackagePayment> createState() => _PackagePaymentState();
}

class _PackagePaymentState extends State<PackagePayment> {
  bool _isLoading = false; // Track loading state
  int _selectedPaymentMethod = 0; // Track selected payment method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          child: AppBar(
            backgroundColor: Mycolor.ButtonColor,
            centerTitle: true,
            title: Text(
              'Payment',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: const Color.fromARGB(255, 0, 0, 0)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  _buildPaymentOption(1, 'Amazon Pay', 'assets/images/amazonpay.png'),
                  SizedBox(height: 16),
                  _buildPaymentOption(2, 'Google Pay', 'assets/images/gpay.png'),
                  SizedBox(height: 16),
                  _buildPaymentOption(3, 'Paytm', 'assets/images/paytm.png'),
                  SizedBox(height: 16),
                  _buildPaymentOption(4, 'PhonePe', 'assets/images/phonepay.png'),
                  Spacer(),
                  _buildPayButton(), // Build the pay button
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5), // Semi-transparent background
                child: Center(
                  child: CircularProgressIndicator(), // Show loading spinner
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Widget to build each payment option
  Widget _buildPaymentOption(int value, String text, String imagePath) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Radio<int>(
            value: value,
            groupValue: _selectedPaymentMethod,
            activeColor: Mycolor.ButtonColor,
            onChanged: (int? newValue) {
              setState(() {
                _selectedPaymentMethod = newValue!; // Update selected payment method
              });
            },
          ),
          SizedBox(width: 20),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: _selectedPaymentMethod == value ? Colors.black : Colors.grey,
              fontWeight: _selectedPaymentMethod == value ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Spacer(),
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
          ),
        ],
      ),
    );
  }

  // Widget to build the payment button
  Widget _buildPayButton() {
    bool isSelected = _selectedPaymentMethod != 0;

    return GestureDetector(
      onTap: () {
        if (isSelected) {
          _handlePayment(); // Trigger payment logic with loading spinner
        } else {
          // Show a message that no payment method is selected
          DialogHelper.showInfoDialog(
            context,
            title: "No Payment Method Selected",
            message: "Please select a payment method before proceeding.",
          );
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSelected ? Mycolor.ButtonColor : Colors.grey,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          'Pay ₹${widget.grandTotal.toStringAsFixed(2)}', // Display the total amount
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  // Simulate the payment process and show success dialog
  void _handlePayment() async {
    setState(() {
      _isLoading = true; // Show loading spinner
    });

    // Simulate a 2-second delay
    await Future.delayed(Duration(seconds: 2));

    // Hide the loading spinner
    setState(() {
      _isLoading = false;
    });

    // Show the payment success dialog
   DialogHelper.showSuccessDialog(
      context,
      title: "Payment Successful",
      message: "Your order has been booked successfully!",
      totalAmount: widget.grandTotal, // Pass the total amount
      onDone: () {
        Navigator.of(context).pop(); // Close the dialog
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AppPage()), // Go to Home page
          (route) => false,
        );
      },
    );
  }
}
