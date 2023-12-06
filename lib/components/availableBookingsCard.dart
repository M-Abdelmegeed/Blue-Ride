import 'package:flutter/material.dart';
import '../style/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class availableBookingsCard extends StatefulWidget {
  final bool isUserPending;
  final String tripId;
  final String driver;
  final String from;
  final String to;
  final String time;
  final String price;
  final String date;
  final String stops;

  availableBookingsCard(
      {required this.isUserPending,
      required this.tripId,
      required this.driver,
      required this.date,
      required this.from,
      required this.to,
      required this.time,
      required this.price,
      required this.stops});

  @override
  State<availableBookingsCard> createState() => _availableBookingsCardState();
}

class _availableBookingsCardState extends State<availableBookingsCard> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonPressed = widget.isUserPending;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primaryColorLight,
            borderRadius: BorderRadius.circular(12),
          ),
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_sharp,
                              color: AppColors.secondaryColor,
                            ),
                            const Text(
                              'FROM ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.secondaryColor),
                            ),
                            Text(
                              widget.from,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: AppColors.secondaryColor,
                            ),
                            const Text(
                              'TO ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.secondaryColor),
                            ),
                            Text(
                              widget.to,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: AppColors.secondaryColor,
                            ),
                            const Text(
                              'DRIVER ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.secondaryColor),
                            ),
                            Text(
                              widget.driver,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              color: AppColors.secondaryColor,
                            ),
                            Text(
                              widget.date,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_outlined,
                              color: AppColors.secondaryColor,
                            ),
                            Text(
                              widget.time,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.attach_money_outlined,
                              color: AppColors.secondaryColor,
                            ),
                            Text(
                              widget.price,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.report_gmailerrorred_outlined,
                              color: AppColors.secondaryColor,
                            ),
                            Flexible(
                              child: Text(
                                widget.stops,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 8,
                              backgroundColor: isButtonPressed
                                  ? Colors.white
                                  : AppColors.primaryColor,
                            ),
                            onPressed: () async {
                              setState(() {
                                isButtonPressed = !isButtonPressed;
                                // showToast(context);
                              });
                              if (isButtonPressed) {
                                Navigator.pushNamed(context, '/confirmBooking',
                                    arguments: {
                                      "tripId": widget.tripId,
                                      "driver": widget.driver,
                                      "from": widget.from,
                                      "to": widget.to,
                                      "price": widget.price,
                                      "time": widget.time,
                                      "date": widget.date
                                    });
                              } else {
                                // Delete record in history collection
                                QuerySnapshot querySnapshot =
                                    await FirebaseFirestore.instance
                                        .collection('History')
                                        .where('driverName',
                                            isEqualTo: widget.driver)
                                        .where('from', isEqualTo: widget.from)
                                        .where('to', isEqualTo: widget.to)
                                        .where('date', isEqualTo: widget.date)
                                        .get();
                                if (querySnapshot.docs.isNotEmpty) {
                                  await querySnapshot.docs.first.reference
                                      .delete();
                                  print('Record deleted successfully!');
                                  isButtonPressed = !isButtonPressed;
                                } else {
                                  print('No matching record found.');
                                }
                                DocumentReference tripDocument =
                                    FirebaseFirestore.instance
                                        .collection('Trips')
                                        .doc(widget.tripId);
                                await tripDocument.update({
                                  'pendingRiders':
                                      FieldValue.arrayRemove([_user!.uid]),
                                });
                                // print("Delete record here");
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.warning,
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2),
                                    buttonsBorderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                    headerAnimationLoop: false,
                                    animType: AnimType.scale,
                                    title: 'Booking Cancelled',
                                    btnOkOnPress: () {
                                      // isButtonPressed = !isButtonPressed;
                                    })
                                  ..show();
                              }
                            },
                            child: Text(
                              isButtonPressed ? 'Cancel' : 'Book Trip',
                              style: TextStyle(
                                  color: isButtonPressed
                                      ? AppColors.black
                                      : AppColors.secondaryColor),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void showToast(BuildContext context) {
  //   final scaffold = ScaffoldMessenger.of(context);
  //   String message;
  //   if (isButtonPressed) {
  //     message = 'Trip booked succesfully!';
  //   } else {
  //     message = 'Booking cancelled';
  //   }
  //   scaffold.showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       duration: Duration(seconds: 2),
  //     ),
  //   );
  // }
}
