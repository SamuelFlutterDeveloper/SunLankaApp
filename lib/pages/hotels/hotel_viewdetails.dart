import 'dart:io';

import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sun_lunka_app/pages/customs/colors.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:unicons/unicons.dart';

class HistoryViewDetails extends StatefulWidget {
  const HistoryViewDetails({super.key});

  @override
  State<HistoryViewDetails> createState() => _HistoryViewDetailsState();
}

class _HistoryViewDetailsState extends State<HistoryViewDetails> {
  String hotelImage = '';
  String hotelName = '';
  String checkInDate = '';
  String checkOutDate = '';
  String checkInTime = '';
  String checkOutTime = '';
  String selectedRooms = '';
  String selectedAdults = '';
  String selectedChildren = '';
  String firstName = '';
  String lastName = '';
  String phone = '';
  String email = '';
  String aadhaar = '';
  double totalAmount = 0.0;
  bool isExpanded = false;

  void initState() {
    super.initState();
    _loadBookingDetails();
  }

  // Example of the price calculation functions (as you provided)
  final double roomPrice = 5500.0;

  double calculateRoomCost(int roomQty) {
    return roomQty * roomPrice;
  }

  double calculateGST(double amount) {
    return amount * 0.02; // 2% GST
  }

  double calculateDiscount(double amount) {
    return amount * 0.10; // 10% discount
  }

  double calculateTotal(double amount, double gst, double discount) {
    return amount + gst - discount; // Total calculation
  }

