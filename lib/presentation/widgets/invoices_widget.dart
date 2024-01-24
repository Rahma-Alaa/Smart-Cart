import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/constant.dart';
import '../../data/models/get_msg.dart';
import '../../data/repository/get_home.dart';
import '../../pdf/pdf_api_web.dart';

Future<File> _writeToFile(String base64String) async {
  final bytes = base64.decode(base64String);

  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/invoice.pdf');

  await file.writeAsBytes(bytes);

  return file;
}

class InvoicesWidget extends StatefulWidget {
  final String date, state, card, price, paymentMethod;

  final int invoiceID;

  const InvoicesWidget(
      {super.key,
      required this.state,
      required this.date,
      required this.card,
      required this.price,
      required this.paymentMethod,
      required this.invoiceID});

  @override
  State<InvoicesWidget> createState() => _InvoicesWidgetState();
}

int userId = 0;

class _InvoicesWidgetState extends State<InvoicesWidget> {
  bool clicked = false;
  getUseInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('id');
    setState(() {
      userId = id!;
      // print("++++++++$id+++++++");
    });
  }

  @override
  void initState() {
    getUseInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      shadowColor: const Color.fromARGB(120, 0, 0, 0),
      elevation: 4,
      child: Container(
        height: 76,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(150, 220, 220, 220)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      (widget.state == "market")
                          ? "assets/icons/market.svg"
                          : "assets/icons/online.svg",
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 24,
                      ),
                      SizedBox(
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              textScaleFactor: 1,
                              widget.date,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: "harabaraBold",
                                  color: Color(0xff888888)),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SvgPicture.asset(
                              (widget.state == "market")
                                  ? "assets/icons/markettxt.svg"
                                  : "assets/icons/onlinetxt.svg",
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          textScaleFactor: 1,
                          "${widget.price} L.E",
                          style: const TextStyle(
                              fontSize: 12,
                              fontFamily: "harabaraBold",
                              color: Colors.black),
                        ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       color: const Color.fromARGB(100, 204, 204, 204),
                        //       borderRadius: BorderRadius.circular(4)),
                        //   height: 14,
                        //   width: 50,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //      Text(
                        // textScaleFactor: 1,
                        //         "${widget.paymentMethod} ",
                        //         style: const TextStyle(
                        //             fontSize: 7,
                        //             fontFamily: "harabaraBold",
                        //             color: Color(0xff999999)),
                        //       ),
                        //      Text(
                        // textScaleFactor: 1,
                        //         widget.card,
                        //         style: const TextStyle(
                        //             fontSize: 7,
                        //             fontFamily: "harabaraBold",
                        //             color: Color(0xff444444)),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  InkWell(
                      onTap: () async {
                        setState(() {
                          clicked = true;
                        });
                        // print("+++++++${widget.invoiceID}++++++");
                        // print("+++++++$userId++++++");
                        GetMsg data =
                            await userInvoice(userId, widget.invoiceID);
                        // print(data.message);
                        File pdfFile = await _writeToFile(data.message!);
                        PdfApi.openFile(pdfFile);
                        setState(() {
                          clicked = false;
                        });
                      },
                      child: clicked
                          ? const SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: myDarkGreen,
                              ),
                            )
                          : SvgPicture.asset(
                              "assets/icons/pdf.svg",
                              height: 28,
                              width: 28,
                            )),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
