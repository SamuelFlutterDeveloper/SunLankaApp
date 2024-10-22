import 'package:flutter/material.dart';

import 'package:sun_lunka_app/pages/customs/colors.dart';
import 'package:sun_lunka_app/pages/hotels/nearby_hotels.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckIn extends StatefulWidget {
  const CheckIn({super.key});

  @override
  State<CheckIn> createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  DateTime? checkInDate;
  DateTime? checkOutDate;
  TimeOfDay? checkInTime;
  TimeOfDay? checkOutTime;
  List<DateTime> selectedDates = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/checkin bg.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 20, // Adjust as needed
              top: 40, // Adjust as needed
              child: GestureDetector(
                onTap: () {
                  // Handle back action
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Position of shadow
                          ),
                        ],
                      ),
                      child: TableCalendar(
                        firstDay:
                            DateTime.now().subtract(const Duration(days: 30)),
                        lastDay: checkOutDate != null
                            ? checkOutDate!.add(const Duration(days: 365))
                            : DateTime.now().add(const Duration(days: 365)),
                        focusedDay: DateTime.now(),
                        selectedDayPredicate: (day) {
                          return selectedDates.contains(day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          _onDaySelected(selectedDay);
                          if (checkInDate != null &&
                              checkOutDate != null &&
                              checkOutDate!.isBefore(checkInDate!)) {
                            // Show an error message if check-out date is before check-in date
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Check-out date must be after check-in date.')),
                            );
                          }
                        },
                        calendarStyle: CalendarStyle(
                          defaultDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                          todayDecoration: const BoxDecoration(
                            color: Color.fromARGB(255, 161, 0, 0),
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Mycolor.ButtonColor, // Selected day color
                            shape: BoxShape.circle,
                          ),
                          weekendDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                        ),
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                            color: Mycolor.ButtonColor, // Month title color
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        daysOfWeekStyle: const DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                            color: Colors.white, // Weekdays color (Mon to Fri)
                            fontWeight: FontWeight.bold,
                          ),
                          weekendStyle: TextStyle(
                            color: Colors.white, // Weekend color (Sat, Sun)
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: _buildDateSection(
                                  'Check-In Date', checkInDate, screenWidth),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _buildDateSection(
                                  'Check-Out Date', checkOutDate, screenWidth),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: _buildTimeSection('Check-In Time',
                                  checkInTime, true, screenWidth),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _buildTimeSection('Check-Out Time',
                                  checkOutTime, false, screenWidth),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  GestureDetector(
                    onTap: () async {
                      if (checkInDate == null ||
                          checkOutDate == null ||
                          checkInTime == null ||
                          checkOutTime == null) {
                        // Show a SnackBar if any field is not filled
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Please fill all the details: Date and Time'),
                            backgroundColor:
                                const Color.fromARGB(255, 194, 15, 15),
                          ),
                        );
                      } else {
                        await _saveDatesAndTimes();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NearbyHotel()),
                        );
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height *
                          0.07, // Responsive button height
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Mycolor.ButtonColor,
                      ),
                      child: Center(
                        child: Text(
                          'Done',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width *
                                0.07, // Responsive font size
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSection(String label, DateTime? date, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.05),
          child: Text(
            label,
            style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
                color: Mycolor.ButtonColor), // Responsive text size
          ),
        ),
        const SizedBox(height: 4.0),
        _buildDateContainer(date, screenWidth),
      ],
    );
  }

  Widget _buildTimeSection(
      String label, TimeOfDay? time, bool isCheckIn, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.05),
          child: Text(
            label,
            style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
                color: Mycolor.ButtonColor), // Responsive text size
          ),
        ),
        const SizedBox(height: 4.0),
        GestureDetector(
          onTap: () => _selectTime(isCheckIn), // Show time picker
          child: _buildTimeContainer(time, isCheckIn, screenWidth),
        ),
      ],
    );
  }

  Future<void> _selectTime(bool isCheckIn) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        if (isCheckIn) {
          checkInTime = pickedTime;
        } else {
          checkOutTime = pickedTime;
        }
      });
    }
  }

  Future<void> _saveDatesAndTimes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (checkInDate != null &&
        checkOutDate != null &&
        checkInTime != null &&
        checkOutTime != null) {
      // Format the date and time strings to include year
      String formattedCheckInDate =
          "${_getMonthAbbreviation(checkInDate!)} ${checkInDate!.day}, ${checkInDate!.year}"; // Include year
      String formattedCheckOutDate =
          "${_getMonthAbbreviation(checkOutDate!)} ${checkOutDate!.day}, ${checkOutDate!.year}"; // Include year
      String formattedCheckInTime =
          "${_getDayAbbreviation(checkInDate!)} ${checkInTime!.format(context)}";
      String formattedCheckOutTime =
          "${_getDayAbbreviation(checkOutDate!)} ${checkOutTime!.format(context)}";

      // Save the formatted values
      await prefs.setString('checkInDate', formattedCheckInDate);
      await prefs.setString('checkOutDate', formattedCheckOutDate);
      await prefs.setString('checkInTime', formattedCheckInTime);
      await prefs.setString('checkOutTime', formattedCheckOutTime);
    }
    print('$checkInDate,$checkInTime,$checkOutDate,$checkOutTime');
  }

  void _onDaySelected(DateTime selectedDay) {
    setState(() {
      if (selectedDates.contains(selectedDay)) {
        selectedDates.remove(selectedDay);
      } else {
        // Clear previously selected dates if a new check-in date is selected
        if (selectedDates.isEmpty ||
            selectedDay.isBefore(selectedDates.first)) {
          selectedDates = [selectedDay]; // Set selected day as check-in date
        } else {
          // If the selected day is after the check-in date, set it as check-out date
          selectedDates.add(selectedDay);
        }
      }
      selectedDates.sort();

      // Update check-in and check-out dates
      if (selectedDates.isNotEmpty) {
        checkInDate = selectedDates.first;
        checkOutDate = selectedDates.length > 1 ? selectedDates.last : null;
      } else {
        checkInDate = null;
        checkOutDate = null;
      }
    });
  }

  Widget _buildDateContainer(DateTime? date, double screenWidth) {
    return Container(
      height: 40,
      width: screenWidth * 0.4,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Mycolor.TextColor),
      ),
      child: Center(
        child: Text(
          date == null
              ? 'DD-MM-YYYY'
              : '${_getMonthAbbreviation(date)} ${date.day}, ${date.year}',
          style: TextStyle(
              fontSize: screenWidth * 0.035,
              color: Colors.black), // Responsive text size
        ),
      ),
    );
  }

  Widget _buildTimeContainer(
      TimeOfDay? time, bool isCheckIn, double screenWidth) {
    return Container(
      height: 40,
      width: screenWidth * 0.4,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Mycolor.TextColor),
      ),
      child: Center(
        child: Text(
          time == null ? 'Select Time' : time.format(context),
          style: TextStyle(
              fontSize: screenWidth * 0.035,
              color: Colors.black), // Responsive text size
        ),
      ),
    );
  }

  String _getMonthAbbreviation(DateTime date) {
    switch (date.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

  String _getDayAbbreviation(DateTime date) {
    switch (date.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
}