  Future<void> _loadBookingDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      hotelImage = prefs.getString('hotelImage')!;
      hotelName = prefs.getString('hotelName')!;
      checkInDate = prefs.getString('checkInDate') ?? 'Not Selected';
      checkOutDate = prefs.getString('checkOutDate') ?? 'Not Selected';
      checkInTime = prefs.getString('checkInTime') ?? 'Not Selected';
      checkOutTime = prefs.getString('checkOutTime') ?? 'Not Selected';
      selectedRooms = prefs.getString('selectedRooms') ?? '0';
      selectedAdults = prefs.getString('selectedAdults') ?? '0';
      selectedChildren = prefs.getString('selectedChildren') ?? '0';
      firstName = prefs.getString('firstName') ?? '';
      lastName = prefs.getString('lastName') ?? '';
      phone = prefs.getString('phone') ?? '';
      email = prefs.getString('email') ?? '';
      aadhaar = prefs.getString('aadhaar') ?? '';
      totalAmount = prefs.getDouble('totalAmount') ?? 0.0;
    });
  }

  Future<void> _createAndSharePDF() async {
    // Create a PDF document.
    final PdfDocument document = PdfDocument();

    // Add a page.
    final PdfPage page = document.pages.add();

    // Create a font and draw text for booking details.
    final PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 12);
    page.graphics.drawString('Booking Details:', font,
        bounds: const Rect.fromLTWH(0, 0, 500, 20));

    // Add the booking details to the PDF.
    page.graphics.drawString('Hotel Name: $hotelName', font,
        bounds: const Rect.fromLTWH(0, 40, 500, 20));
    page.graphics.drawString('Check-In Date: $checkInDate', font,
        bounds: const Rect.fromLTWH(0, 60, 500, 20));
    page.graphics.drawString('Check-Out Date: $checkOutDate', font,
        bounds: const Rect.fromLTWH(0, 80, 500, 20));
    page.graphics.drawString('Check-In Time: $checkInTime', font,
        bounds: const Rect.fromLTWH(0, 100, 500, 20));
    page.graphics.drawString('Check-Out Time: $checkOutTime', font,
        bounds: const Rect.fromLTWH(0, 120, 500, 20));
    page.graphics.drawString('Rooms: $selectedRooms', font,
        bounds: const Rect.fromLTWH(0, 140, 500, 20));
    page.graphics.drawString('Adults: $selectedAdults', font,
        bounds: const Rect.fromLTWH(0, 160, 500, 20));
    page.graphics.drawString('Children: $selectedChildren', font,
        bounds: const Rect.fromLTWH(0, 180, 500, 20));
    page.graphics.drawString('First Name: $firstName', font,
        bounds: const Rect.fromLTWH(0, 200, 500, 20));
    page.graphics.drawString('Last Name: $lastName', font,
        bounds: const Rect.fromLTWH(0, 220, 500, 20));
    page.graphics.drawString('Phone: $phone', font,
        bounds: const Rect.fromLTWH(0, 240, 500, 20));
    page.graphics.drawString('Email: $email', font,
        bounds: const Rect.fromLTWH(0, 260, 500, 20));
    page.graphics.drawString('National Identity Card (NIC): $aadhaar', font,
        bounds: const Rect.fromLTWH(0, 280, 500, 20));
    page.graphics.drawString('Total Amount: $totalAmount', font,
        bounds: const Rect.fromLTWH(0, 300, 500, 20));

    // Save the document to a local file.
    List<int> bytes = document.saveSync();
    document.dispose();

    // Get the application directory to save the PDF.
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    final File file = File('$path/booking_details.pdf');
    await file.writeAsBytes(bytes, flush: true);

    // Share the PDF using share_plus with XFile.
    final XFile xFile = XFile(file.path);
    Share.shareXFiles([xFile], text: 'Here are your booking details.');
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // Set the height you prefer
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35), // Apply bottom left radius
            bottomRight: Radius.circular(35), // Apply bottom right radius
          ),
          child: AppBar(
            backgroundColor: Mycolor.ButtonColor,
            centerTitle: true,
            title: Text(
              'Booking History',
              style: TextStyle(
                fontSize: 24,
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
        height: sh,
        width: sw,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: sh * 0.05),

                // Order Details Text
                Text(
                  'Order Details',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Mycolor.ButtonColor,
                  ),
                ),
                SizedBox(height: 20),

                // User Info Container
                Container(
                  height: 100,
                  width: sw * 0.85,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        // Icon Container
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.person,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 20),

                        // User Details Column
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  firstName,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Mycolor.ButtonColor,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  lastName,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Mycolor.ButtonColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              email,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Hotel Info Container
                Container(
                  height: 120,
                  width: sw * 0.85,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10), // Use const where possible
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hotel Name and Price Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Align text to the top
                          children: [
                            // Hotel Name Section
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start, // Left align text
                                children: [
                                  Text(
                                    hotelName,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Mycolor.ButtonColor,
                                    ),
                                    overflow: TextOverflow
                                        .ellipsis, // Prevents overflow
                                  ),
                                  SizedBox(
                                      height:
                                          5), // Add spacing between hotel name and empty text
                                  Text(
                                    '', // Empty for now
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Mycolor.TextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Price and GST Section
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.end, // Align to the right
                              children: [
                                Text(
                                  'Rs.5,500',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow:
                                      TextOverflow.ellipsis, // Prevent overflow
                                ),
                                Text(
                                  '+GST',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Location and Stars Row
                        // Add spacing between the two rows
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Location Section
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color:
                                        const Color.fromARGB(255, 211, 17, 4),
                                    size: 25,
                                  ),
                                  SizedBox(
                                      width: 5), // Space between icon and text
                                  Flexible(
                                    child: Text(
                                      '9/36 Unique View Road,\n222000 Nuwara Eliya,SriLanka',
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                      overflow: TextOverflow
                                          .ellipsis, // Prevents overflow
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
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
                                    size: sw * 0.055,
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Container(
                  width: sw * 0.85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),

                        // Check-in and Check-out Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Corrected alignment
                              children: [
                                Text(
                                  'Check In',
                                  style: TextStyle(
                                    fontSize: 15, // Reduced font size
                                    fontWeight: FontWeight.bold,
                                    color: Mycolor.ButtonColor,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  checkInDate,
                                  style: TextStyle(
                                    fontSize: 15, // Reduced font size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Check Out',
                                  style: TextStyle(
                                    fontSize: 15, // Reduced font size
                                    fontWeight: FontWeight.bold,
                                    color: Mycolor.ButtonColor,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  checkOutDate,
                                  style: TextStyle(
                                    fontSize: 15, // Reduced font size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 10),
                        Divider(color: Colors.grey, thickness: 0.6),
                        SizedBox(height: 10),

                        // Number of Rooms and Adults Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'No of Rooms',
                                  style: TextStyle(
                                    fontSize: 15, // Reduced font size
                                    fontWeight: FontWeight.bold,
                                    color: Mycolor.ButtonColor,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '${selectedRooms} Rooms',
                                  style: TextStyle(
                                    fontSize: 15, // Reduced font size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'No of Adults',
                                  style: TextStyle(
                                    fontSize: 15, // Reduced font size
                                    fontWeight: FontWeight.bold,
                                    color: Mycolor.ButtonColor,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '${selectedAdults} Adults',
                                  style: TextStyle(
                                    fontSize: 15, // Reduced font size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 10),
                        Divider(color: Colors.grey, thickness: 0.6),
                        SizedBox(height: 10),

                        // Phone No and Aadhaar No Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Phone No',
                                  style: TextStyle(
                                    fontSize: 15, // Reduced font size
                                    fontWeight: FontWeight.bold,
                                    color: Mycolor.ButtonColor,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  phone,
                                  style: TextStyle(
                                    fontSize: 15, // Reduced font size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '(NIC) Number',
                                  style: TextStyle(
                                    fontSize: 15, // Reduced font size
                                    fontWeight: FontWeight.bold,
                                    color: Mycolor.ButtonColor,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  aadhaar,
                                  style: TextStyle(
                                    fontSize: 15, // Reduced font size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 10),
                        Divider(color: Colors.grey, thickness: 0.6),
                        SizedBox(height: 20),

                        // Total Price and Expandable Section
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: sw * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: const Color.fromARGB(255, 158, 19, 9),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Total Price :",
                                      style: TextStyle(
                                        fontSize: 18, // Reduced font size
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      '₹ $totalAmount',
                                      style: TextStyle(
                                        fontSize: 18, // Reduced font size
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isExpanded =
                                                !isExpanded; // Toggle expanded state
                                          });
                                        },
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: Icon(
                                            isExpanded
                                                ? Icons
                                                    .keyboard_arrow_up_rounded
                                                : Icons
                                                    .keyboard_arrow_down_rounded,
                                            size: 20,
                                            color: const Color.fromARGB(
                                                255, 158, 19, 9),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (isExpanded)
                                  _buildPriceDetails(), // Show price details if expanded
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        // Share Button
                        Center(
                          child: GestureDetector(
                            onTap: _createAndSharePDF,
                            child: Container(
                              height: 50,
                              width: sw * 0.4,
                              decoration: BoxDecoration(
                                color: Mycolor.ButtonColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(UniconsLine.share),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Share',
                                    style: TextStyle(
                                      fontSize: 18, // Reduced font size
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceDetails() {
    int roomQty = int.tryParse(selectedRooms ?? '0') ?? 0;

    // Calculate amounts
    double roomCost = calculateRoomCost(roomQty);
    double gst = calculateGST(roomCost);
    double discount = calculateDiscount(roomCost);
    double total = calculateTotal(roomCost, gst, discount);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Room Qty:${selectedRooms}*5500',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                '₹ ${roomCost.toStringAsFixed(0)}',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'GST (2%):',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                '₹ ${gst.toStringAsFixed(0)}',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Discount (10%):',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                '₹ ${discount.toStringAsFixed(0)}',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 5),
          Divider(color: Colors.white, thickness: 1),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                '₹ ${total.toStringAsFixed(0)}',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
