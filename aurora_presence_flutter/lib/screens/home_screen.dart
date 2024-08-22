import 'package:aurora_presence_flutter/screens/out.dart';
import 'package:aurora_presence_flutter/screens/presensi_screen.dart';
import 'package:aurora_presence_flutter/screens/succes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'gaji_screen.dart';
import 'pengajuan_screen.dart';
import 'questionnaire_screen.dart';
import 'information_screen.dart';
import 'tugas_screen.dart';
import 'schedule_page.dart';
import 'activities_screen.dart';
import 'package:aurora_presence_flutter/screens/activity_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'profile_screen.dart';
import 'break_start.dart';
import 'break_out.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  String name = "Indah Sinurat";
  int _selectedIndex = 0;
  Color _seeAllColorSchedule = Colors.black;
  Color _seeAllColorAnnouncement = Colors.black;
  Color _seeAllColorTask = Colors.black;
  late DateTime now;
  late Timer _timer;
  String? _selectedLocation;
  TextEditingController _locationController = TextEditingController();
  List<String> _locations = [
    'IDS Indonesia Cilandak',
    'IDS Indonesia Cibubur',
    'Lainnya'
  ];

  bool _isClockInDone = false;
  bool _isClockOutDone = false;
  bool _isBreakStartAvailable = false;
  bool _isBreakOutAvailable = false;

  bool _isBreakStartDone = false; // Deklarasikan variabel ini
  bool _isBreakOutDone = false; // Deklarasikan variabel ini

  bool isClockInTime = false;
  bool isBreakStartTime = false;
  bool isBreakOutTime = false;
  bool isClockOutTime = false;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ActivityScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PresensiScreen()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadName();
    now = DateTime.now();
    _loadSelectedLocation();
    _loadLocations();
    _checkAndResetClockStatus();
    _checkBreakAvailability();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        now = DateTime.now();
        _updateTimeStatus();
      });
    });
  }

  void _updateTimeStatus() {
    isClockInTime = now.hour >= 12 && now.hour < 17;
    isClockOutTime = now.hour >= 17 || now.hour < 12;
    isBreakStartTime = now.hour >= 12 && now.hour < 13;
    isBreakOutTime = now.hour >= 13 && now.hour < 14;
  }

  @override
  void dispose() {
    _timer.cancel();
    _locationController.dispose();
    super.dispose();
  }

  void _checkBreakAvailability() {
    setState(() {
      now = DateTime.now();
      _isBreakStartAvailable = now.hour == 15;  // mengubah jam break start
      _isBreakOutAvailable = now.hour == 16 && now.minute <= 60;   // mengubah jam break out
    });
  }

  Future<void> _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? "";
    });
  }

  Future<void> _checkAndResetClockStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastClockDate = prefs.getString('lastClockDate');
    String todayDate = DateFormat('yyyy-MM-dd').format(now);

    if (lastClockDate == null || lastClockDate != todayDate) {
      await prefs.setBool('isClockInDone', false);
      await prefs.setBool('isClockOutDone', false);
      await prefs.setString('lastClockDate', todayDate);

      setState(() {
        _isClockInDone = false;
        _isClockOutDone = false;
      });
    } else {
      _loadClockInStatus();
      _loadClockOutStatus();
    }
  }

  Future<void> _setClockInStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isClockInDone', status);
    setState(() {
      _isClockInDone = status;
    });

    await prefs.setString('lastClockDate', DateFormat('yyyy-MM-dd').format(now));
  }

  Future<void> _setClockOutStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isClockOutDone', status);
    setState(() {
      _isClockOutDone = status;
    });

    await prefs.setString('lastClockDate', DateFormat('yyyy-MM-dd').format(now));
  }

  Future<void> _saveSelectedLocation(String location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLocation', location);
  }

  Future<void> _loadSelectedLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLocation = prefs.getString('selectedLocation');
    });
  }

  Future<void> _saveLocations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('locations', _locations);
  }

  Future<void> _loadLocations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _locations = prefs.getStringList('locations') ?? _locations;
    });
  }

  Future<void> _loadClockInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isClockInDone = prefs.getBool('isClockInDone') ?? false;
    });
  }

  Future<void> _loadClockOutStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isClockOutDone = prefs.getBool('isClockOutDone') ?? false;
    });
  }

  Future<void> _showLocationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pilih Lokasi', textAlign: TextAlign.center),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ..._locations.map((location) {
                    return GestureDetector(
                      child: Row(
                        children: [
                          Radio(
                            value: location,
                            groupValue: _selectedLocation,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedLocation = value;
                              });
                              if (value == 'Lainnya') {
                                setState(() {
                                  _selectedLocation = value;
                                });
                              } else {
                                _saveSelectedLocation(value!);
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                          SizedBox(width: 8),
                          Text(location),
                        ],
                      ),
                    );
                  }).toList(),
                  if (_selectedLocation == 'Lainnya')
                    TextField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Masukkan lokasi baru',
                      ),
                    ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              child: Text('Simpan'),
              onPressed: () {
                if (_selectedLocation == 'Lainnya' &&
                    _locationController.text.isNotEmpty) {
                  String newLocation = _locationController.text;
                  if (!_locations.contains(newLocation)) {
                    setState(() {
                      _selectedLocation = newLocation;
                      _locations.insert(_locations.length - 1, newLocation);
                    });
                    _saveSelectedLocation(newLocation).then((_) {
                      _saveLocations();
                    });
                  }
                } else if (_selectedLocation != null) {
                  _saveSelectedLocation(_selectedLocation!).then((_) {
                    setState(() {});
                  });
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String currentTime = DateFormat('hh:mm a').format(now);
    String currentDate = DateFormat('EEEE, dd MMMM yyyy').format(now);
    bool isClockInTime = now.hour >= 8 && now.hour < 17;
    bool isClockOutTime = now.hour >= 17 || now.hour < 8;
    bool isWithinGracePeriod =
        now.isAfter(DateTime(now.year, now.month, now.day, 8, 0)) &&
        now.isBefore(DateTime(now.year, now.month, now.day, 8, 5));
    bool isLate = now.isAfter(DateTime(now.year, now.month, now.day, 8, 5)) &&
        now.isBefore(DateTime(now.year, now.month, now.day, 17, 0));

  
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: const Color.fromARGB(0, 221, 217, 217),
          flexibleSpace: Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('images/profil.png'),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Morning',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'images/kantor1.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'images/kantor2.jpeg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'images/kantor3.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
               SizedBox(height: 25),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentDate,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showLocationDialog();
                            },
                            child: Icon(Icons.location_on),
                          ),
                          SizedBox(width: 5),
                          Text(
                            _selectedLocation ??
                                'Pilih Lokasi Kantor Kamu Hari Ini',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            color: Color.fromARGB(255, 128, 255, 130),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: Text(
                                isClockInTime ? '08.00' : '17.00',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: Text(
                                currentTime,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      if (isClockInTime && isWithinGracePeriod)
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Toleransi keterlambatan 5 menit',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      if (isClockInTime && isLate)
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Anda sudah terlambat!',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      if (isClockOutTime)
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            'Hati-hati di jalan!',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
     trailing: _selectedLocation != null
                      ? ElevatedButton(
                          onPressed: (isClockInTime && !_isClockInDone) ||
                                  (isClockOutTime && !_isClockOutDone) ||
                                  (_isBreakStartAvailable &&
                                      !_isBreakStartDone) ||
                                  (_isBreakOutAvailable && !_isBreakOutDone)
                              ? () {
                                  if (isClockInTime && !_isClockInDone) {
                                    _setClockInStatus(true);
                                    _isClockInDone = true;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SuccessScreen(
                                            selectedLocation:
                                                _selectedLocation ?? ''),
                                      ),
                                    );
                                  } else if (isClockOutTime &&
                                      !_isClockOutDone) {
                                    _setClockOutStatus(true);
                                    _isClockOutDone = true;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OutScreen(
                                            selectedLocation:
                                                _selectedLocation ?? ''),
                                      ),
                                    );
                                  } else if (_isBreakStartAvailable &&
                                      !_isBreakStartDone) {
                                    _isBreakStartDone = true;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BreakStartScreen(
                                            selectedLocation:
                                                _selectedLocation ?? ''),
                                      ),
                                    );
                                  } else if (_isBreakOutAvailable &&
                                      !_isBreakOutDone) {
                                    _isBreakOutDone = true;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BreakOutScreen(
                                            selectedLocation:
                                                _selectedLocation ?? ''),
                                      ),
                                    );
                                  }
                                }
                              : null, // Disable button if none of the conditions are met
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                (isClockInTime && !_isClockInDone) ||
                                        (isClockOutTime && !_isClockOutDone) ||
                                        (_isBreakStartAvailable &&
                                            !_isBreakStartDone) ||
                                        (_isBreakOutAvailable &&
                                            !_isBreakOutDone)
                                    ? isClockInTime && !_isClockInDone
                                        ? const Color.fromARGB(
                                            255, 112, 210, 255)
                                        : isClockOutTime && !_isClockOutDone
                                            ? Colors.blue[900]
                                            : _isBreakStartAvailable &&
                                                    !_isBreakStartDone
                                                ? Colors.orange
                                                : _isBreakOutAvailable &&
                                                        !_isBreakOutDone
                                                    ? Colors.purple
                                                    : Colors.grey
                                    : Colors.grey, // Set color to grey when button is disabled
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 12),
                          ),
                          child: Text(
                            isClockInTime && !_isClockInDone
                                ? 'Clock In'
                                : isClockOutTime && !_isClockOutDone
                                    ? 'Clock Out'
                                    : _isBreakStartAvailable &&
                                            !_isBreakStartDone
                                        ? 'Break Start'
                                        : _isBreakOutAvailable &&
                                                !_isBreakOutDone
                                            ? 'Break Out'
                                            : 'next hour', // Leave empty if no action is available
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : null,



                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildHorizontalGridItem('images/kerja.png'),
                    _buildHorizontalGridItem('images/gaji.png'),
                    _buildHorizontalGridItem('images/kuisioner.png'),
                    _buildHorizontalGridItem('images/kegiatan.png'),
                    _buildHorizontalGridItem('images/pengajuan.png'),
                    _buildHorizontalGridItem('images/informasi.png'),
                    _buildHorizontalGridItem('images/tugas.png'),
                  ],
                ),
              ),
              SizedBox(height: 22),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 216, 215, 215)),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Schedule',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _seeAllColorSchedule = Colors.red;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PresensiScreen(),
                              ),
                            ).then((_) {
                              setState(() {
                                _seeAllColorSchedule = Colors.black;
                              });
                            });
                          },
                          child: MouseRegion(
                            onHover: (event) {
                              setState(() {
                                _seeAllColorSchedule = Colors.lightBlue;
                              });
                            },
                            onExit: (event) {
                              setState(() {
                                _seeAllColorSchedule = Colors.black;
                              });
                            },
                            child: Text(
                              'See all',
                              style: TextStyle(
                                fontSize: 16,
                                color: _seeAllColorSchedule,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.collections_bookmark_outlined,
                            color: Colors.blue[400]),
                        SizedBox(width: 8),
                        Text('Zoom'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.share_location_rounded,
                            color: Colors.blue[400]),
                        SizedBox(width: 8),
                        Text('PT Maju Kemenangan'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_month, color: Colors.blue[400]),
                        SizedBox(width: 8),
                        Text('Wednesday, 08 August, 2024'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.av_timer, color: Colors.blue[400]),
                        SizedBox(width: 8),
                        Text('09:00 AM - 11:50 AM'),
                      ],
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8DC400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Detail Schedule',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 216, 215, 215)),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Announcement',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _seeAllColorAnnouncement = Colors.red;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InformationScreen(),
                              ),
                            ).then((_) {
                              setState(() {
                                _seeAllColorAnnouncement = Colors.black;
                              });
                            });
                          },
                          child: MouseRegion(
                            onHover: (event) {
                              setState(() {
                                _seeAllColorAnnouncement = Colors.lightBlue;
                              });
                            },
                            onExit: (event) {
                              setState(() {
                                _seeAllColorAnnouncement = Colors.black;
                              });
                            },
                            child: Text(
                              'See all',
                              style: TextStyle(
                                fontSize: 16,
                                color: _seeAllColorAnnouncement,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.collections_bookmark_outlined,
                            color: Colors.blue[400]),
                        SizedBox(width: 8),
                        Text('Workshop internal keamanan cyber'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_month, color: Colors.blue[400]),
                        SizedBox(width: 8),
                        Text('Monday, 01 October, 2024'),
                      ],
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8DC400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Detail announcement',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 216, 215, 215)),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Task',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _seeAllColorTask = Colors.red;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TugasScreen(),
                              ),
                            ).then((_) {
                              setState(() {
                                _seeAllColorTask = Colors.black;
                              });
                            });
                          },
                          child: MouseRegion(
                            onHover: (event) {
                              setState(() {
                                _seeAllColorTask = Colors.lightBlue;
                              });
                            },
                            onExit: (event) {
                              setState(() {
                                _seeAllColorTask = Colors.black;
                              });
                            },
                            child: Text(
                              'See all',
                              style: TextStyle(
                                fontSize: 16,
                                color: _seeAllColorTask,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 8),
                        Text('Tugas . Sisa 2'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.collections_bookmark_outlined,
                            color: Colors.blue[400]),
                        SizedBox(width: 8),
                        Text('Konten Marketing'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_month, color: Colors.blue[400]),
                        SizedBox(width: 8),
                        Text('Friday, 12 August, 2024'),
                      ],
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8DC400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Detail Task',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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

  Widget _buildHorizontalGridItem(String imagePath) {
    return GestureDetector(
      onTap: () {
        if (imagePath == 'images/pengajuan.png') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PengajuanScreen()));
        } else if (imagePath == 'images/kerja.png') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SchedulePage()));
        } else if (imagePath == 'images/kegiatan.png') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ActivitiesScreen()));
        } else if (imagePath == 'images/gaji.png') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => GajiScreen()));
        } else if (imagePath == 'images/tugas.png') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TugasScreen()));
        } else if (imagePath == 'images/kuisioner.png') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => QuestionnaireScreen()));
        } else if (imagePath == 'images/informasi.png') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => InformationScreen()));
        }
      },
      child: Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Image.asset(imagePath, width: 90, height: 90),
        ),
      ),
    );
  }
}

class _getButtonText {
}

class _getButtonColor {
}
