import 'package:flutter/material.dart';
import '../style/colors.dart';
import '../navbar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _currentIndex = 3;

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
        child: Text("Profile Page"),
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
