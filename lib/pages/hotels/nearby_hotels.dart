import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sun_lunka_app/pages/customs/colors.dart';
import 'package:sun_lunka_app/pages/hotels/hotel_package_page.dart';

class NearbyHotel extends StatefulWidget {
  const NearbyHotel({super.key});

  @override
  State<NearbyHotel> createState() => _NearbyHotelState();
}

class _NearbyHotelState extends State<NearbyHotel> {
  late List<bool>
      isFavorited; // To track if the favorite icon is clicked for each hotel
  int myCurrentIndex = 0; // To track the current carousel index
  late List<int> carouselIndices;
  String? hotelImage = '';
  String? hotelName = '';
  @override
  void initState() {
    super.initState();
    // Initialize isFavorited for three hotels, defaulting to false
    isFavorited = List<bool>.filled(3, false);
    carouselIndices = List<int>.filled(3, 0);
  }

  String _getRatingByIndex(int index) {
    List<String> ratings = ['4.1', '4.8', '3.8']; // Add more ratings as needed
    if (index >= 0 && index < ratings.length) {
      return ratings[index];
    }
    return '0.0'; // Default rating if index is out of bounds
  }

  @override
  Widget build(BuildContext context) {
    // Storing hotel image and name
    Future<void> _storeHotelDetails(int index) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (index == 0) {
        await prefs.setString(
            'hotelImage', 'assets/images/cheRiz Boutique.jpg');
        await prefs.setString('hotelName', 'CheRiz Boutique');
        await prefs.setString('hotelUrl',
            'https://www.google.com/maps/place/The+CheRiz/@6.991897,80.7454584,17z/data=!4m9!3m8!1s0x3ae381dcbeb54d23:0xf2ad26486bf64fd!5m2!4m1!1i2!8m2!3d6.991897!4d80.7480333!16s%2Fg%2F11fxw1pxb5?entry=ttu&g_ep=EgoyMDI0MTAxNi4wIKXMDSoASAFQAw%3D%3D');
      } else if (index == 1) {
        await prefs.setString('hotelImage', 'assets/images/Araliya.jpg');
        await prefs.setString('hotelName', 'Hotel Araliya Red');
        await prefs.setString('hotelUrl',
            'https://www.google.com/maps/search/araliya+red/@6.9626177,80.7610808,16.75z?entry=ttu&g_ep=EgoyMDI0MTAxNi4wIKXMDSoASAFQAw%3D%3D');
      } else if (index == 2) {
        await prefs.setString('hotelImage', 'assets/images/Aradhya.jpg');
        await prefs.setString('hotelName', 'Hotel Aaradhya');
        await prefs.setString('hotelUrl',
            'https://www.google.com/maps/place/Aaradhya+Nuwaraeliya/@6.9531069,80.7724259,17z/data=!4m9!3m8!1s0x3ae381c5ddd7fd89:0x41ba7998d6aedf31!5m2!4m1!1i2!8m2!3d6.9531069!4d80.7750008!16s%2Fg%2F11vc2v5pwm?entry=ttu&g_ep=EgoyMDI0MTAxNi4wIKXMDSoASAFQAw%3D%3D');
      }

      // Debugging purpose: print the stored values
      print('Stored Hotel Image: ${prefs.getString('hotelImage')}');
      print('Stored Hotel Name: ${prefs.getString('hotelName')}');
      print('Stored Hotel Url: ${prefs.getString('hotelUrl')}');
    }

    Future<void> _loadHotelDetails() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      hotelImage = prefs.getString('hotelImage');
      hotelName = prefs.getString('hotelName');

