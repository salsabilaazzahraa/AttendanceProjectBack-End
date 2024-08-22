import 'package:flutter/material.dart';
import 'package:aurora_presence_flutter/models/personal.dart';
import 'package:aurora_presence_flutter/services/personal_service.dart';

class EditPersonalInfoScreen extends StatefulWidget {
  final Personal personal;

  EditPersonalInfoScreen({required this.personal});

  @override
  _EditPersonalInfoScreenState createState() => _EditPersonalInfoScreenState();
}

class _EditPersonalInfoScreenState extends State<EditPersonalInfoScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  // Add other controllers as needed
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.personal.name);
    _phoneNumberController = TextEditingController(text: widget.personal.phoneNumber);
    // Initialize other controllers
  }

  Future<void> _savePersonalInfo() async {
    try {
      Personal updatedPersonal = Personal(
        id: widget.personal.id,
        name: _nameController.text,
        phoneNumber: _phoneNumberController.text,
        dateOfBirth: widget.personal.dateOfBirth,
        gender: widget.personal.gender,
        address: widget.personal.address,
        emergencyNumber: widget.personal.emergencyNumber,
        employeeId: widget.personal.employeeId,
        department: widget.personal.department,
        position: widget.personal.position,
      );
      await apiService.updatePersonalInfo(updatedPersonal.id, updatedPersonal);
      Navigator.pop(context, updatedPersonal);
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Personal Information'),
        backgroundColor: Color(0xFF00CEE8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildTextField('Name', _nameController),
            buildTextField('Phone Number', _phoneNumberController),
            // Add other fields as needed
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _savePersonalInfo,
              child: Text('Save'),
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00CEE8)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
