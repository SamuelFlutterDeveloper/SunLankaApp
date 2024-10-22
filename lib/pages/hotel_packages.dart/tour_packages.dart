import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sun_lunka_app/pages/customs/colors.dart';
import 'package:sun_lunka_app/pages/hotel_packages.dart/northsrilanka_tourpackage.dart';
import 'package:sun_lunka_app/pages/hotel_packages.dart/southsrilanka_tourpackage.dart';
import 'package:sun_lunka_app/pages/hotel_packages.dart/temple_tourpackage.dart';

class TourPackages extends StatefulWidget {
  const TourPackages({super.key});

  @override
  State<TourPackages> createState() => _HotelPackageState();
}

class _HotelPackageState extends State<TourPackages> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
              'Tour Packages',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NorthsrilankaTourpackage()));
                  },
                  child: _buildImageContainer(
                      screenWidth,
                      screenHeight,
                      'assets/images/north srilanka.jpg',
                      'North SriLanka Tour Package',
                      'assets/images/limited.png'), // Overlay image for North Sri Lanka
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SouthsrilankaTourpackage()));
                  },
                  child: _buildImageContainer(
                      screenWidth,
                      screenHeight,
                      'assets/images/south sri-lanka-.jpg',
                      'South SriLanka Tour Package',
                      'assets/images/offer.png'), // Overlay image for South Sri Lanka
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TempleTourpackage()));
                  },
                  child: _buildImageContainer(
                      screenWidth,
                      screenHeight,
                      'assets/images/temple.jpg',
                      'Temple Tour Package',
                      'assets/images/upto10.png'), // Overlay image for Temple Tour
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageContainer(double screenWidth, double screenHeight,
      String imagePath, String text, String overlayImage) {
    return Stack(
      clipBehavior: Clip.none, // Allows overflow of the overlay image
      children: [
        // Main image container
        Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  text,
                  style: GoogleFonts.dancingScript(
                    color: Mycolor.TextColor1,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 5,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Discount Upto 10% of Booking',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 5,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Overlay image positioned at the very top center
        Positioned(
          top: -75, // Puts the image higher up, adjusting for larger height
          left: (screenWidth * 0.9) / 2 -
              125, // Centers the image horizontally for width 250
          child: Image.asset(
            overlayImage,
            width: 250, // Updated width
            height: 170, // Updated height
          ),
        ),
      ],
    );
  }
}
