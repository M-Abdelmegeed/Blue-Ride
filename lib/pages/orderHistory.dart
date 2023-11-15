import 'package:flutter/material.dart';
import '../style/colors.dart';
import '../navbar.dart';

class orderHistory extends StatefulWidget {
  const orderHistory({Key? key}) : super(key: key);

  @override
  _orderHistoryState createState() => _orderHistoryState();
}

class _orderHistoryState extends State<orderHistory> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // backgroundColor: AppColors.primaryColor,
      //   title: Text(
      //     'Book A Ride',
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      body: Center(
        child: Text("Order History Page"),
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
