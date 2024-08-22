class Activity {
  final DateTime date;
  final String day;
  final String clockIn;
  final String clockOut;
  final bool isToday;

  Activity({
    required this.date,
    required this.day,
    required this.clockIn,
    required this.clockOut,
    this.isToday = false,
  });
}