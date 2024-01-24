// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:Smarket/presentation/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Smarket/data/repository/auth_qr.dart';
import '../../data/models/get_msg.dart';
import 'cart_produt.dart';
import 'not_found_qr.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  @override
  ScanQRCodeState createState() => ScanQRCodeState();
}

// ignore: non_constant_identifier_names
int id_user = 0;

class ScanQRCodeState extends State<ScanQRCode> {
  saveQr(String qr) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('qr', qr);
  }

  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('id');
    setState(() {
      id_user = id!;
    });
  }

  @override
  void initState() {
    getId();

    super.initState();
  }

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomAppBar(
      title: "Scan QR Code",
      child: _buildQrView(context),
    ));
  }

  Widget _buildQrView(BuildContext context) {
    //check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: const Color(0xff2c6976),
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  bool gotValidQR = false;
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      //TODO
      result = scanData;
      GetMsg data = await authQr(result?.code.toString(), id_user);
      setState(() {
        // print("++++++++++++");
        // print(result?.code.toString());

        if (data.message == "Account connected Successfully!") {
          gotValidQR = true;
          productList.clear();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const CartProduct1(),
          ));
          saveQr(result!.code.toString());
        } else {
          if (gotValidQR) {
            return;
          }
          // print("test++++not+++");

          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const NotFoundCode(),
          ));
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const NotFoundCode(),
      ));
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
