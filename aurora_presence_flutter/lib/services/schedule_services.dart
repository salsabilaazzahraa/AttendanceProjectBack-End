import 'package:dio/dio.dart';
import 'package:aurora_presence_flutter/models/schedule.dart';

class ScheduleService {
  final Dio _dio = Dio();

  // Fetch schedules
  Future<List<Schedule>> fetchSchedules() async {
    try {
      final response = await _dio.get('http://localhost:8080/schedules');
      
      // Debug: Cetak respons mentah dari server
      print('Response data: ${response.data}');
      
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Schedule.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load schedules');
      }
    } catch (e) {
      throw Exception('Failed to load schedules: $e');
    }
  }

  // Create new schedule
  Future<Schedule> createSchedule(Schedule schedule) async {
    try {
      // Debug: Cetak data yang dikirimkan
      print('Request data: ${schedule.toJson()}');

      final response = await _dio.post(
        'http://localhost:8080/schedules',
        data: schedule.toJson(),
      );
      
      // Debug: Cetak respons mentah dari server
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        return Schedule.fromJson(response.data);
      } else {
        throw Exception('Failed to create schedule');
      }
    } catch (e) {
      throw Exception('Failed to create schedule: $e');
    }
  }
}
