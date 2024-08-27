import 'package:aurora_presence_flutter/screens/home_screen.dart';
import 'package:aurora_presence_flutter/screens/presensi_screen.dart';
import 'package:aurora_presence_flutter/screens/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart'; // Ganti http dengan dio

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  int _selectedIndex = 1;
  final List<Activity> allActivities = [
    Activity(
        date: DateTime(2024, 8, 6),
        day: 'Tues',
        clockIn: '09:00 AM',
        breakStart: '12:00 PM',
        breakOut: '13:00 PM',
        clockOut: '17:00 PM',
        isToday: true),
    Activity(
        date: DateTime(2024, 8, 5),
        day: 'Mon',
        clockIn: '09:00 AM',
        breakStart: '12:00 PM',
        breakOut: '13:00 PM',
        clockOut: '17:00 PM'),
    Activity(
        date: DateTime(2024, 8, 2),
        day: 'Fri',
        clockIn: '09:00 AM',
        breakStart: '12:00 PM',
        breakOut: '13:00 PM',
        clockOut: '17:00 PM'),
    // Tambahkan aktivitas lainnya sesuai kebutuhan...
  ];

  String selectedFilter = 'Bulanan';
  DateTime currentMonth = DateTime.now();
  DateTime? selectedDate;
  List<Activity> activities = [];

  @override
  void initState() {
    super.initState();
    _filterActivities();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ActivityScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PresensiScreen()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
    }
  }

  void _filterActivities() {
    setState(() {
      if (selectedFilter == 'Harian') {
        activities = allActivities.where((activity) {
          return activity.date.year == DateTime.now().year &&
              activity.date.month == DateTime.now().month &&
              activity.date.day == DateTime.now().day;
        }).toList();
      } else if (selectedFilter == 'Mingguan') {
        DateTime startOfWeek =
            DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
        DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
        activities = allActivities.where((activity) {
          return activity.date.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
              activity.date.isBefore(endOfWeek.add(Duration(days: 1)));
        }).toList();
      } else if (selectedFilter == 'Bulanan') {
        activities = allActivities.where((activity) {
          return activity.date.month == currentMonth.month &&
              activity.date.year == currentMonth.year;
        }).toList();
      } else if (selectedFilter == 'Pilih Tanggal' && selectedDate != null) {
        activities = allActivities.where((activity) {
          return activity.date.year == selectedDate!.year &&
              activity.date.month == selectedDate!.month &&
              activity.date.day == selectedDate!.day;
        }).toList();
      } else {
        activities = allActivities;
      }
    });
  }

  void _onFilterChanged(String filter) async {
    if (filter == 'Pilih Tanggal') {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (pickedDate != null) {
        setState(() {
          selectedDate = pickedDate;
          selectedFilter = filter;
          currentMonth = DateTime(pickedDate.year, pickedDate.month);
          _filterActivities();
        });
      }
    } else {
      setState(() {
        selectedFilter = filter;
        _filterActivities();
      });
    }
  }

  void _onMonthChanged(bool isNext) {
    setState(() {
      currentMonth = DateTime(
        currentMonth.year,
        isNext ? currentMonth.month + 1 : currentMonth.month - 1,
      );
      _filterActivities();
    });
  }

  Future<void> _performClockIn() async {
    final now = DateTime.now();
    final body = {
      'type': 'clock in',
      'date_time': now.toIso8601String(),
      'office_id': 1,
    };

    try {
      Dio dio = Dio(BaseOptions(
  baseUrl: 'https://jsonplaceholder.typicode.com', // URL pengujian
  connectTimeout: Duration(milliseconds: 5000),
  receiveTimeout: Duration(milliseconds: 3000),
));


      final response = await dio.post(
        '/history/create',
        data: body,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        print('Clock in successful');
      } else {
        print('Failed to clock in: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilterButton(
                    label: 'Hari Ini',
                    isSelected: selectedFilter == 'Harian',
                    onTap: () => _onFilterChanged('Harian')),
                FilterButton(
                    label: 'Bulanan',
                    isSelected: selectedFilter == 'Bulanan',
                    onTap: () => _onFilterChanged('Bulanan')),
                FilterButton(
                    label: 'Pilih Tanggal',
                    isSelected: selectedFilter == 'Pilih Tanggal',
                    onTap: () => _onFilterChanged('Pilih Tanggal')),
              ],
            ),
          ),
          if (selectedFilter != 'Harian')
            Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                IconButton(
                icon: Icon(
                Icons.arrow_circle_left_outlined,
                color: Colors.lightBlue, // Warna light blue untuk ikon
                ),
                onPressed: () => _onMonthChanged(false),
                ),

              IconButton(
              icon: Icon(
              Icons.arrow_circle_right_outlined,
              color: Colors.lightBlue, // Warna light blue untuk ikon
             ),
            onPressed: () => _onMonthChanged(true),
            ),

                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                return ActivityCard(activity: activities[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.lightBlue,
        buttonBackgroundColor: Colors.lightBlue,
        height: 60,
        items: <Widget>[
          Icon(Icons.home_outlined, size: 30, color: Colors.white),
          Icon(Icons.manage_history_sharp, size: 30, color: Colors.white),
          Icon(Icons.assessment_outlined, size: 30, color: Colors.white),
          Icon(Icons.person_2_outlined, size: 30, color: Colors.white),
        ],
        animationDuration: Duration(milliseconds: 200),
        index: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class Activity {
  final DateTime date;
  final String day;
  final String clockIn;
  final String breakStart;
  final String breakOut;
  final String clockOut;
  final bool isToday;

  Activity({
    required this.date,
    required this.day,
    required this.clockIn,
    required this.breakStart,
    required this.breakOut,
    required this.clockOut,
    this.isToday = false,
  });
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterButton({
    Key? key,
    required this.label,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        side: BorderSide(color: Colors.blue),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final Activity activity;

  const ActivityCard({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${activity.day}, ${DateFormat('dd MMM yyyy').format(activity.date)}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Clock In: ${activity.clockIn}'),
            Text('Break Start: ${activity.breakStart}'),
            Text('Break Out: ${activity.breakOut}'),
            Text('Clock Out: ${activity.clockOut}'),
          ],
        ),
      ),
    );
  }
}
