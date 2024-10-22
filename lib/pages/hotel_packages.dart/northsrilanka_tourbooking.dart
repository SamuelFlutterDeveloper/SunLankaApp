import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sun_lunka_app/pages/customs/colors.dart';
import 'package:sun_lunka_app/pages/hotel_packages.dart/tour_packagepayment.dart';

class NorthsrilankaTourbooking extends StatefulWidget {
  const NorthsrilankaTourbooking({super.key});

  @override
  State<NorthsrilankaTourbooking> createState() =>
      _NorthsrilankaTourbookingState();
}

class _NorthsrilankaTourbookingState extends State<NorthsrilankaTourbooking> {
  double packageAmount = 99999.0; // Initial Package Amount
  double taxRate = 0.02; // 2% GST
  double discountRate = 0.05; // 5% Discount
  TextEditingController NameController = TextEditingController();
  TextEditingController _UseremailController = TextEditingController();
  TextEditingController PhoneNumberController = TextEditingController();
  TextEditingController AadhaarCardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;

    // Calculations

    double discountAmount = packageAmount * discountRate; // 5% Discount
    double discountedPackage =
        packageAmount - discountAmount; // Package after Discount
    double taxAmount =
        discountedPackage * taxRate; // 2% GST on discounted price
    double totalAmount = discountedPackage + taxAmount; // Final Total

    Widget _buildAdditionalFields() {
      double sw = MediaQuery.of(context)
          .size
          .width; // Get the width for use in this widget
      return Column(
        children: [
          Container(
            height: 50,
            width: sw * 0.9,
            decoration: BoxDecoration(
              color: Colors.white, // Set the background color to white
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  spreadRadius: 2, // How much the shadow should spread
                  blurRadius: 5, // How blurry the shadow should be
                  offset: Offset(0, 3), // Offset for the shadow
                ),
              ],
            ),
            child: TextFormField(
              controller: NameController,
              keyboardType: TextInputType.name, // Use the Name controller
              decoration: InputDecoration(
                hintText: 'Name', // Hint text for the Name field
                border: InputBorder.none, // Remove the default border
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10), // Add padding
              ),
            ),
          ),
          SizedBox(height: 15),

