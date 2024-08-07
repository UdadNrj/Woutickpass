// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:sunmi_scanner/sunmi_scanner.dart';

// class ScannerProvider with ChangeNotifier {
//   late StreamSubscription<String> _scanSubscription;

//   ScannerProvider() {
//     _initializeScanner();
//   }

//   Future<void> _initializeScanner() async {
//     try {
//       await SunmiScanner.initialize();

//       _scanSubscription = SunmiScanner.onBarcodeScanned().listen(
//         (scanData) {
//           print('Código escaneado: $scanData');
//         },
//         onError: (error) {
//           print('Error in scanStream: $error');
//         },
//       );
//     } catch (e, stackTrace) {
//       print('Error initializing scanner: $e');
//       print('Stack trace: $stackTrace');
//     }
//   }

//   @override
//   void dispose() {
//     _scanSubscription.cancel();
//     super.dispose();
//   }
