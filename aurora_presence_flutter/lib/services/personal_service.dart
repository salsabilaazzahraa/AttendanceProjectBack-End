import 'package:dio/dio.dart';
import '../models/personal.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8080';
  final Dio _dio = Dio();

  Future<Personal> fetchPersonalInfo(int userId) async {
    try {
      final response = await _dio.get('$baseUrl/personal/$userId');
      if (response.statusCode == 200) {
        return Personal.fromJson(response.data);
      } else {
        throw Exception('Failed to load personal data');
      }
    } catch (e) {
      throw Exception('Failed to load personal data: $e');
    }
  }

  Future<void> updatePersonalInfo(int id, Personal personal) async {
    try {
      final response = await _dio.put(
        '$baseUrl/personal/$id',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: personal.toJson(),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update personal data');
      }
    } catch (e) {
      throw Exception('Failed to update personal data: $e');
    }
  }
}
