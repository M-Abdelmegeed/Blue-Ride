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
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Profile'),
      ),
      body: Center(
        child: Card(
          shadowColor: Colors.black,
          color: AppColors.primaryColorLight,
          child: Container(
            width: 300,
            height: 450, // Adjust the width as needed
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.secondaryColor, width: 2),
              // color: AppColors
              //     .backgroundCardColor, // Set the desired background color
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50, // Adjust the radius as needed
                  backgroundImage: AssetImage(
                      'images/Abdelmegeed.jpeg'), // Replace with your user icon
                ),
                SizedBox(height: 16),
                Text(
                  'Mohammed Abdelmegeed',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: AppColors.textColor),
                ),
                SizedBox(height: 8),
                Text(
                  '19P1298@eng.asu.edu.eg',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: AppColors.textColor),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      // shadowColor: AppColors.secondaryColor,
                      backgroundColor:
                          AppColors.backgroundCardColor, // Background color
                      foregroundColor: Colors.white, // Text color
                      padding: EdgeInsets.all(16), // Padding
                      elevation: 5, // Elevation
                      minimumSize: Size(200, 10)),
                  onPressed: () {
                    // Implement sign-out logic
                  },
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
