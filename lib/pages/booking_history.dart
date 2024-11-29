import 'package:flutter/material.dart';

import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sun_lunka_app/pages/checkin_checkout.dart';
import 'package:sun_lunka_app/pages/customs/colors.dart';
import 'package:sun_lunka_app/pages/hotels/hotel_viewdetails.dart';

class HotelBookingHistory extends StatefulWidget {
  const HotelBookingHistory({super.key});

  @override
  State<HotelBookingHistory> createState() => _HotelBookingHistoryState();
}

class _HotelBookingHistoryState extends State<HotelBookingHistory> {
  List<bool> featureStates = List.generate(6, (index) => false);
  // Variables for booking details
  String? hotelImage;
  String? hotelName;
  String? checkInDate;
  String? checkOutDate;
  String checkInTime = '';
  String checkOutTime = '';
  String? selectedRooms;
  String? selectedAdults;
  String? selectedChildren;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? aadhaar;
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _loadBookingDetails();
  }

  Future<void> _loadBookingDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      hotelImage = prefs.getString('hotelImage')!;
      hotelName = prefs.getString('hotelName')!;
      checkInDate = prefs.getString('checkInDate')!;
      checkOutDate = prefs.getString('checkOutDate')!;
      checkInTime = prefs.getString('checkInTime')!;
      checkOutTime = prefs.getString('checkOutTime')!;
      selectedRooms = prefs.getString('selectedRooms');
      selectedAdults = prefs.getString('selectedAdults');
      selectedChildren = prefs.getString('selectedChildren');
      firstName = prefs.getString('firstName') ?? '';
      lastName = prefs.getString('lastName') ?? '';
      phone = prefs.getString('phone') ?? '';
      email = prefs.getString('email') ?? '';
      aadhaar = prefs.getString('aadhaar') ?? '';
      totalAmount = prefs.getDouble('totalAmount') ?? 0.0;
    });
  }

  // Future<void> _clearBookingDetails() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   // Remove specific keys
  //   await prefs.remove('hotelImage');
  //   await prefs.remove('hotelName');
  //   await prefs.remove('checkInDate');
  //   await prefs.remove('checkOutDate');
  //   await prefs.remove('selectedAdults');

  //   // Reload booking details to reflect changes in the UI
  //   _loadBookingDetails();
  // }

  // Define a method for dynamic booking containers
  Widget _buildDynamicBookingContainer() {
    // Check if all required booking details are available
    if ((hotelImage == null || hotelImage!.isEmpty) ||
        (hotelName == null || hotelName!.isEmpty) ||
        (checkInDate == null || checkInDate!.isEmpty) ||
        (checkOutDate == null || checkOutDate!.isEmpty) ||
        (selectedAdults == null || selectedAdults!.isEmpty)) {
      // Assuming selectedAdults is an integer
      // Print a message if any required data is missing
      print("Booking details are missing:");
      print("hotelImage: $hotelImage");
      print("hotelName: $hotelName");
      print("checkInDate: $checkInDate");
      print("checkOutDate: $checkOutDate");
      print("selectedAdults: $selectedAdults");

      return SizedBox(); // Return nothing if any required data is missing
    }

    // Format the date to show only day and month
    String formattedCheckInDate =
        "${checkInDate!.split(' ')[0]} ${checkInDate!.split(' ')[1]}";
    String formattedCheckOutDate =
        "${checkOutDate!.split(' ')[0]} ${checkOutDate!.split(' ')[1]}";

    // Print the valid booking details
    print("Booking details:");
    print("hotelImage: -------------$hotelImage");
    print("hotelName: -------------$hotelName");
    print("formattedCheckInDate: -----------------$formattedCheckInDate");
    print("formattedCheckOutDate: ------------$formattedCheckOutDate");
    print("dynamicGuests:-----------'${selectedAdults} Guests'");
    print("dynamicAddress: -----------'Nagapattinam BuyPass,\nNagapattinam'");

    // Call the _buildBookingContainer with dynamic data
    return _buildBookingContainerDynamic(
      dynamicImageUrl: hotelImage!, // Image from local variable
      dynamicHotelName: hotelName!, // Hotel name from local variable
      dynamicDateRange:
          "$formattedCheckInDate - $formattedCheckOutDate", // Date range
      dynamicGuests:
          '${selectedAdults}Guest', // Guests info from local variable
      dynamicAddress: 'Nagapattinam BuyPass,\nNagapattinam', // Static address
    );
  }

