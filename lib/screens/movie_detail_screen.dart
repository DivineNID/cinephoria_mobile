// lib/screens/movie_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'booking_form_screen.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // À remplacer par un appel API pour les séances réelles
    final sessions = [
      {'date': '2024-06-15', 'time': '20:00', 'id': 'sess1'},
      {'date': '2024-06-16', 'time': '18:00', 'id': 'sess2'},
    ];

    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Image.network(movie.posterUrl, height: 300),
          const SizedBox(height: 16),
          Text(movie.title, style: Theme.of(context).textTheme.headline5),
          const SizedBox(height: 8),
          Text(movie.description),
          const SizedBox(height: 16),
          Text('Séances disponibles', style: Theme.of(context).textTheme.subtitle1),
          ...sessions.map((session) => ListTile(
            title: Text('${session['date']} à ${session['time']}'),
            trailing: ElevatedButton(
              child: const Text('Réserver'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookingFormScreen(
                      movie: movie,
                      sessionId: session['id']!,
                      sessionDate: session['date']!,
                      sessionTime: session['time']!,
                    ),
                  ),
                );
              },
            ),
          )),
        ],
      ),
    );
  }
}