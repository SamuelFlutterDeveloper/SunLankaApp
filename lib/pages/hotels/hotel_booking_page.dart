import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sun_lunka_app/pages/customs/colors.dart';
import 'package:sun_lunka_app/pages/hotels/hotel_payment_page.dart';

class HotelBooking extends StatefulWidget {
  const HotelBooking({super.key});

  @override
  State<HotelBooking> createState() => _HotelBookingState();
}

class _HotelBookingState extends State<HotelBooking> {
  String checkInDate = '';
  String checkOutDate = '';
  String checkInTime = '';
  String checkOutTime = '';
  String hotelImage = '';
  String hotelName = '';
  String? hotelUrl = '';
  String? selectedRooms;
  String? selectedAdults;
  String? selectedChildren;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController _UserLastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController aadhaarController = TextEditingController();
  double totalAmount = 0.0; // Variable to hold the total amount
  @override
  void initState() {
    super.initState();
    _loadBookingData();
    _loadBookingDetails();
  }

  Future<void> _loadBookingDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      hotelImage = prefs.getString('hotelImage')!;
      hotelName = prefs.getString('hotelName')!;
      hotelUrl = prefs.getString('hotelUrl')!;
    });
    print('$hotelImage--------------------------------');
    print('$hotelName--------------------------------');
    print('$hotelUrl!--------------------------------');
  }

  Future<void> _loadBookingData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      checkInDate = prefs.getString('checkInDate') ?? 'Not Selected';
      checkOutDate = prefs.getString('checkOutDate') ?? 'Not Selected';
      checkInTime = prefs.getString('checkInTime') ?? 'Not Selected';
      checkOutTime = prefs.getString('checkOutTime') ?? 'Not Selected';
      selectedRooms = prefs.getString('selectedRooms') ?? '0';
      selectedAdults = prefs.getString('selectedAdults') ?? '0';
      selectedChildren = prefs.getString('selectedChildren') ?? '0';
      firstNameController.text = prefs.getString('firstName') ?? '';
      _UserLastNameController.text = prefs.getString('lastName') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      phoneController.text = prefs.getString('phone') ?? '';
      aadhaarController.text = prefs.getString('aadhaar') ?? '';
      totalAmount = prefs.getDouble('totalAmount') ?? 0.0; // Load total amount

      // Print all loaded data
      print('Check-In Date: --------------------$checkInDate');
      print('Check-Out Date:--------------------------- $checkOutDate');
      print('Check-In Time:-------------------- $checkInTime');
      print('Check-Out Time: ---------------------------$checkOutTime');
      print('Selected Rooms: ----------------------$selectedRooms');
      print('Selected Adults:----------------------- $selectedAdults');
      print('Selected Children: --------------------------$selectedChildren');
      print('First Name: -----------------------${firstNameController.text}');
      print(
          'Last Name:-------------------------------- ${_UserLastNameController.text}');
      print('Email:------------------------- ${_emailController.text}');
      print('Phone: --------------------------------${phoneController.text}');
      print(
          'Aadhaar: ----------------------------------${aadhaarController.text}');
      print('Total Amount:------------------------------------ $totalAmount');
    });
  }

  Future<void> _saveBookingData(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> _saveNameData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    print('Before saving: Last Name: ${_UserLastNameController.text}');

    // Save data
    await prefs.setString('firstName', firstNameController.text);
    await prefs.setString('lastName', _UserLastNameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('phone', phoneController.text);
    await prefs.setString('aadhaar', aadhaarController.text);

    // Print all saved data
    print('First Name:---------- ${firstNameController.text}');
    print('Last Name:---------- ${_UserLastNameController.text}');
    print('Email:----------- ${_emailController.text}');
    print('Phone: ------------${phoneController.text}');
    print('Aadhaar:------------ ${aadhaarController.text}');
  }

  Future<void> _saveTotalAmount(double amount) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('totalAmount', amount);
    print('Total Amount Saved: ------------------₹$amount');
  }

  // Define the price per room
  final double roomPrice = 5500.0;

