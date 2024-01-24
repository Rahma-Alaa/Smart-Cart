// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import '../../core/constants/constant.dart';

class CustomDrawerHeader extends StatelessWidget {
  final String base64, name, email;
  const CustomDrawerHeader(
      {super.key,
      required this.base64,
      required this.name,
      required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            base64.contains("issues")
                ? const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/person.png'),
                  )
                : base64 == ""
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: myDarkGreen,
                      ))
                    : CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                        backgroundImage:
                            Image.memory(base64Decode(base64)).image,
                      ),
            const SizedBox(
              height: 18,
            ),
            Text(
              textScaleFactor: 1,
              name,
              style: const TextStyle(fontFamily: "harabaraBold", fontSize: 20),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              textScaleFactor: 1,
              email,
              style: const TextStyle(fontFamily: "harabara", fontSize: 14),
            ),
            const SizedBox(
              height: 5,
            ),
          ]),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Divider(
            thickness: 1,
            color: myLightGray,
          ),
        ),
      ],
    );
  }
}
