import 'package:flutter/material.dart';
import '../style/colors.dart';
import '../navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class orderHistory extends StatefulWidget {
  const orderHistory({Key? key}) : super(key: key);

  @override
  _orderHistoryState createState() => _orderHistoryState();
}

class _orderHistoryState extends State<orderHistory> {
  int _currentIndex = 2;

  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  CollectionReference ridesHistory =
      FirebaseFirestore.instance.collection('History');

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Order History'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('History')
            .where('riderId', isEqualTo: _user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          return Column(
            children: [
              SizedBox(
                height: 14,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var historyData = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.all(8),
                      color: AppColors.primaryColorLight,
                      child: ListTile(
                        title: Text(
                          '${historyData["date"]}',
                          style: TextStyle(
                            fontSize: 22,
                            color: AppColors.secondaryColor,
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
                                    text: historyData["from"],
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
                                    text: historyData["to"],
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
                                    text: historyData["driverName"],
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
                        trailing: IconButton(
                          icon: Column(
                            children: [
                              Icon(
                                historyData["status"] == 'Pending'
                                    ? Icons.pending
                                    : historyData["status"] == 'Completed'
                                        ? Icons.check_circle_sharp
                                        : historyData["status"] == 'Rejected'
                                            ? Icons.cancel
                                            : Icons.done_all_outlined,
                                size: 20,
                                color: historyData["status"] == 'Pending'
                                    ? Colors.yellow
                                    : historyData["status"] == 'Completed'
                                        ? Colors.grey
                                        : historyData["status"] == 'Rejected'
                                            ? Colors.red
                                            : Colors.green,
                              ),
                              Text(
                                historyData["status"],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            // Handle button press if needed
                            print('Status Pressed');
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
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
