import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isClicked = false;
  bool isHovering = false;

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
              'images/bg3.jpg',
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
              decoration: const BoxDecoration(
                color: Color(0xFFF5F2F2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Welcome! Register your account to get started with Aurora Presence App',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
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
                    GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          isClicked = true;
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          isClicked = false;
                          isHovering = false;
                        });
                      },
                      child: MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            isHovering = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            isHovering = false;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 100.0,
                          ),
                          decoration: BoxDecoration(
                            color: isClicked
                                ? const Color(0xFF00CEE8)
                                : (isHovering
                                    ? Colors.white
                                    : const Color(0xFF0546FF)),
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                              color: isClicked
                                  ? Colors.white
                                  : const Color(0xFF0546FF),
                              width: 2.0,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: isHovering
                                    ? const Color(0xFF0546FF)
                                    : Colors.white,
                                fontSize: 18,
                              ),
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
