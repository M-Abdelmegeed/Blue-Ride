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
  Set<Polyline> _polylines = Set<Polyline>();
  List<String> places = ['Nasr City', 'Heliopolis', 'Rehab', 'ASU'];
  Map<String, LatLng> placeLocations = {
    'Nasr City': LatLng(30.057018088095514, 31.329249227523302),
    'ASU': LatLng(30.06474820910293, 31.278861490545815)
  };
  String selectedFromValue = 'Nasr City';
  String selectedToValue = 'ASU';

  @override
  Widget build(BuildContext context) {
    // _markers.add(
    //   Marker(
    //     markerId: MarkerId('selected-location'),
    //     position: LatLng(30.06474820910293, 31.278861490545815),
    //     infoWindow: InfoWindow(title: 'Faculty of Engineering ASU'),
    //   ),
    // );
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
              // polylines: _polylines,
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
                  width: 350,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.secondaryColor, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: DropdownButton<String>(
                      icon: Icon(
                        Icons.location_pin,
                        size: 0,
                      ),
                      underline: Text(''),
                      hint: Text('  From'),
                      value: selectedFromValue,
                      onChanged: (value) {
                        setState(() {
                          selectedFromValue = value.toString();
                          _handleInputChange(selectedFromValue,
                              selectedToValue); // Update the selected value here
                        });
                      },
                      items: places.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
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
                  width: 350,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.secondaryColor, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: DropdownButton<String>(
                      icon: Icon(
                        Icons.location_pin,
                        size: 0,
                      ),
                      underline: Text(''),
                      hint: Text('  Where to..?'),
                      value: selectedToValue,
                      onChanged: (value) {
                        setState(() {
                          selectedToValue = value.toString();
                          _handleInputChange(selectedFromValue,
                              selectedToValue); // Update the selected value here
                        });
                      },
                      items: places.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
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

  void _handleInputChange(selectedFromLocation, selectedToLocation) {
    _markers.clear();
    final toLocation = selectedToLocation.toLowerCase();
    final toEntry = placeLocations.entries.firstWhere(
      (entry) => entry.key.toLowerCase() == toLocation,
      // orElse: () => MapEntry('', LatLng(0.0, 0.0)),
    );
    final fromLocation = selectedFromLocation.toLowerCase();
    final fromEntry = placeLocations.entries.firstWhere(
      (entry) => entry.key.toLowerCase() == fromLocation,
      // orElse: () => MapEntry('', LatLng(0.0, 0.0)),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('selected-location'),
        position: toEntry.value,
        infoWindow: InfoWindow(title: 'To'),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('selected-location2'),
        position: fromEntry.value,
        infoWindow: InfoWindow(title: 'From'),
      ),
    );
  }
}
