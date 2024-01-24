import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Smarket/presentation/screens/scan_qr.dart';

import '../widgets/background.dart';

class NotFoundCode extends StatefulWidget {
  const NotFoundCode({super.key});

  @override
  NotFoundCodeState createState() => NotFoundCodeState();
}

class NotFoundCodeState extends State<NotFoundCode> {
  @override
  Widget build(BuildContext context) {
    return BackGround(
      children: <Widget>[
        const SizedBox(
          height: 85,
        ),
        Center(
          child: Column(
            children: <Widget>[
              Image.asset("assets/gifs/notFoundCart.gif", height: 300),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 18, 30),
                child: Container(
                  height: 45,
                  width: 165,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xff2c6976),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const ScanQRCode()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 15,
                            ),
                            SvgPicture.asset("assets/icons/qrCode.svg"),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              textScaleFactor: 1,
                              "Scan Again",
                              style: TextStyle(
                                fontFamily: "harabaraBold",
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
