// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:Smarket/core/constants/constant.dart';
import 'package:Smarket/presentation/screens/homeScreen.dart';

class MyLoadingScreenToHome extends StatefulWidget {
  final String title;
  // ignore: prefer_const_constructors_in_immutables
  MyLoadingScreenToHome({Key? key, required this.title}) : super(key: key);

  @override
  _MyLoadingScreenToHomeState createState() => _MyLoadingScreenToHomeState();
}

class _MyLoadingScreenToHomeState extends State<MyLoadingScreenToHome>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );

    // Create a curved animation
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Start the animation
    _animationController.forward();

    // Wait for 1 second, then navigate to the new page
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textScaleFactor: 1,
            widget.title,
            style: const TextStyle(
              color: myDarkGreen,
              fontFamily: "harabaraBold",
              fontSize: 32.0,
            ),
          ),
          const SizedBox(
            height: 28,
          ),
          Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return SizedBox(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(
                    color: myDarkGreen,
                    value: _animation.value,
                    strokeWidth: 10,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
