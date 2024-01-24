import 'package:flutter/material.dart';
import '../../presentation/screens/cart_produt.dart';
import '../../presentation/screens/splash_screen.dart';

Map<String, Widget Function(BuildContext)> route = {
  "test": (context) => const CartProduct1(),
  "splashScreen": (context) => const SplashScreen(),
};
