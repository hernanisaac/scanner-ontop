import 'package:flutter/material.dart';
import 'package:ontop_scanner/components/ticket_detail.dart';
import 'package:ticket_widget/ticket_widget.dart';

void showTicketInfo(BuildContext context,
    {required String ticketName,
    required String customerName,
    required String customerId,
    required bool isActive,
    required String code,}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      String status =
          isActive ? 'Permitido' : 'Inactivo'; // Set status based on isActive
      return Container(
        decoration: const BoxDecoration(
          color: Colors.black, // Set the background color to black
          borderRadius: BorderRadius.only(
            // Add rounded borders
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Wrap(
          children: <Widget>[
            TicketWidget(
                width: 350,
                height: 500,
                isCornerRounded: true,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 120.0,
                          height: 25.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(
                                width: 1.0,
                                color: isActive ? Colors.green : Colors.red),
                          ),
                          child: Center(
                            child: Text(
                              status,
                              style: TextStyle(
                                  color: isActive ? Colors.green : Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 12.0, right: 52.0),
                            child: ticketDetailsWidget(
                                'Cliente', customerName, 'ID', customerId),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 12.0, right: 53.0),
                            child: ticketDetailsWidget(
                                'Entrada', ticketName, '', ''),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Text(
                        code,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                )),
            ElevatedButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
