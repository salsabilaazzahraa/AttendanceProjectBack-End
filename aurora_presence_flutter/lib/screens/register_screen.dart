import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'images/bg3.jpg',
              fit: BoxFit.cover,
              height: 300,
            ),
          ),
          // Main Content Container
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Welcome! Register your account to get started with Aurora Presence App',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    // Input Email
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          hintText: 'Masukkan Email Anda',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Input Username
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          hintText: 'Masukkan Username Anda',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Input Password
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
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(
                            Icons.visibility,
                            color: Colors.grey,
                          ),
                          hintText: 'Masukkan Password Anda',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Confirm Password
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
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          hintText: 'Confirm Password Anda',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Register Button
                    GestureDetector(
                      onTap: () {
                        // Handle Register button tap
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0546FF),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Center(
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
