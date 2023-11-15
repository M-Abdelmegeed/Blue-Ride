import 'package:flutter/material.dart';
import './style/colors.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<String> routes = ['/home', '/routes', '/activity', '/profile'];

  NavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: AppColors.primaryColor,
      ),
      child: BottomNavigationBar(
        fixedColor: Colors.white,
        unselectedItemColor: AppColors.backgroundColor,
        showUnselectedLabels: true,
        currentIndex: currentIndex,
        onTap: (index) {
          onTap(index);
          // Navigate to the selected route
          Navigator.pushNamed(context, routes[index]);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.route_rounded),
            label: 'Routes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
