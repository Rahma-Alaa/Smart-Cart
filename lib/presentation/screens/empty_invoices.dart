import 'package:Smarket/presentation/screens/invoices_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../core/constants/constant.dart';

class InvoicesEmpty extends StatefulWidget {
  const InvoicesEmpty({super.key});

  @override
  State<InvoicesEmpty> createState() => _InvoicesEmptyState();
}

class _InvoicesEmptyState extends State<InvoicesEmpty> {
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/gifs/noData.gif",
            height: (kIsWeb) ? MediaQuery.of(context).size.height / 2.5 : 300,
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            textScaleFactor: 1,
            "Not Found any invoice",
            style: TextStyle(
                fontFamily: "harabaraBold", fontSize: 24, color: myDarkGreen),
          ),
          const SizedBox(
            height: 24,
          ),
          Center(
            child: Container(
              height: 40,
              width: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xff2c6976),
              ),
              child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      clicked = true;
                    });
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const InvoicesScreen(),
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: clicked
                        ? const SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            textScaleFactor: 1,
                            'ReLoad...',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "harabaraBold",
                              fontSize: 20.0,
                            ),
                          ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
