// lib/screens/bookings_screen.dart
import 'package:flutter/material.dart';
import '../widgets/qr_code_widget.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // À remplacer par un appel API réel
    final bookings = [
      {
        'id': 'ABC123',
        'film': {'title': 'Inception'},
        'session': {'date': '2024-06-15', 'time': '20:00'}
      }
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Mes réservations')),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return ListTile(
            title: Text(booking['film']['title']),
            subtitle: Text('Séance le ${booking['session']['date']} à ${booking['session']['time']}'),
            trailing: IconButton(
              icon: const Icon(Icons.qr_code),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Votre billet'),
                    content: QRCodeWidget(data: booking['id']),
                  ),
                );
              },
            ),
            onLongPress: () {
              // Annulation (à implémenter)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Annulation non implémentée')),
              );
            },
          );
        },
      ),
    );
  }
}