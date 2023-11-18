import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../style/colors.dart';
import '../components/availableBookingsCard.dart';
import '../navbar.dart';

class availableBookings extends StatefulWidget {
  const availableBookings({Key? key}) : super(key: key);

  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<availableBookings> {
  final List<Trip> trips = [
    Trip(
        from: 'Nasr City',
        to: 'Gate 3',
        time: '7:30 AM',
        price: '30 EGP',
        driver: 'Seif Ahmed',
        date: '21-11-2023'),
    Trip(
        from: 'Nasr City',
        to: 'Gate 3',
        time: '7:30 AM',
        price: '30 EGP',
        driver: 'Abdelrahman Gaber',
        date: '22-11-2023'),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          'Available Trips',
        ),
      ),
      body: ListView.builder(
        itemCount: trips.length,
        itemBuilder: (context, index) {
          return availableBookingsCard(
              date: trips[index].date,
              driver: trips[index].driver,
              from: trips[index].from,
              to: trips[index].to,
              time: trips[index].time,
              price: trips[index].price);
        },
      ),
      bottomNavigationBar: NavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class Trip {
  final String from;
  final String to;
  final String time;
  final String price;
  final String driver;
  final String date;

  Trip(
      {required this.date,
      required this.from,
      required this.driver,
      required this.to,
      required this.time,
      required this.price});
}
