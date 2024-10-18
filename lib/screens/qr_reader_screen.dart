import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ontop_scanner/screens/login_screen.dart';

import '../components/error_dialog.dart';
import '../components/ticket_info.dart';
import '../services/storage.dart';

class QrReaderScreen extends StatelessWidget {
  static String? url = 'http://64.23.141.31:4000/';
  Map ticket = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lector QR'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              removeAccessToken();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 300.0,
              width: 300.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 5.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: MobileScanner(
                controller: MobileScannerController(
                    detectionSpeed: DetectionSpeed.noDuplicates,
                    returnImage: true),
                onDetect: (capture) async {
                  final List<Barcode> barcodes = capture.barcodes;
                  final Uint8List? image = capture.image;
                  for (final barcode in barcodes) {
                    var code = barcode.rawValue;
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      // Prevent user from closing dialog while loading
                      builder: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ); // Show loading indicator

                    final accessToken = await getAccessToken();
                    final headers = <String, String>{
                      'Authorization': 'Bearer $accessToken',
                      'Content-Type': 'application/json; charset=UTF-8',
                    };
                    print('codeeeee:$code');
                    var response = await http.get(
                      Uri.parse("http://64.23.141.31:4000/ticket/$code"),
                      headers: headers,
                    );
                    Navigator.of(context)
                        .pop(); // Hide loading indicator after data is fetched
                    print(response.body);
                    if (response.statusCode == 200) {
                      ticket = jsonDecode(utf8.decode(response.bodyBytes));
                      var customer =
                          "${ticket["customer"]["firstName"]} ${ticket["customer"]["lastName"]}";
                      showTicketInfo(context,
                          customerName: customer,
                          customerId: ticket["customer"]["ci"],
                          isActive: true,
                          code: ticket["code"],
                          ticketName:ticket["customer"]["firstName"],
                      );
                    } else {
                      // Handle API call errors
                      print("error");
                      showErrorDialog(context, "Ticket Invalido");
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom method to build the dialog content based on response status code
  Widget _buildResponseDialog(String code) {
    return CircularProgressIndicator(); // Show loading indicator initially
  }
}
