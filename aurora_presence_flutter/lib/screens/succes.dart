import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SuccessScreen extends StatelessWidget {
  final String selectedLocation;

  const SuccessScreen({Key? key, required this.selectedLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, dd MMMM yyyy', 'en_US')
        .format(now); // Menggunakan locale en_US untuk bahasa Inggris
    String formattedTime =
        DateFormat('hh:mm a').format(now); // Memastikan format waktu AM/PM

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.cyan,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Check-in',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Clock In Success',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24),
                  _buildInfoRow('Date:', formattedDate),
                  _buildInfoRow('Time:', formattedTime),
                  _buildInfoRow('Location:', selectedLocation),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Yeah, Mengerti',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      minimumSize: Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
