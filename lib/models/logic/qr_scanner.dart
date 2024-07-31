// import 'package:flutter/material.dart';

// class QrScanner extends StatefulWidget {
//   const QrScanner({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => QrScannerState();
// }

// class QrScannerState extends State<QrScanner> {
//   bool qRCamare = false;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Qrcod? result;
//   QRViewController? controller;
//   String? scannedValue;

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
