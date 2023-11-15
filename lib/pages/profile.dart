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
      body: Center(
        child: Container(
          width: 300,
          height: 450, // Adjust the width as needed
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            color: AppColors
                .backgroundCardColor, // Set the desired background color
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '19P1298@eng.asu.edu.eg',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red, // Background color
                    foregroundColor: Colors.white, // Text color
                    padding: EdgeInsets.all(16), // Padding
                    elevation: 5, // Elevation
                    minimumSize: Size(200, 10)),
                onPressed: () {
                  // Implement sign-out logic
                },
                child: Text('Sign Out'),
              ),
            ],
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
