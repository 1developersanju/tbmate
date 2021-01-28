import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:qr_scanner/play.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          height: 40,
          width: 150,
          child: RaisedButton(
            child: "Tap here to scan"
                .text
                .size(0)
                .color(Colors.black)
                .bold
                .makeCentered(),
            onPressed: () async {
              String codeScanner = await BarcodeScanner.scan();
              schannel = codeScanner.substring(codeScanner.length - 12);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Gacce()));
            },
          ).centered(),
        ).centered(),
      ),
    );
  }
}
