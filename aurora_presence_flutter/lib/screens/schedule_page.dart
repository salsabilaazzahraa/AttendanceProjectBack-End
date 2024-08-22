import 'package:aurora_presence_flutter/screens/tambah_jadwal_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aurora_presence_flutter/providers/schedule_provider.dart';
import 'package:aurora_presence_flutter/models/schedule.dart';

class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ScheduleProvider()..fetchSchedules(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'Schedule',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color(0xFF00CEE8),
        ),
        body: Consumer<ScheduleProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (provider.schedules.isEmpty) {
              return Center(child: Text('No schedules found'));
            } else {
              // Debug: Cetak data jadwal
              print(provider.schedules);

              return ListView.builder(
                itemCount: provider.schedules.length,
                itemBuilder: (context, index) {
                  return _buildScheduleCard(provider.schedules[index], index, context);
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TambahDataScreen(
                onScheduleAdded: (Schedule newSchedule) {
                  Provider.of<ScheduleProvider>(context, listen: false).addSchedule(newSchedule);
                },
              )),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Color(0xFF00CEE8),
        ),
      ),
    );
  }

  Widget _buildScheduleCard(Schedule schedule, int index, BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  schedule.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.task_alt_outlined, color: Colors.green),
                    SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteSchedule(index, context),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Text('Office: ${schedule.office}'),
            Text('Date: ${schedule.datetimeStart} - ${schedule.datetimeEnd}'),
            Text('Time: ${schedule.timeStart} - ${schedule.timeEnd}'),
            SizedBox(height: 8),
            Text(
              'Team Members:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: schedule.teams.map((user) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(user.image),
                        radius: 25,
                      ),
                      SizedBox(height: 4),
                      Text(
                        user.name,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteSchedule(int index, BuildContext context) {
    Provider.of<ScheduleProvider>(context, listen: false).deleteSchedule(index);
  }
}