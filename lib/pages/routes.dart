import 'package:flutter/material.dart';
import '../components/routesCard.dart';
import '../navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference firebaseRoutes =
      FirebaseFirestore.instance.collection('Routes');

  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Available Routes',
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseRoutes.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var routeData =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: CustomCard(
                    from: routeData["from"],
                    to: routeData["to"],
                    time: routeData["time"],
                    price: routeData["priceRange"].join('-').toString(),
                    stops: routeData["stops"],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator());
          }
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

class Route {
  final List stops;
  final String from;
  final String to;
  final String time;
  final String price;

  Route(
      {required this.stops,
      required this.from,
      required this.to,
      required this.time,
      required this.price});
}
