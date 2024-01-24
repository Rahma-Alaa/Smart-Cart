import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/customAppBar.dart';
import '../widgets/invoices_widget.dart';
import 'empty_invoices.dart';
import 'homeScreen.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  getUseInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('id');
    final response = await http.get(Uri.parse(
        'https://smartcartapplback.azurewebsites.net/[InvoiceHistory]/GetInvoicesData?useId=${id.toString()}'));
    setState(() {
      invoicesList = json.decode(response.body);
      // print("++++++++$invoicesList++++++");
    });
  }

  @override
  void initState() {
    getUseInfo();
    // print(invoicesList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomAppBar(
        title: 'Invoices History',
        child: Padding(
            padding: const EdgeInsets.only(top: 76),
            child: (invoicesList.isNotEmpty)
                ? ListView.builder(
                    itemCount: invoicesList.length,
                    padding:
                        const EdgeInsets.only(left: 32, right: 32, top: 24),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          InvoicesWidget(
                            state: "market",
                            date: invoicesList[index]["date"],
                            card: "9999",
                            price: invoicesList[index]["price"],
                            paymentMethod: "visa",
                            invoiceID: invoicesList[index]["id"],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      );
                    },
                  )
                : const InvoicesEmpty()),
      ),
    );
  }
}
