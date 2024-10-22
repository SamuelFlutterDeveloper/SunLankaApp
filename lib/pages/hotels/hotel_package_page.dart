import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sun_lunka_app/pages/customs/colors.dart';
import 'package:sun_lunka_app/pages/hotels/hotel_details_page.dart';

class HotelPackages extends StatefulWidget {
  const HotelPackages({super.key});

  @override
  State<HotelPackages> createState() => _HotelPackagesState();
}

class _HotelPackagesState extends State<HotelPackages> {
  String hotelName = '';

  @override
  void initState() {
    super.initState();
    _loadBookingDetails();
  }

  Future<void> _loadBookingDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      hotelName = prefs.getString('hotelName')!;
    });

    print('$hotelName--------------------------------');
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
              'Hotel Packages',
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
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: sw * 0.05), // Responsive horizontal padding
            child: Column(
              children: [
                SizedBox(height: sh * 0.03), // Responsive height
                Text(
                  'Luxury Packages',
                  style: TextStyle(
                    fontSize: sw * 0.06,
                    color: Mycolor.ButtonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: sh * 0.02),

                // Platinum Package
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HotelDetails()),
                    );
                  },
                  child: buildPackageContainer(
                    context,
                    sh,
                    sw,
                    'assets/images/Slide-2.jpg', // Change image asset
                    'Platinum Package',
                    '$hotelName,Nuwara Eliya',
                    'assets/images/diamond.png', // Change asset if needed
                  ),
                ),
                SizedBox(height: sh * 0.02),

                // Gold Package
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HotelDetails()),
                    );
                  },
                  child: buildPackageContainer(
                    context,
                    sh,
                    sw,
                    'assets/images/goldpackage.jpeg', // Change image asset
                    'Gold Package',
                    '$hotelName,Nuwara Eliya',
                    'assets/images/gold3.png', // Change asset for gold package
                  ),
                ),
                SizedBox(height: sh * 0.02),

                // Silver Package
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HotelDetails()),
                    );
                  },
                  child: buildPackageContainer(
                    context,
                    sh,
                    sw,
                    'assets/images/silverpackage.jpeg', // Change image asset
                    'Silver Package',
                    '$hotelName,Nuwara Eliya',
                    'assets/images/silver-2.png', // Change asset for silver package
                  ),
                ),
                SizedBox(height: sh * 0.03),

                Text(
                  'Normal Packages',
                  style: TextStyle(
                    fontSize: sw * 0.06,
                    color: Mycolor.ButtonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: sh * 0.02),

                // Stack for Image and Black Overlay
                buildNormalPackageStack(context, sh, sw),

                SizedBox(height: sh * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // A reusable widget for creating packages
  Widget buildPackageContainer(
    BuildContext context,
    double sh,
    double sw,
    String imagePath,
    String packageName,
    String hotelLocation,
    String iconPath,
  ) {
    return Stack(
      children: [
        // Image Container
        Container(
          height: sh * 0.23,
          width: sw * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Black Container at the bottom of the image
        Positioned(
          bottom: 0,
          child: Container(
            height: sh * 0.08,
            width: sw * 0.9,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      // Icon Container
                      Container(
                        height: sw * 0.12,
                        width: sw * 0.12,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(iconPath),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: sw * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            packageName,
                            style: TextStyle(
                              fontSize: sw * 0.05,
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            hotelLocation,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: sw * 0.035,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),

                      Column(
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
                                color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNormalPackageStack(BuildContext context, double sh, double sw) {
    return Stack(
      children: [
        // Image Container
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HotelDetails()),
            );
          },
          child: Container(
            height: sh * 0.23,
            width: sw * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: AssetImage('assets/images/common.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // Black Container at the bottom of the image
        Positioned(
          bottom: 0,
          child: Container(
            height: sh * 0.08,
            width: sw * 0.9,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6), // Black with opacity
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Normal Package',
                          style: TextStyle(
                            fontSize: sw * 0.05,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$hotelName,Nuwara Eliya',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: sw * 0.035,
                          ),
                        ),
                      ],
                    ),
                    // Add the Row for stars here
                    Column(
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
                              color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
