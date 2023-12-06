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
  List<String> places = [
    // 'Nasr City',
    'Heliopolis',
    'Rehab',
    'ASU',
    'Tayaran',
    'Abbas el Akkad',
    'Makram Ebeid',
    'Dokki',
    'Tahrir Square',
    'Youssef Abbas',
    'Wafaa wel Amal',
    'Cairo Opera House',
    'Ahmed Fakhry',
    'Sheraton',
    'Madinaty',
    'Sherouk',
    'Mokattam',
  ];
  Map<String, LatLng> placeLocations = {
    'ASU': LatLng(30.06474820910293, 31.278861490545815),
    'Heliopolis': LatLng(30.113268828632258, 31.343674948595595),
    'Dokki': LatLng(30.040216631304027, 31.205701089600485),
    'Tayaran': LatLng(30.045349367163304, 31.328682159303348),
    'Ahmed Fakhry': LatLng(30.072324023121833, 31.351877011546815),
    'Youssef Abbas': LatLng(30.06712989283018, 31.319515297994563),
    'Wafaa wel Amal': LatLng(30.032635172330473, 31.33396492328897),
    'Cairo Opera House': LatLng(30.042537736813326, 31.223754026486457),
    'Sheraton': LatLng(30.104350278188726, 31.370668820940296),
    'Madinaty': LatLng(30.113451762820304, 31.627884677927522),
    'Sherouk': LatLng(30.181999753007208, 31.62468552992807),
    'Rehab': LatLng(30.059151492006812, 31.4958391394371),
    'Tahrir Square': LatLng(30.044494635882263, 31.235624615118088),
    'Abbas el Akkad': LatLng(30.056843711318994, 31.338100409296043),
    'Makram Ebeid': LatLng(30.062150301859262, 31.344985695802887),
    'Mokattam': LatLng(30.022446106882835, 31.30427737187155),
  };
  String selectedFromValue = 'Ahmed Fakhry';
  String selectedToValue = 'ASU';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    Navigator.pushNamed(context, '/availableBookings',
                        arguments: {
                          "From": selectedFromValue,
                          "To": selectedToValue
                        });
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