          // Email Field
          Container(
            height: 50,
            width: sw * 0.9,
            decoration: BoxDecoration(
              color: Colors.white, // Set the background color to white
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  spreadRadius: 2, // How much the shadow should spread
                  blurRadius: 5, // How blurry the shadow should be
                  offset: Offset(0, 3), // Offset for the shadow
                ),
              ],
            ),
            child: TextField(
              readOnly: false,
              controller: _UseremailController,
              decoration: InputDecoration(
                hintText: 'Email',
                border: InputBorder.none, // Remove the default border
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10), // Add padding
              ),
            ),
          ),
          SizedBox(height: 15),

          // Phone Number Field
          Container(
            height: 50,
            width: sw * 0.9,
            decoration: BoxDecoration(
              color: Colors.white, // Set the background color to white
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  spreadRadius: 2, // How much the shadow should spread
                  blurRadius: 5, // How blurry the shadow should be
                  offset: Offset(0, 3), // Offset for the shadow
                ),
              ],
            ),
            child: TextField(
              controller: PhoneNumberController,
              decoration: InputDecoration(
                hintText: 'Phone Number',
                border: InputBorder.none, // Remove the default border
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10), // Add padding
              ),
            ),
          ),
          SizedBox(height: 15),

          // Aadhaar Card Number Field
          Container(
            height: 50,
            width: sw * 0.9,
            decoration: BoxDecoration(
              color: Colors.white, // Set the background color to white
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  spreadRadius: 2, // How much the shadow should spread
                  blurRadius: 5, // How blurry the shadow should be
                  offset: Offset(0, 3), // Offset for the shadow
                ),
              ],
            ),
            child: TextField(
              controller: AadhaarCardController,
              decoration: InputDecoration(
                hintText: 'Aadhaar  Number',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
        ],
      );
    }

    Widget buildRowText(String label, String value) {
      return Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
              color: Mycolor.ButtonColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: sw * 0.05), // Space between label and value
          Text(
            value,
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      );
    }

    // Function to save booking details
    Future<void> _saveBookingDetails() async {
      // Get SharedPreferences instance
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Get values from TextEditingControllers
      String name = NameController.text;
      String email = _UseremailController.text;
      String phone = PhoneNumberController.text;
      String aadhaar = AadhaarCardController.text;

      String imagePath = 'assets/images/north srilanka.jpg';
      String packageName = 'North SriLanka Tour Package';

      // Store values in SharedPreferences
      await prefs.setString('name', name);
      await prefs.setString('email', email);
      await prefs.setString('phone', phone);
      await prefs.setString('aadhaar', aadhaar);
      await prefs.setString('imagePath', imagePath);
      await prefs.setString('packageName', packageName);

      // Print the values
      print('Name:---------------------- $name');
      print('Email:-------------------- $email');
      print('Phone: -----------------------$phone');
      print('Aadhaar: --------------$aadhaar');
      print('Image Path: ---------------------$imagePath');
      print('Package Name:--------------------- $packageName');
    }

    Future<void> _saveTotalAmount() async {
      // Save to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('totalAmount', totalAmount);
      print('TotalAmount:---------------------- $totalAmount');
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(35),
            bottomRight: Radius.circular(35),
          ),
          child: AppBar(
            backgroundColor: Mycolor.ButtonColor,
            centerTitle: true,
            title: const Text(
              'Booking Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: sw,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: sh * 0.05, left: sw * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: sh * 0.22,
                  width: sw * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage('assets/images/north srilanka.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'North SriLanka Tour Package',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Mycolor.ButtonColor),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Container(
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: sw * 0.065,
                            ),
                            Text(
                              '4.5',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.03),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildRowText('Duration : ', '20 pax 6days'),
                    SizedBox(height: sh * 0.01),
                    buildRowText('Tour Type : ', 'Daily Tour'),
                    SizedBox(height: sh * 0.01),
                    buildRowText('Members : ', '20 Paxs'),
                    SizedBox(height: sh * 0.02),
                  ],
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                ),
                SizedBox(height: sh * 0.02),
                Text(
                  'Tour Packages Highlights',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Mycolor.ButtonColor),
                ),
                SizedBox(height: sh * 0.01),
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Accommodation :   ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors
                                    .black, // Make sure to set the color, TextSpan defaults to white
                              ),
                            ),
                            TextSpan(
                              text:
                                  'Comfortable stays in nearby hotels or guesthouses, catering to various budgets.',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors
                                    .black, // Set the color for normal text
                              ),
                            ),
                          ],
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.02),
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Transportation :    ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors
                                    .black, // Make sure to set the color, TextSpan defaults to white
                              ),
                            ),
                            TextSpan(
                              text:
                                  'Includes transport from major cities (like Chennai or Trichy) to Velankanni, often with guided tours.',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors
                                    .black, // Set the color for normal text
                              ),
                            ),
                          ],
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Contect Details',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Mycolor.ButtonColor),
                ),
                SizedBox(height: 20),
                _buildAdditionalFields(),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Price Details',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Mycolor.ButtonColor),
                ),
                SizedBox(height: 20),
                _buildRowWithSpacer(
                    'Tour Package', '₹ ${packageAmount.toStringAsFixed(2)}'),
                SizedBox(height: 10),
                // Row for Tax and Service (2%)
                _buildRowWithSpacer('Tax and Service (2%)',
                    '₹ ${taxAmount.toStringAsFixed(2)}'),
                SizedBox(height: 10),
                // Row for Discount (5%)
                _buildRowWithSpacer(
                    'Discount (5%)', '₹ ${discountAmount.toStringAsFixed(2)}'),
                SizedBox(height: 10),
                Divider(height: 20, thickness: 2),
                // Row for Total Amount (bold and colored)
                _buildRowWithSpacer(
                    'Total Amount', '₹ ${totalAmount.toStringAsFixed(2)}',
                    isBold: true, textColor: Mycolor.ButtonColor),

                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          _saveBookingDetails();
                          _saveTotalAmount();
                          String name = NameController.text.trim();
                          String email = _UseremailController.text;
                          String phone = PhoneNumberController.text;
                          String aadhaar = AadhaarCardController.text;

                          // Check if all fields are filled
                          if (name.isEmpty ||
                              email.isEmpty ||
                              phone.isEmpty ||
                              aadhaar.isEmpty) {
                            // Show a snackbar if any field is empty
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Please fill all fields',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: const Color.fromARGB(
                                    255, 206, 16, 3), // Red background color
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            _saveBookingDetails();
                            _saveTotalAmount();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PackagePayment(grandTotal: totalAmount),
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 50,
                          width: sw * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Mycolor.ButtonColor,
                          ),
                          child: Center(
                            child: Text(
                              'Book Now',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to create text rows
  Widget _buildRowWithSpacer(String label, String value,
      {bool isBold = false, Color textColor = Colors.black}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label :',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}
