import 'package:flutter/material.dart';
import '../style/colors.dart';
import '../navbar.dart';

class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // backgroundColor: AppColors.primaryColor,
      //   title: Text(
      //     'Book A Ride',
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      body: Center(
        child: Text("Routes Page"),
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
