import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../style/colors.dart';
import '../components/routesCard.dart';
import '../navbar.dart';

class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  final List<Route> routes = [
    Route(from: 'Gate 3', to: 'Korba', time: '5:30 PM'),
    Route(from: '5th Settlement', to: 'Gate 3', time: '7:30 AM'),
    Route(from: 'Gate 3', to: 'Nasr City', time: '5:30 PM'),
  ];
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          'Available Routes',
        ),
      ),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          return CustomCard(
            from: routes[index].from,
            to: routes[index].to,
            time: routes[index].time,
          );
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
  final String from;
  final String to;
  final String time;

  Route({required this.from, required this.to, required this.time});
}
