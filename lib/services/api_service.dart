import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  static const String baseUrl = 'https://api.cinephoria.com'; // À adapter avec ton URL
  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  ApiService() {
    _setupDio();
  }

  void _setupDio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Ajoute le token à chaque requête
          final token = await _storage.read(key: 'token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            // Token expiré, déconnexion
            await _storage.delete(key: 'token');
            // Notifier l'app pour rediriger vers login
          }
          return handler.next(e);
        },
      ),
    );
  }

  // Authentification
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      final token = response.data['token'];
      await _storage.write(key: 'token', value: token);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Films
  Future<List<Map<String, dynamic>>> getMovies() async {
    try {
      final response = await _dio.get('/movies');
      return List<Map<String, dynamic>>.from(response.data['movies']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Réservations
  Future<List<Map<String, dynamic>>> getBookings() async {
    try {
      final response = await _dio.get('/bookings');
      return List<Map<String, dynamic>>.from(response.data['bookings']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Gestion des erreurs
  Exception _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return Exception('Connexion impossible');
    }
    if (e.response != null) {
      final message = e.response?.data['message'] ?? 'Une erreur est survenue';
      return Exception(message);
    }
    return Exception('Erreur réseau');
  }
}