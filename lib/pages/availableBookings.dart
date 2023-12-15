import 'package:flutter/material.dart';
import '../components/availableBookingsCard.dart';
import '../navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class availableBookings extends StatefulWidget {
  const availableBookings({Key? key}) : super(key: key);

  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<availableBookings> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  BehaviorSubject<QuerySnapshot> _streamController =
      BehaviorSubject<QuerySnapshot>();
  Map<String, dynamic>? searchData;

  // @override
  // void initState() {
  //   super.initState();
  //   _user = _auth.currentUser;
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    searchData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _user = _auth.currentUser;
    _initializeStream(searchData!["From"], searchData!["To"]);
  }

  @override
  void dispose() {
    super.dispose();
    // _streamController.close();
  }

  void _initializeStream(String from, String to) {
    String currentDate = DateTime.now().toLocal().toString().split(' ')[0];
    print(currentDate);
    Stream<QuerySnapshot> query1 = FirebaseFirestore.instance
        .collection('Trips')
        .where('from', isEqualTo: from)
        .where('to', isEqualTo: to)
        // .where('date', isGreaterThanOrEqualTo: currentDate)
        .snapshots();

    Stream<QuerySnapshot> query2 = FirebaseFirestore.instance
        .collection('Trips')
        .where('from', isEqualTo: from)
        .where('stops', arrayContains: to)
        // .where('date', isGreaterThanOrEqualTo: currentDate)
        .snapshots();

    var combinedStream = query1.mergeWith([query2]);
    print("Combined Stream");
    print(combinedStream.toString());

    _streamController.addStream(combinedStream);
  }

  CollectionReference availableTrips =
      FirebaseFirestore.instance.collection('Trips');
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Available Trips',
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.data!.docs.length == 0) {
              return Center(
                child: Text(
                  "Sorry, there are no trips :(",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w300),
                ),
              );
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var availableTripsData =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  print(availableTripsData);
                  List<String> pendingRiders = List<String>.from(
                      availableTripsData['pendingRiders'] ?? []);
                  List<String> acceptedRiders = List<String>.from(
                      availableTripsData['acceptedRiders'] ?? []);

                  bool isUserPending = pendingRiders.contains(_user?.uid);
                  bool isUserAccepted = acceptedRiders.contains(_user?.uid);
                  // print("User Pending?????" + isUserPending.toString());
                  if (snapshot.data!.docs.length == 0) {
                    return Center(
                      child: Text('Sorry, no trips were found'),
                    );
                  }
                  return availableBookingsCard(
                    driverId: availableTripsData["driverId"],
                    tripId: snapshot.data!.docs[index].id,
                    date: availableTripsData["date"],
                    driver: availableTripsData["driverName"],
                    from: availableTripsData["from"],
                    to: availableTripsData["to"],
                    time: availableTripsData["time"],
                    price: availableTripsData["price"].toString(),
                    stops: availableTripsData["stops"].join(" - "),
                    isUserPending: isUserPending,
                    isUserAccepted: isUserAccepted,
                  );
                });
          }),
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
