import 'package:flutter/material.dart';
import '../style/colors.dart';
import '../navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../sqlite/sqflite.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  LocalDatabase mydb = LocalDatabase();
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  List<Map> userDocuments = [];

  Future Reading_Database() async {
    List<Map> response =
        await mydb.read(''' SELECT * FROM 'PASSENGERS' LIMIT 1 ''');
    userDocuments = [];
    userDocuments.addAll(response);
    print("User Document:");
    print("User Name:" + userDocuments[0]["NAME"]);
    // setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    Reading_Database().then((_) {
      setState(() {
        isLoading = false;
      });
    });
    mydb.checkdata();
  }

  bool isLoading = true;
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Profile'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Card(
                shadowColor: Colors.black,
                color: AppColors.primaryColorLight,
                child: Container(
                  width: 300,
                  height: 450, // Adjust the width as needed
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: AppColors.secondaryColor, width: 2),
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
                            color: Colors
                                .white, // Replace with the desired icon color
                          )),
                      SizedBox(height: 16),
                      Text(
                        // '${_user!.displayName}',
                        '${userDocuments[0]["NAME"]}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: AppColors.textColor),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${userDocuments[0]["EMAIL"]}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: AppColors.textColor),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${userDocuments[0]["PHONENUMBER"]}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: AppColors.textColor),
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors
                                .backgroundCardColor, // Background color
                            foregroundColor: Colors.white, // Text color
                            padding: EdgeInsets.all(16), // Padding
                            elevation: 5, // Elevation
                            minimumSize: Size(200, 10)),
                        onPressed: () async {
                          await mydb.delete(''' DELETE FROM 'PASSENGERS' ''');
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
