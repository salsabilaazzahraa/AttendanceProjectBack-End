import 'package:flutter/material.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  const ConfirmPasswordScreen({super.key});

  @override
  _ConfirmPasswordScreenState createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'images/bg3.jpg', // Sesuaikan dengan gambar background Anda
              fit: BoxFit.cover,
              height: 300,
            ),
          ),
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F2F2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'Confirm New Password',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Enter your email to receive an email to reset your password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_open,
                          color: Colors.grey,
                        ),
                        hintText: 'Masukkan New Password Anda',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.grey,
                        ),
                        hintText: 'Confirm password Anda',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0546FF),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: Text(
                        'Send',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
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
}
