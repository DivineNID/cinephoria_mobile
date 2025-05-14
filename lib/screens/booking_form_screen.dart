// lib/screens/booking_form_screen.dart
import 'package:flutter/material.dart';
import '../models/movie.dart';

class BookingFormScreen extends StatefulWidget {
  final Movie movie;
  final String sessionId;
  final String sessionDate;
  final String sessionTime;

  const BookingFormScreen({
    Key? key,
    required this.movie,
    required this.sessionId,
    required this.sessionDate,
    required this.sessionTime,
  }) : super(key: key);

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  int _seats = 1;
  bool _isLoading = false;

  Future<void> _book() async {
    setState(() => _isLoading = true);
    // Appel API pour réserver
    await Future.delayed(const Duration(seconds: 1)); // Simule l'appel
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Réservation confirmée !')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Réserver - ${widget.movie.title}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Séance le ${widget.sessionDate} à ${widget.sessionTime}'),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Nombre de places :'),
                const SizedBox(width: 16),
                DropdownButton<int>(
                  value: _seats,
                  items: [1, 2, 3, 4, 5]
                      .map((n) => DropdownMenuItem(value: n, child: Text('$n')))
                      .toList(),
                  onChanged: (v) => setState(() => _seats = v!),
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _book,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Confirmer la réservation'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}