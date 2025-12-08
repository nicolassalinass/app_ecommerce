// Provider para HTTP Client
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

// Provider para la URL base (cámbiala según tu API)
final baseUrlProvider = Provider<String>((ref) {
  //return 'https://api.neptunesteam.store'; // TODO: Cambiar por tu URL real
  return 'http://192.168.0.102:8000'; // URL de desarrollo local
});