// Add this method to calculate price details
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

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;

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
              'Hotel Booking Details',
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
        height: sh,
        width: sw,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Container(
                height: sh * 0.2,
                width: sw * 0.9,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(hotelImage),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              SizedBox(height: 20),
              _buildHotelInfo(sw),
              SizedBox(height: 10),
              Divider(color: Colors.grey, thickness: 0.5),
              SizedBox(height: 10),
              _buildDateInfoRow(),
              SizedBox(height: 15),
              _buildRoomsHeader(),
              SizedBox(height: 15),
              _buildRoomDropdowns(sw),
              SizedBox(height: 20),
              _buildPackageInfo(),
              SizedBox(height: 15),
              _buildContactDetails(),
              SizedBox(height: 20),
              _buildNameFields(),
              SizedBox(height: 20),
              _buildAdditionalFields(), // Add this line
              SizedBox(height: 20),

              _buildPriceDetails(),

              SizedBox(height: 30),
              GestureDetector(
                onTap: () async {
                  if (aadhaarController.text.length != 12) {
                    // Show SnackBar if Aadhaar number is not exactly 12 digits
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter exactly 12 digits for NIC'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return; // Stop further execution
                  }

                  if (firstNameController.text.isEmpty ||
                      _UserLastNameController.text.isEmpty ||
                      _emailController.text.isEmpty ||
                      phoneController.text.isEmpty ||
                      aadhaarController.text.isEmpty ||
                      selectedRooms == '0' ||
                      selectedAdults == '0') {
                    // Show SnackBar if any required field is empty
                    final snackBar = SnackBar(
                      content: Text('Please fill in all the fields'),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    await _saveNameData();
                    await _loadBookingData();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HotelPayment(
                          grandTotal: totalAmount,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  height: 50,
                  width: sw * 0.9,
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
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalFields() {
    double sw = MediaQuery.of(context)
        .size
        .width; // Get the width for use in this widget
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
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
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                border: InputBorder.none, // Remove the default border
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10), // Add padding
              ),
            ),
          ),
          SizedBox(height: 10),

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
              controller: phoneController,
              decoration: InputDecoration(
                hintText: 'Phone Number',
                border: InputBorder.none, // Remove the default border
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10), // Add padding
              ),
            ),
          ),
          SizedBox(height: 10),

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
              controller: aadhaarController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(12),
              ],
              decoration: InputDecoration(
                hintText: 'National Identity Card (NIC)',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
        ],
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

    _saveTotalAmount(total); // Store the total amount

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Details',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Mycolor.TextColor,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Room Qty: ${selectedRooms}*5500',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                '₹ ${roomCost.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ), // Room cost
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'GST (2%):',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                '₹ ${gst.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ), // GST
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Discount (10%):',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                '₹ ${discount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ), // Discount
            ],
          ),
          SizedBox(height: 5),
          Divider(color: Colors.grey, thickness: 1),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                '₹ ${total.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ), // Total
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHotelInfo(double sw) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$hotelName',
                  style: TextStyle(
                    fontSize: sw * 0.058,
                    fontWeight: FontWeight.bold,
                    color: Mycolor.ButtonColor,
                  ),
                ),
                Text(
                  '9/36 Unique View Road,\n222000 Nuwara Eliya,SriLanka',
                  style: TextStyle(
                    fontSize: sw * 0.035,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 10),
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
    );
  }

  Widget _buildRoomsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Rooms',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Mycolor.ButtonColor,
          ),
        ),
      ),
    );
  }

  Widget _buildPackageInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Platinum Package",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Mycolor.ButtonColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(255, 90, 90, 90)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Breakfast,Lunch/Dinner Provider",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(255, 90, 90, 90)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Welcome Drinks",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 90, 90, 90)),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Complementry in Check In\nand Late Check Out",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(255, 90, 90, 90)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Upto discount on 10% in Booking ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateInfoRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDateInfo('Check In', checkInDate, checkInTime),
          _buildDateInfo('Check Out', checkOutDate, checkOutTime),
        ],
      ),
    );
  }

  Widget _buildDateInfo(String title, String date, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Mycolor.ButtonColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          date,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildRoomDropdowns(double sw) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              sw * 0.05), // Adjust horizontal padding for responsiveness
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDropdownLabel('Number of Rooms'),
          _buildDropdownWithShadow(
            'Select Number of Rooms',
            selectedRooms,
            (value) {
              setState(() {
                selectedRooms = value ?? '0';
                _saveBookingData('selectedRooms', selectedRooms!);
              });
            },
            sw,
          ),
          SizedBox(height: 20),
          _buildDropdownLabel('Number of Adults'),
          _buildDropdownWithShadow(
            'Select Number of Adults',
            selectedAdults,
            (value) {
              setState(() {
                selectedAdults = value ?? '0';
                _saveBookingData('selectedAdults', selectedAdults!);
              });
            },
            sw,
          ),
          SizedBox(height: 20),
          _buildDropdownLabel('Number of Children'),
          _buildDropdownWithShadow(
            'Select Number of Children',
            selectedChildren,
            (value) {
              setState(() {
                selectedChildren = value ?? '0';
                _saveBookingData('selectedChildren', selectedChildren!);
              });
            },
            sw,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownWithShadow(
      String hint, String? value, ValueChanged<String?> onChanged, double sw) {
    return Container(
      height: 50,
      width: sw * 0.9, // Responsive width
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(0, 3), // Changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton<String>(
          isExpanded: true,
          underline: SizedBox(),
          hint: Text(
            hint,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          value: value == '0' ? null : value,
          items: List.generate(11, (index) {
            return DropdownMenuItem<String>(
              value: '$index',
              child: Text(index == 0 ? '$hint' : '$index'),
            );
          }),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDropdownLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, left: 5),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  // Widget _buildDropdownLabel(String text) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 5.0, left: 5),
  //     child: Text(
  //       text,
  //       style: TextStyle(
  //         fontSize: 16,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.black,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildDropdownRow(
      String hint, String? value, ValueChanged<String?> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildDropdown(hint, value, onChanged),
        ),
        SizedBox(width: 10), // Space between dropdowns
      ],
    );
  }

  Widget _buildDropdown(
      String hint, String? value, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              hint,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          value: value == '0' ? null : value,
          items: List.generate(11, (index) {
            return DropdownMenuItem<String>(
              value: '$index',
              child: Text(index == 0 ? 'Select $hint' : '$index'),
            );
          }),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildContactDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Contact Details',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Mycolor.ButtonColor,
          ),
        ),
      ),
    );
  }

  Widget _buildNameFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 50,
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
                controller: firstNameController,
                decoration: InputDecoration(
                  hintText: 'First Name',
                  border: InputBorder.none, // Remove the default border
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10), // Add padding
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 50,
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
                controller: _UserLastNameController,
                onChanged: (value) {
                  print('Last Name Input: $value'); // Debug log
                },
                decoration: InputDecoration(
                  hintText: 'Last Name',
                  border: InputBorder.none, // Remove the default border
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10), // Add padding
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
