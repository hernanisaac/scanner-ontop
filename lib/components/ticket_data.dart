import 'package:flutter/material.dart';
import 'package:ontop_scanner/components/ticket_detail.dart';

class TicketData extends StatelessWidget {
  const TicketData({
    super.key,
    required this.ticketName,
    required this.customerName,
    required this.customerId,
    required this.isActive,
    required this.code,
  });

  final String ticketName;
  final String customerName;
  final String customerId;
  final bool isActive;
  final String code;

  @override
  Widget build(BuildContext context) {
    String status =
        isActive ? 'Permitido' : 'Inactivo'; // Set status based on isActive

    return Column(
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
                    width: 1.0, color: isActive ? Colors.green : Colors.red),
              ),
              child: Center(
                child: Text(
                  status,
                  style: TextStyle(color: isActive ? Colors.green : Colors.red),
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
                padding: const EdgeInsets.only(top: 12.0, right: 52.0),
                child: ticketDetailsWidget(
                    'Cliente', customerName, 'ID', customerId),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 53.0),
                child:
                    ticketDetailsWidget('Entrada', ticketName, 'Código', code),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        const Center(
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
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
