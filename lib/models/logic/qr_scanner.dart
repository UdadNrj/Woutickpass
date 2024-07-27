<<<<<<< HEAD:lib/models/logic/qr_scanner.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sunmi_scanner/sunmi_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:woutickpass/models/logic/qr_validation.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => QrScannerState();
}

class QrScannerState extends State<QrScanner> {
  bool qRCamare = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Qrcod? result;
  QRViewController? controller;
  String? scannedValue;
=======
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:sunmi_scanner/sunmi_scanner.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:woutickpass/models/qr_validation.dart';

// class PageQR extends StatefulWidget {
//   const PageQR({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _PageQRState();
// }

// class _PageQRState extends State<PageQR> {
//   bool qRCamare = false;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Barcode? result;
//   QRViewController? controller;
//   String? scannedValue;
>>>>>>> parent of dc54c47 (Cambios grandes !):lib/models/qr_scanner.dart

//   @override
//   void initState() {
//     super.initState();
//     if (!Platform.isIOS) {
//       SunmiScanner.onBarcodeScanned().listen((event) {
//         _setScannedValue(event);
//       });
//     }
//   }

//   void _setScannedValue(String value) {
//     setState(() {
//       scannedValue = value;
//     });
//   }

<<<<<<< HEAD:lib/models/logic/qr_scanner.dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Escaner',
          style: TextStyle(
              color: Color.fromRGBO(20, 26, 36, 1),
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
      ),
      body: Stack(
        children: [
          if (!qRCamare &&
              !Platform
                  .isIOS) // <-- Condición agregada para que no funcione en iOS
            Center(
              child: scannedValue != null
                  ? Text(
                      scannedValue!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text(
                      'ESCÁNER LISTO',
                      style: TextStyle(
                        color: Color(0xFFCED2DA),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            )
          else
            Expanded(
                flex: 5,
                child: QRView(key: qrKey, onQRViewCreated: onQRViewCamera)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 120, vertical: 16),
                        backgroundColor: const Color.fromRGBO(32, 43, 55, 1)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QRValidation(),
                        ),
                      );
                    },
                    child: const Text(
                      "ABRIR CAMARA",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
=======
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: const Text(
//           'Escaner',
//           style: TextStyle(
//               color: Color.fromRGBO(20, 26, 36, 1),
//               fontWeight: FontWeight.w700,
//               fontSize: 16),
//         ),
//       ),
//       body: Stack(
//         children: [
//           if (!qRCamare &&
//               !Platform
//                   .isIOS) // <-- Condición agregada para que no funcione en iOS
//             Center(
//               child: scannedValue != null
//                   ? Text(
//                       scannedValue!,
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     )
//                   : const Text(
//                       'ESCÁNER LISTO',
//                       style: TextStyle(
//                         color: Color(0xFFCED2DA),
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//             )
//           else
//             Expanded(
//                 flex: 5,
//                 child: QRView(key: qrKey, onQRViewCreated: onQRViewCamera)),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   const SizedBox(width: 16.0),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 120, vertical: 16),
//                         backgroundColor: Color.fromRGBO(32, 43, 55, 1)),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const QrValidation(),
//                         ),
//                       );
//                     },
//                     child: Text(
//                       "ABRIR CAMARA",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
>>>>>>> parent of dc54c47 (Cambios grandes !):lib/models/qr_scanner.dart

//   void onQRViewCamera(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((event) {
//       setState(() {
//         result = event;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
