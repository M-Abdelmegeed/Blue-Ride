import 'package:flutter/material.dart';
import '../style/colors.dart';
import '../navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  Map<String, dynamic> userDocument = {};

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  Future<Map<String, dynamic>?> getUserProfileData(String uid) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      DocumentSnapshot userDocument = await users.doc(uid).get();
      if (userDocument.exists) {
        return userDocument.data() as Map<String, dynamic>;
      } else {
        print('User profile data not found for UID: $uid');
        return null;
      }
    } catch (e) {
      print('Error retrieving user profile data: $e');
      return null;
    }
  }

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
                    backgroundColor: AppColors.secondaryColor,
                    radius: 50,
                    child: Icon(
                      Icons.person, // Replace with the desired icon
                      size: 85,
                      color:
                          Colors.white, // Replace with the desired icon color
                    )),
                SizedBox(height: 16),
                Text(
                  '${_user!.displayName}',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: AppColors.textColor),
                ),
                SizedBox(height: 8),
                Text(
                  '${_user!.email}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: AppColors.textColor),
                ),
                SizedBox(height: 8),
                Text(
                  // '${userDocument['phoneNumber']}',
                  'Test',
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
                  onPressed: () async {
                    // SQL Query to remove the user from the local db
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(context, '/login');
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
