// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Smarket/core/constants/constant.dart';
import '../screens/select_card.dart';

class CustomAppBar2 extends StatelessWidget {
  Widget child;
  String title;
  CustomAppBar2({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        SizedBox(
            height: 76,
            width: double.infinity,
            child: Row(
              children: [
                const SizedBox(
                  width: 24,
                ),
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const SelectCard(),
                  )),
                  child: SvgPicture.asset(
                    'assets/icons/back.svg',
                    height: 32,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 104,
                  child: Center(
                    child: Text(
                      textScaleFactor: 1,
                      title,
                      style: const TextStyle(
                          color: myDarkGray,
                          fontFamily: "harabara",
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
