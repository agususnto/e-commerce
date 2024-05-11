// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class BarcodeScannerScreen extends StatefulWidget {
//   const BarcodeScannerScreen({super.key});

//   @override
//   State<StatefulWidget> createState() => _BarcodeScannerScreenState();
// }

// class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   late QRViewController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Barcode Scanner'),
//       ),
//       body: Stack(
//         alignment: Alignment.center,
//         children: <Widget>[
//           buildQrView(context),
//           Positioned(
//             bottom: 0.0,
//             child: Container(
//               padding: const EdgeInsets.all(20.0),
//               color: Colors.black.withAlpha(120),
//               child: const Text(
//                 'Arahkan kamera ke barcode',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget buildQrView(BuildContext context) {
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       // Do something with the scanned data, like navigating to a new screen
//       // ignore: avoid_print
//       print('Scanned data: ${scanData.code}');
//       // Here you can navigate to a new screen or perform any other action
//       // based on the scanned QR code data
//       // For example:
//       // Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen(data: scanData.code)));
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
// }
