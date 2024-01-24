import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/constant.dart';

class PaymentWidget extends StatelessWidget {
  final String state, cardnumber;

  final void Function() onTap;

  const PaymentWidget({
    super.key,
    required this.state,
    required this.cardnumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: 60,
          width: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xffDCDCDC),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 3,
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 3),
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 40,
                    child: SvgPicture.asset(
                      (state == "master")
                          ? "assets/icons/visa.svg"
                          : "assets/icons/mastercard.svg",
                    )),
                // SizedBox(
                //   width: 60,
                //   child:Text(
                            // textScaleFactor: 1,
                //     "xxxx$cardnumber",
                //     style: const TextStyle(
                //       color: Color(0xff444444),
                //       fontFamily: "harabaraBold",
                //       fontSize: 12.0,
                //     ),
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 20),
                            content: Container(
                              height: 125,
                              width: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/delete.svg",
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Text(
                            textScaleFactor: 1,
                                        "Delete",
                                        style: TextStyle(
                                            fontFamily: "harabaraBold",
                                            fontSize: 18,
                                            color: Color(0xff444444)),
                                      ),
                                    ],
                                  ),
                                  const Text(
                            textScaleFactor: 1,
                                    "Are you sure want to delete ?",
                                    style: TextStyle(
                                        fontFamily: "harabara",
                                        fontSize: 16,
                                        color: Color(0xff666666)),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: (() => Navigator.pop(context)),
                                        child: Container(
                                          height: 36,
                                          width: 84,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xff888888)),
                                              color: Colors.white),
                                          child: const Center(
                                            child:Text(
                            textScaleFactor: 1,
                                              "Cancel",
                                              style: TextStyle(
                                                  fontFamily: "harabaraBold",
                                                  fontSize: 16,
                                                  color: Color(0xff888888)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: onTap,
                                        child: Container(
                                          height: 36,
                                          width: 84,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: myDarkGreen),
                                          child: const Center(
                                            child:Text(
                            textScaleFactor: 1,
                                              "Delete",
                                              style: TextStyle(
                                                  fontFamily: "harabaraBold",
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: SvgPicture.asset('assets/icons/delete.svg'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
