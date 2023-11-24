import 'package:flutter/material.dart';
import '../style/colors.dart';

class CustomCard extends StatelessWidget {
  final String from;
  final String to;
  final String time;
  final String price;
  final List stops;

  CustomCard(
      {required this.from,
      required this.to,
      required this.time,
      required this.price,
      required this.stops});

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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'FROM',
                          style: TextStyle(
                              fontSize: 14, color: AppColors.secondaryColor),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: AppColors.secondaryColor,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              from,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          size: 35,
                          Icons.double_arrow_sharp,
                          color: AppColors.secondaryColor,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'TO',
                          style: TextStyle(
                              fontSize: 14, color: AppColors.secondaryColor),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: AppColors.secondaryColor,
                            ),
                            Flexible(
                              child: Text(
                                softWrap: true,
                                to,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    color: AppColors.secondaryColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    time,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  const SizedBox(
                    width: 132,
                  ),
                  const Icon(
                    Icons.monetization_on_outlined,
                    color: AppColors.secondaryColor,
                  ),
                  const SizedBox(
                    width: 1,
                  ),
                  Text(
                    price + ' EGP',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.report_gmailerrorred_outlined,
                    color: AppColors.secondaryColor,
                  ),
                  Text(
                    " STOPS",
                    style: TextStyle(
                        color: AppColors.secondaryColor, fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      stops.join("  -  "),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      softWrap: true,
                      maxLines: 3,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
