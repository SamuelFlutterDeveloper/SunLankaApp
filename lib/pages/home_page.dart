import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sun_lunka_app/pages/checkin_checkout.dart';
import 'package:sun_lunka_app/pages/customs/colors.dart';
import 'package:sun_lunka_app/pages/hotel_packages.dart/northsrilanka_tourpackage.dart';
import 'package:sun_lunka_app/pages/hotel_packages.dart/southsrilanka_tourpackage.dart';
import 'package:sun_lunka_app/pages/hotel_packages.dart/temple_tourpackage.dart';
import 'package:sun_lunka_app/pages/login_page.dart';
import 'package:unicons/unicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _usernameController = TextEditingController();
  String address1 = '';
  int myCurrentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadUsername(); // Load username from SharedPreferences
    _loadLocationData(); // Load location from SharedPreferences

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool dialogShown = await _isDialogShown();
      if (!dialogShown) {
        _showDialog(); // Show the dialog only if it hasn't been shown yet
      }
    });
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');
    if (storedUsername != null) {
      setState(() {
        _usernameController.text = storedUsername;
      });
    }
  }

  Future<void> _loadLocationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      address1 = prefs.getString('address') ?? 'No location available';
    });
    print('address1---------------------->$address1');
  }

  // Method to show the dialog
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _buildCustomDialog(context);
      },
    );
  }

  Widget _buildCustomDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  _setDialogShown(); // Mark the dialog as shown
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Mycolor.ButtonColor, // Change to your color
                  ),
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Row with Image and Discount Text
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/Nuwara Eliya.jpg'),
                  radius: 30,
                ),
                SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '%DISCOUNT',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Description Text
            Center(
              child: Text(
                'A Welcome Treat For You',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            SizedBox(height: 5),
            Center(
              child: Text(
                'UPTO 30% OFF*',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'On Booking Your 1st flight, stay, holiday\nCab & More, with us.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            SizedBox(height: 16),
            // Grab the Offer Button
            GestureDetector(
              onTap: () {
                // Handle button press here
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Mycolor.ButtonColor, // Change to your button color
                  borderRadius: BorderRadius.circular(25),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Grab the Offer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Save the flag to SharedPreferences that the dialog has been shown
  void _setDialogShown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dialogShown', true); // Save the flag as true
  }

  // Check whether the dialog has already been shown
  Future<bool> _isDialogShown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('dialogShown') ?? false; // Default to false if not set
  }

  Widget buildImageWithText(String imagePath, String text) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: sh * 0.12,
          width: sw * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 122, 122, 122)
                      .withOpacity(0.3), // Bright shadow color
                  spreadRadius: 3, // Controls the size of the shadow
                  blurRadius: 10, // Controls the softness of the shadow
                  offset: Offset(0,
                      4), // Controls the position of the shadow (horizontal, vertical)
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Confirm Exit'),
            content: Text('Do you really want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), // Stay in app
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop(); // Exit the app
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;

    final cities = [
      {'name': 'Nuwara Eliya', 'image': 'assets/images/Nuwara Eliya.jpg'},
      {'name': 'Kandy', 'image': 'assets/images/Kandy.jpg'},
      {'name': 'Colobo', 'image': 'assets/images/Colombo.jpg'},
      {'name': 'Galle', 'image': 'assets/images/Galle.jpg'},
      {'name': 'Dambulla', 'image': 'assets/images/Dambulla.jpg'},
      {'name': 'Anuradhapura', 'image': 'assets/images/Anuradhapura.jpg'},
      {'name': 'Batticoloa', 'image': 'assets/images/Batticoloa.jpg'},
      {'name': 'Jaffna', 'image': 'assets/images/Jaffna.jpg'},
      {'name': 'Sigiriya', 'image': 'assets/images/SIGIRIYA.jpg'},
    ];
    // int myCurrentIndex = 0;

    final List<Map<String, String>> myItems = [
      {
        'image': 'assets/images/north srilanka.jpg',
        'title': 'North SriLanka Tour Package',
      },
      {
        'image': 'assets/images/south sri-lanka-.jpg',
        'title': 'South SriLanka Tour Package',
      },
      {
        'image': 'assets/images/temple.jpg',
        'title': 'Temple Tour Package',
      }
    ];
    void _showCityList() {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 10),
                // Drag indicator
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 20),

                Expanded(
                  child: ListView.builder(
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      final city = cities[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              child: Row(
                                children: [
                                  // City Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      city['image']!,
                                      width: 65,
                                      height: 65,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  // City Name
                                  Text(
                                    city['name']!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            // Define the drawer here
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                ListTile(
                  title: Container(
                    height: sh * 0.09,
                    width: sw * 0.2,
                    decoration: BoxDecoration(
                        color: Mycolor.ButtonColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                "Hi ${_usernameController.text}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Text(
                              "Business Profile",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    // Handle item tap
                  },
                ),
                SizedBox(
                  height: sh * 0.02,
                ),
                ListTile(
                  title: Container(
                    height: 140,
                    width: sw * 0.2,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors
                              .grey.shade300, // Set the border color to black
                          width:
                              2.0, // Set the border width as per your preference
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Mycolor.ButtonColor,
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 35,
                                )),
                              ),
                              Text(
                                'Account',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Mycolor.ButtonColor,
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                  size: 35,
                                )),
                              ),
                              Text(
                                'Notification',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    // Handle item tap
                  },
                ),
                ListTile(
                  title: Container(
                    height: sh * 0.45,
                    width: sw * 0.2,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors
                              .grey.shade300, // Set the border color to black
                          width:
                              2.0, // Set the border width as per your preference
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.favorite_border,
                                size: 25,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Wishlist",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.card_giftcard,
                                size: 25,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Gift Cards",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                UniconsLine.trophy,
                                size: 25,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Rewards",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.supervisor_account_rounded,
                                size: 25,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Referral",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.settings,
                                size: 25,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Settings",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.clear();

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()),
                                      (route) => false);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Logout",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: sh *
                            0.32, // You can keep this height or adjust it based on design
                        child: Padding(
                          padding: EdgeInsets.only(bottom: sh * 0.05),
                          child: CarouselSlider.builder(
                            itemCount: myItems.length,
                            options: CarouselOptions(
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 5),
                              height: sh * 0.27,
                              viewportFraction: 1,
                              enlargeCenterPage: true,
                              aspectRatio: 16 / 9, // Responsive aspect ratio
                              onPageChanged: (index, reason) {
                                setState(() {
                                  myCurrentIndex =
                                      index; // Update current index
                                });
                              },
                            ),
                            itemBuilder: (context, index, realIndex) {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(35),
                                    bottomRight: Radius.circular(35),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(myItems[index]['image']!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        height:
                                            sh * 0.18), // Space above the text
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  myItems[index]['title']!,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  'Now available for booking',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.amber,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                              width:
                                                  10), // Add space between text and button
                                          GestureDetector(
                                            onTap: () {
                                              if (index == 0) {
                                                print(
                                                    '1===========-------------');
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            NorthsrilankaTourpackage()));
                                              } else if (index == 1) {
                                                print(
                                                    '2===========-------------');
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SouthsrilankaTourpackage()));
                                              } else if (index == 2) {
                                                print(
                                                    '3===========-------------');
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TempleTourpackage()));
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.amber,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.arrow_forward_rounded,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // Header Section
                      Positioned(
                        top: 10, // Position at the top of the carousel slider
                        left: 0,
                        right: 0,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                              child: Container(
                                height: 50,
                                width: 60,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 211, 207, 207),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.menu,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: sw * 0.05), // Responsive spacing
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _usernameController.text,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Mycolor.TextColor1,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Color.fromARGB(255, 212, 18, 4),
                                      size: 20,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      address1.isNotEmpty
                                          ? address1
                                          : 'No location available',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              height: 50,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 211, 207, 207),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Indicator Section
                      Positioned(
                        bottom: 20, // Position below the carousel
                        left: 0,
                        right: 0,
                        child: Center(
                          child: AnimatedSmoothIndicator(
                            activeIndex:
                                myCurrentIndex, // Current index of the carousel
                            count: myItems.length,
                            effect: ExpandingDotsEffect(
                              dotHeight: 8,
                              dotWidth: 12,
                              spacing: 5,
                              dotColor:
                                  const Color.fromARGB(255, 172, 171, 171),
                              activeDotColor: Mycolor.ButtonColor,
                              paintStyle: PaintingStyle.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: sw * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Pick Youe Cities',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Mycolor.ButtonColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: sh * 0.01),
                  Container(
                    height: sh * 0.27,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 8),
                      child: Column(
                        children: [
                          // First row with 5 cities
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: cities.take(5).map((city) {
                              return buildCityItem(city, sw);
                            }).toList(),
                          ),
                          SizedBox(height: 20), // Space between rows
                          // Second row with 4 cities and "See All"
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ...cities.skip(5).take(4).map((city) {
                                return buildCityItem(city, sw);
                              }).toList(),
                              // The "See All" item
                              GestureDetector(
                                onTap: () {
                                  _showCityList();
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: sw * 0.15,
                                      height: sw * 0.15,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Mycolor.ButtonColor,
                                            width: 2),
                                        color: Colors.grey.shade800,
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'See all',
                                      style: TextStyle(
                                        fontSize: 14,
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
                  SizedBox(height: sh * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: sw * 0.04),
                        child: Text(
                          "Recent Searches",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Mycolor.ButtonColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: sw * 0.05),
                        child: Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: sh * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildImageWithText('assets/images/winchester.jpg',
                          'Winchester Little England\nNuwara Eliya'),
                      buildImageWithText('assets/images/pigeons.jpg',
                          'Pigeons Nest\nNuwara Eliya'),
                      buildImageWithText('assets/images/melford.jpg',
                          'Melford Nuwaraeliya\nNuwara Eliya'),
                    ],
                  ),
                  SizedBox(height: sh * 0.03),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Hotel Nearby Nuwara Eliya",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Mycolor.ButtonColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "See All",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: sh * 0.02),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Hotel Item 1
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CheckIn()),
                                        );
                                      },
                                      child: Container(
                                        width: sw * 0.3,
                                        height: sh * 0.2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/images/royal.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Royal Pearl Hills\nNuwara Eliya',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CheckIn()),
                                        );
                                      },
                                      child: Container(
                                        width: sw * 0.3,
                                        height: sh * 0.2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/images/cheRiz Boutique.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'CheRiz Boutique\nNuwara Eliya',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              // Hotel Item 2
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CheckIn()),
                                        );
                                      },
                                      child: Container(
                                        width: sw * 0.3,
                                        height: sh * 0.2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/images/Araliya.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Araliya Red\nNuwara Eliya',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              // Hotel Item 3
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CheckIn()),
                                        );
                                      },
                                      child: Container(
                                        width: sw * 0.3,
                                        height: sh * 0.2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/images/Aradhya.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Aaradhya\nNuwara Eliya',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CheckIn()),
                                        );
                                      },
                                      child: Container(
                                        width: sw * 0.3,
                                        height: sh * 0.2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/images/Heritage Grand (2).jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      ' Heritage Grand\nNuwara Eliya',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: sh * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: sw * 0.04),
                        child: Text(
                          "Luxury Hotels Packages",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Mycolor.ButtonColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: sh * 0.02),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CheckIn()));
                    },
                    child: Container(
                      height: sh * 0.2,
                      width: sw * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/golden ridge.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  8.0), // Padding around the Row
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Column for text
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'The Golden Ridge Hotel', // Replace with your desired text
                                          style: TextStyle(
                                            color: Colors.white, // Text color
                                            fontSize: 18, // Text size
                                            fontWeight:
                                                FontWeight.bold, // Text weight
                                          ),
                                        ),
                                        Text(
                                            "No, 395, Bambarakella,NuwaraEliya,22200\nNuwara Eliya, SriLanka",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ))
                                        // Add more Text widgets here if needed
                                      ],
                                    ),
                                  ),
                                  // Row for star icons
                                  Row(
                                    children: List.generate(
                                      5,
                                      (index) => Icon(
                                        Icons.star,
                                        color: const Color.fromARGB(
                                            255, 233, 211, 16), // Star color
                                        size: 18, // Adjust star size as needed
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: sh * 0.04),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCityItem(Map<String, String> city, double sw) {
    // Check if the city is "Nuwara Eliya"
    bool isNuwaraEliya = city['name'] == 'Nuwara Eliya';

    return Column(
      children: [
        Stack(
          children: [
            // City image container
            Container(
              width: sw * 0.15,
              height: sw * 0.15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Mycolor.ButtonColor, width: 2),
                image: DecorationImage(
                  image: AssetImage(city['image']!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Overlay for all cities except Nuwara Eliya
            if (!isNuwaraEliya)
              Container(
                width: sw * 0.15,
                height: sw * 0.15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.65),
                ),
              ),
          ],
        ),
        SizedBox(height: 5),
        Text(
          city['name']!,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            // Nuwara Eliya has the button color, others are displayed normally
            color: isNuwaraEliya ? Mycolor.ButtonColor : Colors.black,
          ),
        ),
      ],
    );
  }
}
