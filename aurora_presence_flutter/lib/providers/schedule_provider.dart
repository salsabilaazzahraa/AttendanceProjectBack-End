import 'package:aurora_presence_flutter/services/schedule_services.dart';
import 'package:flutter/material.dart';
import 'package:aurora_presence_flutter/models/schedule.dart';

class ScheduleProvider with ChangeNotifier {
  List<Schedule> _schedules = [];
  bool _isLoading = false;

  List<Schedule> get schedules => _schedules;
  bool get isLoading => _isLoading;

  final ScheduleService _scheduleService = ScheduleService();

  // Fetch schedules from API
  Future<void> fetchSchedules() async {
  _isLoading = true;
  notifyListeners();

  try {
    _schedules = await _scheduleService.fetchSchedules();
    print(_schedules); // Debug: Lihat data yang diterima
  } catch (e) {
    print('Error: $e');
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}

  void deleteSchedule(int index) {}

  void addSchedule(Schedule newSchedule) {}
}