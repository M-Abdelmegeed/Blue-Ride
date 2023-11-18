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

  final List<Order> orders = [
    Order(
        date: '22 October 2023',
        from: 'Gate 3',
        to: 'Korba',
        driverName: 'Youssef Ayman'),
    Order(
        date: '11 November 2023',
        from: '5th Settlement',
        to: 'Gate 3',
        driverName: 'Omar Adel'),
    Order(
        date: '12 November 2023',
        from: 'Gate 3',
        to: 'Nasr City',
        driverName: 'Kareem Ahmed'),
    // Add more orders as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Order History'),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Text(
          //     'Order History',
          //     style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
          //   ),
          // ),
          SizedBox(
            height: 14,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(8),
                  color: AppColors.primaryColorLight,
                  child: ListTile(
                    title: Text(
                      '${orders[index].date}',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'From: ',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: orders[index].from,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'To: ',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: orders[index].to,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Driver Name: ',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: orders[index].driverName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.no_crash,
                        size: 40, color: AppColors.secondaryColor),
                  ),
                );
              },
            ),
          ),
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
}

class Order {
  final String date;
  final String from;
  final String to;
  final String driverName;

  Order(
      {required this.date,
      required this.from,
      required this.to,
      required this.driverName});
}
