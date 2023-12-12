import 'package:flutter/material.dart';
import '../style/colors.dart';
import '../navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class ConfirmBooking extends StatefulWidget {
  const ConfirmBooking({Key? key}) : super(key: key);

  @override
  _ConfirmBookingState createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  int _currentIndex = 0;
  Map bookingDetails = {};
  CollectionReference availableTrips =
      FirebaseFirestore.instance.collection('History');

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    bookingDetails = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Confirm Booking'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: AppColors.primaryColor,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'From ',
                            style: TextStyle(
                                color: AppColors.secondaryColor, fontSize: 24),
                          ),
                          Text(
                            '${bookingDetails['from']}',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.pin_drop,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'To ',
                            style: TextStyle(
                                color: AppColors.secondaryColor, fontSize: 24),
                          ),
                          Text(
                            '${bookingDetails['to']}',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Date ',
                            style: TextStyle(
                                color: AppColors.secondaryColor, fontSize: 24),
                          ),
                          Text(
                            '${bookingDetails['date']}',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Time ',
                            style: TextStyle(
                                color: AppColors.secondaryColor, fontSize: 24),
                          ),
                          Text(
                            '${bookingDetails['time']}',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Driver ',
                            style: TextStyle(
                              color: AppColors.secondaryColor,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            '${bookingDetails['driver']}',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 2),
                          Text(
                            '${bookingDetails['price'] + " EGP"}',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 8,
                          backgroundColor: AppColors.secondaryColor,
                        ),
                        onPressed: () {
                          // showToast(context);
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            borderSide:
                                BorderSide(color: Colors.green, width: 2),
                            buttonsBorderRadius:
                                BorderRadius.all(Radius.circular(2)),
                            headerAnimationLoop: false,
                            animType: AnimType.scale,
                            title: 'Booking Successfull !',
                            desc:
                                "Please track your ride's status in the activity tab",
                            btnOkOnPress: () async {
                              await FirebaseFirestore.instance
                                  .collection('History')
                                  .add({
                                'date': bookingDetails['date'],
                                'driverId': bookingDetails['driverId'],
                                'driverName': bookingDetails['driver'],
                                'from': bookingDetails['from'],
                                'riderId': _user!.uid,
                                'riderName': _user!.displayName,
                                'status': 'Pending',
                                'time': bookingDetails['time'],
                                'to': bookingDetails['to'],
                              });
                              DocumentReference tripRef = FirebaseFirestore
                                  .instance
                                  .collection('Trips')
                                  .doc(bookingDetails['tripId']);
                              await tripRef.update({
                                'pendingRiders':
                                    FieldValue.arrayUnion([_user!.uid]),
                                'pendingRidersNames':
                                    FieldValue.arrayUnion([_user!.displayName]),
                              });
                              Navigator.pop(context);
                            },
                          )..show();
                        },
                        child: Text(
                          'Confirm Booking',
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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

  void showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text('Booking successfull!'),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
