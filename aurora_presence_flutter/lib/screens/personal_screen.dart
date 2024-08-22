import 'package:flutter/material.dart';
import 'package:aurora_presence_flutter/models/personal.dart';
import 'package:aurora_presence_flutter/services/personal_service.dart';
import 'edit_personal_info_screen.dart';

class PersonalScreen extends StatefulWidget {
  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  Personal? personal;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadPersonalInfo();
  }

  Future<void> _loadPersonalInfo() async {
    try {
      Personal fetchedPersonal = await apiService.fetchPersonalInfo(1); // Replace with actual userId
      setState(() {
        personal = fetchedPersonal;
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
        backgroundColor: Color(0xFF00CEE8),
      ),
      body: personal == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${personal!.name}'),
                  Text('Phone Number: ${personal!.phoneNumber}'),
                  // Add other fields as needed
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPersonalInfoScreen(personal: personal!),
                        ),
                      ).then((updatedPersonal) {
                        if (updatedPersonal != null) {
                          setState(() {
                            personal = updatedPersonal;
                          });
                        }
                      });
                    },
                    child: Text('Edit Information'),
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00CEE8)),
                  ),
                ],
              ),
            ),
    );
  }
}
