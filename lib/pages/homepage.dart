import 'package:flutter/material.dart';
import '../style/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  GoogleMapController? _controller;
  Set<Marker> _markers = Set<Marker>();

  @override
  Widget build(BuildContext context) {
    _markers.add(
      Marker(
        markerId: MarkerId('selected-location'),
        position: LatLng(30.06474820910293, 31.278861490545815),
        infoWindow: InfoWindow(title: 'Faculty of Engineering ASU'),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          'Book Your Ride',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            height: MediaQuery.of(context).size.height * 1,
            child: GoogleMap(
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (controller) {
                setState(() {
                  _controller = controller;
                });
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(30.06474820910293, 31.278861490545815),
                zoom: 14,
              ),
            ),
          ),
          Positioned(
            top: 30.0,
            left: 16.0,
            right: 16.0,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.secondaryColor, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: ' From',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                // Additional UI elements can be added here
              ],
            ),
          ),
          Positioned(
            top: 85.0,
            left: 16.0,
            right: 16.0,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.secondaryColor, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: ' Where to?',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                // Additional UI elements can be added here
              ],
            ),
          ),
          Positioned(
              left: 16,
              top: 135,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors
                        .primaryColor, // Change the background color to red
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/availableBookings');
                  },
                  child: Text(
                    'Find A Trip',
                    style: TextStyle(color: AppColors.secondaryColor),
                  )))
        ],
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

  void _handleMapTap(LatLng latLng) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('selected-location'),
          position: latLng,
          infoWindow: InfoWindow(title: 'Selected Location'),
        ),
      );
    });
  }
}
