import 'package:flutter/material.dart';

import 'package:sun_lunka_app/pages/app_page.dart';
import 'package:sun_lunka_app/pages/customs/colors.dart';
import 'package:sun_lunka_app/pages/customs/dialogue.dart';

class HotelPayment extends StatefulWidget {
  final double grandTotal;

  const HotelPayment({super.key, required this.grandTotal});

  @override
  State<HotelPayment> createState() => _HotelPaymentState();
}

class _HotelPaymentState extends State<HotelPayment> {
  bool _isLoading = false;

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

  int _selectedPaymentMethod = 0; // Track selected payment method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35),
            bottomRight: Radius.circular(35),
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
                  _buildPaymentOption(
                    context,
                    1,
                    'Amazon Pay',
                    'assets/images/amazonpay.png',
                    imageWidth: 50,
                    imageHeight: 50,
                  ),
                  SizedBox(height: 16),
                  _buildPaymentOption(
                    context,
                    2,
                    'Google Pay',
                    'assets/images/gpay.png',
                    imageWidth: 40,
                    imageHeight: 40,
                  ),
                  SizedBox(height: 16),
                  _buildPaymentOption(
                    context,
                    3,
                    'Paytm',
                    'assets/images/paytm.png',
                    imageWidth: 45,
                    imageHeight: 45,
                  ),
                  SizedBox(height: 16),
                  _buildPaymentOption(
                    context,
                    4,
                    'PhonePe',
                    'assets/images/phonepay.png',
                    imageWidth: 55,
                    imageHeight: 55,
                  ),
                  Spacer(),
                  _buildPayButton(), // Build the pay button
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black
                    .withOpacity(0.5), // Semi-transparent background
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
  Widget _buildPaymentOption(
    BuildContext context,
    int value,
    String text,
    String imagePath, {
    required double imageWidth,
    required double imageHeight,
  }) {
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
                _selectedPaymentMethod =
                    newValue!; // Update selected payment method
              });
            },
          ),
          SizedBox(width: 20),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color:
                  _selectedPaymentMethod == value ? Colors.black : Colors.grey,
              fontWeight: _selectedPaymentMethod == value
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
          Spacer(),
          Image.asset(
            imagePath,
            width: imageWidth,
            height: imageHeight,
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
}
