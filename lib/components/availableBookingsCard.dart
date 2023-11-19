import 'package:flutter/material.dart';
import '../style/colors.dart';

class availableBookingsCard extends StatefulWidget {
  final String driver;
  final String from;
  final String to;
  final String time;
  final String price;
  final String date;

  availableBookingsCard(
      {required this.driver,
      required this.date,
      required this.from,
      required this.to,
      required this.time,
      required this.price});

  @override
  State<availableBookingsCard> createState() => _availableBookingsCardState();
}

class _availableBookingsCardState extends State<availableBookingsCard> {
  bool isButtonPressed = false;
  @override
  Widget build(BuildContext context) {
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
                        // SizedBox(
                        //   height: 3,
                        // ),
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
                            // const Text(
                            //   'DATE ',
                            //   style: TextStyle(
                            //       fontSize: 14,
                            //       color: AppColors.secondaryColor),
                            // ),
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
                            // const Text(
                            //   'TIME ',
                            //   style: TextStyle(
                            //       fontSize: 14,
                            //       color: AppColors.secondaryColor),
                            // ),
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
                            // const Text(
                            //   'PRICE ',
                            //   style: TextStyle(
                            //       fontSize: 14,
                            //       color: AppColors.secondaryColor),
                            // ),
                            Text(
                              widget.price,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
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
                            onPressed: () {
                              setState(() {
                                isButtonPressed = !isButtonPressed;
                                showToast(context);
                                if (isButtonPressed) {
                                  Navigator.pushNamed(
                                      context, '/confirmBooking',
                                      arguments: {
                                        "driver": widget.driver,
                                        "from": widget.from,
                                        "to": widget.to,
                                        "price": widget.price,
                                        "time": widget.time,
                                        "date": widget.date
                                      });
                                }
                              });
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

  void showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    String message;
    if (isButtonPressed) {
      message = 'Trip booked succesfully!';
    } else {
      message = 'Booking cancelled';
    }
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
