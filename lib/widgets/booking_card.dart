import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  final Map<String, dynamic> booking;
  const BookingCard({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(booking['film']['title'] ?? 'Film'),
        subtitle: Text('Séance le ${booking['session']['date']}'),
      ),
    );
  }
}