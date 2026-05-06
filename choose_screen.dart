import 'package:flutter/material.dart';
import 'package:tabyan1/image_screen.dart';
import 'package:tabyan1/color_screen.dart';


class ChooseScreen extends StatelessWidget {
  const ChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 39, 2, 40),
      appBar: AppBar(
        title: const Text(
          'اختر الخلفية',
          style: TextStyle(fontFamily: "Almarai"),
        ),
        backgroundColor: Color.fromARGB(255, 39, 2, 40),
        centerTitle: true,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'كيف تريد خلفية التصميم؟',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: "Almarai",
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildChoiceCard(
              context,
              icon: Icons.image_outlined,
              title: 'صورة',
              subtitle: 'اختر من معرض الصور',
              ontap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ImageScreen()),
              ),
            ),

            const SizedBox(height: 16),

            _buildChoiceCard(
              context,
              icon: Icons.palette_outlined,
              title: 'لون',
              subtitle: 'اختر لون خلفية',
              ontap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ColorScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback ontap,
  }) {
    return InkWell(
      onTap: ontap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color.fromARGB(255, 23, 0, 20),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(253, 43, 1, 34),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white70, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color.fromARGB(253, 43, 1, 34),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color.fromARGB(253, 43, 1, 34),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color.fromARGB(245, 21, 0, 20),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