      print('Loaded Hotel Image:---------------------------- $hotelImage');
      print('Loaded Hotel Name:--------------------------- $hotelName');
    }

    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;

    final myitems1 = [
      ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset('assets/images/cheRiz Boutique.jpg',
            width: sw * 0.9, fit: BoxFit.cover),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset('assets/images/slider2.jpeg',
            width: sw * 0.9, fit: BoxFit.cover),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset('assets/images/slider3.jpg',
            width: sw * 0.9, fit: BoxFit.cover),
      ),
    ];

    final myitems2 = [
      ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset('assets/images/Araliya.jpg',
            width: sw * 0.9, fit: BoxFit.cover),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset('assets/images/Kanakabhishegam hotel.jpg',
            width: sw * 0.9, fit: BoxFit.cover),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset('assets/images/kanakabhishegam hotelfront-view.jpg',
            width: sw * 0.9, fit: BoxFit.cover),
      ),
    ];

    final myitems3 = [
      ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset('assets/images/Aradhya.jpg',
            width: sw * 0.9, fit: BoxFit.cover),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset('assets/images/sadhabishegam1.jpg',
            width: sw * 0.9, fit: BoxFit.cover),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset('assets/images/sadhabishegam 3.jpg',
            width: sw * 0.9, fit: BoxFit.cover),
      ),
    ];

    Widget buildHotelSection(
        List<Widget> items,
        String hotelName,
        String location,
        String price,
        String details1,
        String details2,
        int index) {
      return Stack(
        children: [
          Container(
            height: sh * 0.5,
            width: sw * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: sh * 0.25,
                    autoPlayInterval: const Duration(seconds: 5),
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    onPageChanged: (i, reason) {
                      setState(() {
                        carouselIndices[index] =
                            i; // Update index for the carousel
                      });
                    },
                  ),
                  items: items,
                ),

                SizedBox(height: 16),

                // Smooth Page Indicator
                AnimatedSmoothIndicator(
                  activeIndex: carouselIndices[index], // Use individual index
                  count: items.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 12,
                    spacing: 5,
                    dotColor: const Color.fromARGB(255, 172, 171, 171),
                    activeDotColor: Mycolor.ButtonColor,
                    paintStyle: PaintingStyle.fill,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            hotelName,
                            style: TextStyle(
                              fontSize: sw * 0.048,
                              fontWeight: FontWeight.bold,
                              color: Mycolor.ButtonColor,
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
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
                                    size: sw * 0.055,
                                  ),
                                  Text(
                                    _getRatingByIndex(index),
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
                      Row(
                        children: [
                          Text(
                            location,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: sw * 0.031,
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: sh * 0.058,
                            width: sw * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Mycolor.ButtonColor,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    price,
                                    style: TextStyle(
                                      fontSize: sw * 0.055,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 255, 251, 0),
                                    ),
                                  ),
                                  Text(
                                    '+ Tax fees',
                                    style: TextStyle(
                                      fontSize: sw * 0.03,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Restaurant',
                        style: TextStyle(
                          fontSize: sw * 0.04,
                          color: const Color.fromARGB(255, 114, 113, 113),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Align column items to the start
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 8,
                                    width: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Mycolor.ButtonColor,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    details1,
                                    style: TextStyle(
                                      fontSize: sw * 0.035,
                                      fontWeight: FontWeight.bold,
                                      color: Mycolor.ButtonColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 8,
                                    width: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Mycolor.ButtonColor,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    details2,
                                    style: TextStyle(
                                      fontSize: sw * 0.035,
                                      fontWeight: FontWeight.bold,
                                      color: Mycolor.ButtonColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () async {
                              _loadHotelDetails();
                              await _storeHotelDetails(
                                  index); // Store hotel details in SharedPreferences

                              //  Navigate to different pages based on the index
                              if (index == 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HotelPackages(), // First page
                                  ),
                                );
                              } else if (index == 1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HotelPackages(), // Second page
                                  ),
                                );
                              } else if (index == 2) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HotelPackages(), // Third page
                                  ),
                                );
                              }
                            },
                            child: Container(
                              height: sw * 0.1,
                              width: sw * 0.1,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color.fromARGB(255, 214, 27, 13),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: sw * 0.07,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Favorite Icon
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isFavorited[index] = !isFavorited[
                      index]; // Toggle the favorite status for this hotel
                });
              },
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    isFavorited[index] ? Icons.favorite : Icons.favorite_border,
                    color: isFavorited[index] ? Colors.red : Colors.grey,
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

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
              'Hotels Nearby Nuwara Eliya',
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
      body: SingleChildScrollView(
        child: Container(
          width: sw,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: sh * 0.05),
              buildHotelSection(
                myitems1,
                'CheRiz Boutique',
                '9/36 Unique View Road,\n222000 Nuwara Eliya,SriLanka',
                '₹ 5,500',
                'Cancellation free',
                'Breakfast included',
                0, // Index for first hotel
              ),
              SizedBox(height: 30),
              buildHotelSection(
                myitems2,
                'Araliya Red',
                '2B,1 Yalta Estate,Abepura\n222000 Nuwara Eliya,SriLanka',
                '₹ 6,500',
                'Cancellation free',
                'Breakfast included',
                1, // Index for second hotel
              ),
              SizedBox(height: 30),
              buildHotelSection(
                myitems3,
                'Hotel Aaradhya',
                '9/36 Unique View Road,\n222000 Nuwara Eliya,SriLanka',
                '₹ 3,500',
                'Cancellation free',
                'Breakfast included',
                2, // Index for third hotel
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