// New method for building booking container specifically for dynamic bookings
  Widget _buildBookingContainerDynamic({
    required String dynamicImageUrl,
    required String dynamicHotelName,
    required String dynamicDateRange,
    required String dynamicGuests,
    required String dynamicAddress,
  }) {
    double sw = MediaQuery.of(context).size.width; // Screen width
    double sh = MediaQuery.of(context).size.height; // Screen height

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
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
        padding:
            EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sh * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: sh * 0.10, // Image height 10% of screen height
                  width: sh * 0.10, // Image width 10% of screen height
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(dynamicImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: sw * 0.05), // Space between image and text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dynamicHotelName,
                        style: TextStyle(
                            fontSize: sw *
                                0.05, // Font size responsive to screen width
                            fontWeight: FontWeight.bold,
                            color: Mycolor.ButtonColor),
                        overflow: TextOverflow.ellipsis, // Prevent overflow
                      ),
                      SizedBox(height: sh * 0.005), // Small space between texts
                      Row(
                        children: [
                          Text(
                            dynamicDateRange,
                            style: TextStyle(
                              fontSize: sw * 0.04, // Responsive font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              width: sw *
                                  0.01), // Space between date range and dot
                          Container(
                            height: sw * 0.02,
                            width: sw * 0.02,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: sw * 0.01),
                          Text(
                            dynamicGuests,
                            style: TextStyle(
                              fontSize: sw * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sh * 0.005),
                      Text(
                        dynamicAddress,
                        overflow: TextOverflow.ellipsis, // Prevent overflow
                        maxLines: 1, // Limit text to one line
                        style: TextStyle(
                          fontSize: sw * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: sh * 0.03), // Adjust space between content
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    print('Book again pressed');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckIn()),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month_rounded,
                          size: sw * 0.05), // Icon size responsive
                      SizedBox(width: sw * 0.03), // Space between icon and text
                      Text(
                        'Book Again',
                        style: TextStyle(
                          fontSize: sw * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    print('View details pressed');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HistoryViewDetails()),
                    );
                  },
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      fontSize: sw * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _showRoomAccessDialog(); // Show dialog on tap
                },
                child: Container(
                  height: sh * 0.04, // Button height 6% of screen height
                  width: sw * 0.4, // Button width 40% of screen width
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 172, 12, 1),
                  ),
                  child: Center(
                    child: Text(
                      'Electrical Access',
                      style: TextStyle(
                        fontSize: sw * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showRoomAccessDialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String hotelName =
        prefs.getString('hotelName') ?? ''; // Default to empty if not found

    TextEditingController hotelNameController =
        TextEditingController(text: hotelName);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Room Access Card',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Mycolor.ButtonColor,
                  ),
                ),
                Divider(thickness: 1),
                SizedBox(height: 10),
                Text(
                  'You will access the Hotel \nFeature in this app',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(thickness: 1),
                SizedBox(height: 10),
                Text(
                  'Hotel Name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Mycolor.ButtonColor,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 40,
                  width: 300,
                  child: TextField(
                    controller: hotelNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: Mycolor.ButtonColor, width: 2.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: Mycolor.ButtonColor, width: 2.0),
                      ),
                      hintText: 'Enter your Hotel Name',
                    ),
                    enabled: false, // Disable editing
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _showPasswordDialog();
                  },
                  child: Container(
                    height: 40,
                    width: 280,
                    decoration: BoxDecoration(
                      color: Mycolor.ButtonColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPasswordDialog() {
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Room Access Card',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Mycolor.ButtonColor)),
                Divider(thickness: 1),
                SizedBox(height: 10),
                Text('You will access the Hotel \nFeature in this app',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)),
                Divider(thickness: 1),
                SizedBox(height: 10),
                Text('Room Pin Number',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Mycolor.ButtonColor)),
                SizedBox(height: 10),
                Pinput(
                  length: 4,
                  controller: passwordController,
                  obscureText: true,
                  obscuringCharacter: '*',
                  defaultPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Mycolor.ButtonColor),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 56,
                    height: 60,
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Mycolor.ButtonColor), // Focused border color
                    ),
                  ),
                  onChanged: (value) {
                    if (value.length == 4) {
                      // Navigate to next screen only when 4 digits are entered
                      Navigator.pop(context);
                      _showRoomFeaturesDialog(hotelName!);
                    }
                  },
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if (passwordController.text.length == 4) {
                      Navigator.pop(context);
                      _showRoomFeaturesDialog(hotelName!);
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 280,
                    decoration: BoxDecoration(
                        color: Mycolor.ButtonColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text('Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20))),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showRoomFeaturesDialog(String hotelName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Room Access Card',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Mycolor.ButtonColor),
                    ),
                    Divider(thickness: 1),
                    SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(hotelName,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Text('Control Your Room Electrical Items',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 172, 12, 1))),
                      ],
                    ),
                    Divider(thickness: 1),
                    SizedBox(height: 10),
                    // Build feature rows with state management
                    _buildFeatureRow('Room Door', 0, setState),
                    _buildFeatureRow('Fan', 1, setState),
                    _buildFeatureRow('AC', 2, setState),
                    _buildFeatureRow('Windows', 3, setState),
                    _buildFeatureRow('TV', 4, setState),
                    _buildFeatureRow('Geyser', 5, setState),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Container(
                        height: 40,
                        width: 280,
                        decoration: BoxDecoration(
                          color: Mycolor.ButtonColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            'Done',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildBookingContainer({
    required String imageUrl1,
    required String hotelname1,
    required String dateRange1,
    required String guests1,
    required String address1,
    bool isDynamic =
        false, // New parameter to check if the container is dynamic
  }) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;

    return Container(
      // Main container for layout
      height: sh * 0.25, // Adjusted height for better content spacing
      width: sw * 0.9,
      child: Stack(
        // Stack to handle both content and positioned overlay
        children: [
          // Main content container
          Container(
            height: sh * 0.25,
            width: sw * 0.88,
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
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage(imageUrl1),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hotelname1,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Mycolor.ButtonColor),
                              overflow: TextOverflow
                                  .ellipsis, // Prevent text overflow
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  dateRange1,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Container(
                                  height: 8,
                                  width: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  guests1,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              address1,
                              overflow:
                                  TextOverflow.ellipsis, // Prevent overflow
                              maxLines:
                                  1, // Limit to a single line for better alignment
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_month_rounded),
                          SizedBox(width: 10),
                          Text(
                            'Book Again',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        'View Details',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (!isDynamic) // Overlay for static containers only
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: sh * 0.25, // Match container height for overlay
                width: sw * 0.88,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:
                      const Color.fromARGB(255, 219, 216, 216).withOpacity(0.5),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: AppBar(
            backgroundColor: Mycolor.ButtonColor,
            centerTitle: true,
            title: Text(
              'Booking History',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: sh,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: sh * 0.05),
                Text(
                  "Order History",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Mycolor.TextColor,
                  ),
                ),
                SizedBox(height: 20),
                // Static Booking Container 1
                _buildBookingContainer(
                  imageUrl1: 'assets/images/winchester.jpg',
                  hotelname1: 'Winchester Little England',
                  dateRange1: '05 Aug - 06 Aug',
                  guests1: '2 Guest',
                  address1: 'South SriLanka,\nNuwara Eliya',
                ),
                SizedBox(height: 20),
                // Static Booking Container 2
                _buildBookingContainer(
                  imageUrl1: 'assets/images/pigeons.jpg',
                  hotelname1: 'Pigeons Nest',
                  dateRange1: '07 Aug - 08 Aug',
                  guests1: '1 Guest',
                  address1: 'North SriLanka,\nNuwara Eliya',
                ),
                SizedBox(height: 20),
                // Dynamic Booking Container
                _buildDynamicBookingContainer(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String featureName, int index, StateSetter setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          featureName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Mycolor.ButtonColor,
          ),
        ),
        Row(
          children: [
            // Conditionally show "On" or "Off" based on the switch state
            Text(
              featureStates[index] ? 'On' : 'Off',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: featureStates[index]
                    ? Mycolor.ButtonColor
                    : Colors.grey, // Active color or grey
              ),
            ),
            SizedBox(width: 8), // Space between text and switch
            Switch(
              value: featureStates[index], // Use the state from the list
              onChanged: (value) {
                setState(() {
                  featureStates[index] =
                      value; // Update the toggle state in the list
                });
              },
              activeColor: Mycolor.ButtonColor, // Active switch color
              inactiveThumbColor: Colors.grey, // Inactive switch color
            ),
          ],
        ),
      ],
    );
  }
}
