import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 55, 35, 43),
      body: Center(
        child: Text(
          'تطبيق تبيان',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Color.fromARGB(252, 247, 254, 253),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0), // لإضافة مساحة حول الزر
        child: ElevatedButton(
          onPressed: () {
            //
          },
          child: const Text('ابدأ التصميم'),
        ),
      ),
    );
  }
}
