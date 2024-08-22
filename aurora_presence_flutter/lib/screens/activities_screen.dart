import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivitiesScreen extends StatefulWidget {
  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  List<Map<String, String>> upcomingEvents = [
    {
      'title': 'Workshop Flutter',
      'date': '25 Agustus 2024',
      'time': '09:00 - 16:00'
    },
    {
      'title': 'Workshop Internal: Cyber Security',
      'date': '01 September 2024',
      'time': '08:00 - 17:00'
    },
    {
      'title': 'Team Building',
      'date': '10 September 2024',
      'time': '08:00 - 17:00'
    },
  ];

  final String latestHighlight =
      'Peringatan Hari Kemerdekaan dengan berbagai lomba seperti lomba makan kerupuk, balap karung, dan lainnya yang berlangsung sangat meriah di kantor pusat. Seluruh karyawan berpartisipasi dengan penuh semangat, mempererat kebersamaan antar tim.';
  final String lastEventDescription =
      'Kegiatan terakhir yang telah dilaksanakan adalah outing kantor di Puncak, di mana semua karyawan mengikuti berbagai kegiatan tim building yang seru dan menyenangkan.';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final String eventsString = upcomingEvents
        .map((e) => '${e['title']}|${e['date']}|${e['time']}')
        .join(';');
    prefs.setString('upcomingEvents', eventsString);
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? eventsString = prefs.getString('upcomingEvents');
    if (eventsString != null) {
      final List<Map<String, String>> loadedEvents =
          eventsString.split(';').map((eventString) {
        final parts = eventString.split('|');
        return {
          'title': parts[0],
          'date': parts[1],
          'time': parts[2],
        };
      }).toList();
      setState(() {
        upcomingEvents = loadedEvents;
      });
    }
  }

  Future<void> _removeEvent(int index) async {
    setState(() {
      upcomingEvents.removeAt(index);
    });
    await _saveData(); // Save changes
  }

  void _editEvent(int index) {
    TextEditingController titleController =
        TextEditingController(text: upcomingEvents[index]['title']);
    TextEditingController dateController =
        TextEditingController(text: upcomingEvents[index]['date']);
    TextEditingController timeController =
        TextEditingController(text: upcomingEvents[index]['time']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Kegiatan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Judul'),
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'Tanggal'),
              ),
              TextField(
                controller: timeController,
                decoration: InputDecoration(labelText: 'Waktu'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  upcomingEvents[index] = {
                    'title': titleController.text,
                    'date': dateController.text,
                    'time': timeController.text,
                  };
                });
                _saveData(); // Save changes
                Navigator.pop(context);
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _addEvent() {
    TextEditingController titleController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController timeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Kegiatan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Judul'),
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'Tanggal'),
              ),
              TextField(
                controller: timeController,
                decoration: InputDecoration(labelText: 'Waktu'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  upcomingEvents.add({
                    'title': titleController.text,
                    'date': dateController.text,
                    'time': timeController.text,
                  });
                });
                _saveData(); // Save changes
                Navigator.pop(context);
              },
              child: Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00CEE8),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Kegiatan",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionHeader('Kegiatan Mendatang', Icons.event, context),
            SizedBox(height: 8),
            _buildBoxedContent(
              context,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: upcomingEvents.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, String> event = entry.value;
                  return ListTile(
                    title: Text(event['title']!),
                    subtitle: Text('${event['date']} - ${event['time']}'),
                    leading:
                        Icon(Icons.calendar_today, color: Color(0xFF00CEE8)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _editEvent(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _removeEvent(index),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            TextButton(
              onPressed: _addEvent,
              child: Text('Tambah Kegiatan'),
            ),
            SizedBox(height: 16),
            _buildSectionHeader('Sorotan Terbaru', Icons.highlight, context),
            SizedBox(height: 8),
            _buildBoxedContent(
              context,
              Text(latestHighlight),
            ),
            SizedBox(height: 16),
            _buildSectionHeader('Kegiatan Terakhir', Icons.history, context),
            SizedBox(height: 8),
            _buildBoxedContent(
              context,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lastEventDescription),
                  SizedBox(height: 8),
                  Center(
                    child: Image.asset(
                      'images/kantor1.jpg',
                      fit: BoxFit.cover,
                      height: 400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
      String title, IconData icon, BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Color(0xFF00CEE8)),
        SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  Widget _buildBoxedContent(BuildContext context, Widget content) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue),
      ),
      padding: EdgeInsets.all(16.0),
      child: content,
    );
  }
}
