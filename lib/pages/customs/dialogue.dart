import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math'; // For generating a random transaction ID
 // Ensure you have the correct import for Home

class DialogHelper {
  // Function to show a success dialog with a checkmark icon, paid amount, and transaction ID
  static Future<void> showSuccessDialog(
    //its show the location of the wedgeit where the information to show
    BuildContext context, {
    //payment success is a title
    required String title,
    //Your order has been booked successfully! is a message
    required String message,
    //total ammount is store in that
    required double totalAmount,
    // its a call back function
    required VoidCallback onDone,
    //done is a botton button color
    Color buttonColor =
        const Color.fromARGB(255, 20, 168, 25), // Default button color
  }) async {
    // Generate a random transaction ID and format it for better readability
    String transactionId = _generateFormattedTransactionID();
    // Save the generated transaction ID in SharedPreferences
    await _saveTransactionId(transactionId);

    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Prevent closing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Rounded corners
          ),
          contentPadding: EdgeInsets.all(20), // Add padding around content
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 100.0, // Success icon size
              ),
              SizedBox(height: 20),
              Text(
                '₹${totalAmount.toStringAsFixed(2)} Paid', // Show full paid amount
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                message, // "Payment Successful" message
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Transaction ID: $transactionId', // Formatted Transaction ID
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: onDone, // Go to Home when "Done" is clicked
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor, // Customizable button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper function to generate a formatted random transaction ID
  //_generateFormattedTransactionID its function name this name only call in the top of the code
  static _generateFormattedTransactionID() {
    //its the char is varaible storing that date
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    // using  Random() its show any random variable
    Random random = Random();
    //its used to choose any 12 random variable and store in the rawId
    String rawId = String.fromCharCodes(Iterable.generate(
        12, (_) => chars.codeUnitAt(random.nextInt(chars.length))));

    // Format as groups of 4 characters (e.g., ABCD-EFGH-IJKL)
    //and contain total 14 character
    return rawId
        .replaceAllMapped(RegExp(r".{4}"), (match) => '${match.group(0)}-')
        .substring(0, 14);
  }

  // Helper function to save transaction ID in local storage (SharedPreferences)
  static Future<void> _saveTransactionId(String transactionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'transactionId', transactionId); // Store the transaction ID
  }

  // Function to retrieve transaction ID from local storage
  static Future<String?> getTransactionId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('transactionId');
    // Retrieve the transaction ID
  }

  //to print the transaction id
  void _printTransactionId() async {
    String? transactionId = await DialogHelper.getTransactionId();

    if (transactionId != null) {
      print('Stored Transaction ID: $transactionId');
    } else {
      print('No Transaction ID found.');
    }
  }

  static void showInfoDialog(BuildContext context,
      {required String title, required String message}) {}

  // static void showInfoDialog(BuildContext context,
  //     {required String title, required String message}) {}
}
