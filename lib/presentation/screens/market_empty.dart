import 'package:flutter/material.dart';

class EmptyMarket extends StatefulWidget {
  const EmptyMarket({super.key});

  @override
  EmptyMarketState createState() => EmptyMarketState();
}

class EmptyMarketState extends State<EmptyMarket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: const []),
    );
  }
}
