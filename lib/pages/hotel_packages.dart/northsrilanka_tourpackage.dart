import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sun_lunka_app/pages/customs/colors.dart';
import 'package:sun_lunka_app/pages/hotel_packages.dart/northsrilanka_tourbooking.dart';

class NorthsrilankaTourpackage extends StatefulWidget {
  const NorthsrilankaTourpackage({super.key});

  @override
  State<NorthsrilankaTourpackage> createState() =>
      _NorthsrilankaTourpackageState();
}

class _NorthsrilankaTourpackageState extends State<NorthsrilankaTourpackage> {
  int myCurrentIndex = 0;
  List<bool> _isDetailsVisible = List.filled(6, true);

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;

    final myitems = [
      ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset('assets/images/north srilanka.jpg',
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

// Helper function to build the text rows
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
          SizedBox(width: sw * 0.04), // Space between label and value
          Text(
            value,
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      );
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
              'North SriLanka Tour Package',
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
                Text(
                  'North SriLanka Tour Packag',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Mycolor.ButtonColor),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(right: sw * 0.05),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: false,
                      height: sh * 0.22,
                      autoPlayInterval: const Duration(seconds: 5),
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      aspectRatio: 200,
                      onPageChanged: (index, reason) {
                        setState(() {
                          myCurrentIndex = index;
                        });
                      },
                    ),
                    items: myitems,
                  ),
                ),
                SizedBox(height: sh * 0.02),
                Align(
                  alignment: Alignment.center,
                  child: AnimatedSmoothIndicator(
                    activeIndex: myCurrentIndex,
                    count: myitems.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 12,
                      spacing: 5,
                      dotColor: const Color.fromARGB(255, 172, 171, 171),
                      activeDotColor: Mycolor.ButtonColor,
                      paintStyle: PaintingStyle.fill,
                    ),
                  ),
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
                    // Text(
                    //   'Food, Accomadation and transport Inclusive',
                    //   style: TextStyle(
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.bold,
                    //       color: Mycolor.ButtonColor),
                    // )
                  ],
                ),
                SizedBox(height: sh * 0.03),
                Text(
                  'Itinerary :',
                  style: TextStyle(
                    fontSize: 20,
                    color: Mycolor.ButtonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Experience the spiritual charm of Velankanni with visits to the iconic Basilica and beautiful beaches.Enjoy comfortable accommodationsandguided tours for an unforgettable journey!',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: sh * 0.02),
                // Day 1
                dayRow(
                    'Day 1',
                    0,
                    sh,
                    context,
                    '''
Once our travel agents pick you up and reach Velankanni, first we will check in at the hotel. After finishing check-in formalities, you can freshen up and take some rest.''',
                    'Visit the renowned Basilica of Our Lady of Good Health, where you’ll experience the spiritual ambiance and stunning architecture.',
                    'Relax at Velankanni Beach, enjoying the sun and local snacks while soaking in the beautiful coastal views.',
                    'Explore the Church Museum to learn about the rich history and significance of the Basilica.'),

                // Day 2
                dayRow(
                    'Day 2',
                    1,
                    sh,
                    context,
                    '''
Explore the sacred grounds of Our Lady's Tank, offering a serene atmosphere perfect for reflection amidst nature.''',
                    'Discover the serene Our Lady’s Tank, a perfect spot for reflection and tranquility amidst nature.',
                    'Enjoy a scenic excursion to Kuthira Malai, offering breathtaking panoramic views of the landscape.',
                    'Wander through local markets, where you can shop for souvenirs and savor delicious regional cuisine.'),

                // Day 3 - Add different details for North Sri Lanka Tour
                dayRow(
                    'Day 3',
                    2,
                    sh,
                    context,
                    '''
On Day 3, you will start your journey towards Jaffna, one of the northernmost points of Sri Lanka.''',
                    'Visit the historical Nallur Kandaswamy Temple, renowned for its unique Dravidian architecture.',
                    'Enjoy a boat ride to the famous Nagadeepa Island, home to an ancient Buddhist temple.',
                    'Explore the ancient Jaffna Fort, a stunning landmark showcasing Dutch architecture and history.'),

                // Day 4 - Add different details for North Sri Lanka Tour
                dayRow(
                    'Day 4',
                    3,
                    sh,
                    context,
                    '''
Day 4 begins with a trip to the Keerimalai Springs, known for their therapeutic qualities.''',
                    'Take a morning dip in the natural Keerimalai Springs, revered for their healing powers.',
                    'Spend the afternoon at Casuarina Beach, one of the most beautiful beaches in the northern region.',
                    'In the evening, visit the Jaffna Public Library, a place of historical and cultural importance.'),

                // Day 5 - Add different details for North Sri Lanka Tour
                dayRow(
                    'Day 5',
                    4,
                    sh,
                    context,
                    '''
Your day starts with a visit to the ancient city of Anuradhapura, a UNESCO World Heritage Site.''',
                    'Visit the sacred Bodhi Tree, believed to be a cutting from the original tree under which Buddha gained enlightenment.',
                    'Explore the magnificent ruins of the Ruwanwelisaya stupa, one of the largest stupas in Sri Lanka.',
                    'Visit the Isurumuniya temple, known for its stunning carvings and ancient history.'),

                // Day 6 - Add different details for North Sri Lanka Tour
                dayRow(
                    'Day 6',
                    5,
                    sh,
                    context,
                    '''
On your final day, you’ll relax and enjoy the coastal beauty of Mannar.''',
                    'Visit the ancient Baobab tree in Mannar, one of the largest and oldest in the country.',
                    'Enjoy a peaceful walk along the Adam’s Bridge, a historic and natural chain of limestone shoals.',
                    'End your tour with a visit to the Mannar Fort, showcasing the colonial history of Sri Lanka.'),

                SizedBox(height: sh * 0.03),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Space between widgets
                  children: [
                    Text(
                      'Total Package',
                      style: TextStyle(
                        fontSize: 20,
                        color: Mycolor.ButtonColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Spacer to push the container to the right
                    Spacer(),

                    // Total Package Container
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Mycolor.ButtonColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '₹ 99,999',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Mycolor.TextColor1,
                                ),
                              ),
                              Text(
                                '+GST',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NorthsrilankaTourbooking()));
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

  // Widget function for each day's layout
  Widget dayRow(
      String dayTitle,
      int dayIndex,
      double sh,
      BuildContext context,
      String introText,
      String morningDetails,
      String afternoonDetails,
      String eveningDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              dayTitle,
              style: TextStyle(
                fontSize: 20,
                color: Mycolor.ButtonColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            IconButton(
              icon: Icon(
                _isDetailsVisible[dayIndex]
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down,
                color: Mycolor.ButtonColor,
              ),
              onPressed: () {
                setState(() {
                  _isDetailsVisible[dayIndex] = !_isDetailsVisible[dayIndex];
                });
              },
            ),
          ],
        ),
        if (_isDetailsVisible[dayIndex]) ...[
          Text(
            introText,
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(height: sh * 0.01),
          Text(
            'Morning',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            morningDetails,
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(height: sh * 0.01),
          Text(
            'Afternoon',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            afternoonDetails,
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(height: sh * 0.01),
          Text(
            'Evening',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            eveningDetails,
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(height: sh * 0.04),
        ]
      ],
    );
  }
}
