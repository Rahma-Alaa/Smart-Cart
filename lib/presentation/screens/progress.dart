// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:Smarket/core/constants/constant.dart';
import 'package:Smarket/presentation/screens/account_setting.dart';

class MyLoadingScreen extends StatefulWidget {
  const MyLoadingScreen({Key? key}) : super(key: key);

  @override
  _MyLoadingScreenState createState() => _MyLoadingScreenState();
}

class _MyLoadingScreenState extends State<MyLoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Create a curved animation
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Start the animation
    _animationController.forward();

    // Wait for 1 second, then navigate to the new page
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AccountSetting(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(
                color: myDarkGreen,
                value: _animation.value,
                strokeWidth: 10,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
