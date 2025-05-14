// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Mon profil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ListTile(
            title: Text('Préférences'),
            subtitle: Text('À personnaliser selon l’utilisateur'),
          ),
          ListTile(
            title: const Text('Exporter mes données'),
            onTap: () {
              // Appel API pour exporter (à implémenter)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Export non implémenté')),
              );
            },
          ),
          ListTile(
            title: const Text('Supprimer mon compte'),
            onTap: () {
              // Appel API pour suppression (à implémenter)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Suppression non implémentée')),
              );
            },
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              auth.logout();
              Navigator.of(context).pushReplacementNamed('/login');
            },
            child: const Text('Déconnexion'),
          ),
        ],
      ),
    );
  }
}