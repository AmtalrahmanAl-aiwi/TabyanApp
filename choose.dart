import 'package:flutter/material.dart';
// استيراد الملفات الخارجية
//import 'image_screen.dart';
//import 'color_screen.dart';

class Choose extends StatelessWidget {
  const Choose({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 39, 2, 40),
      appBar: AppBar(
        title: const Text('اختر الخلفية'),
        backgroundColor: const Color.fromARGB(255, 39, 2, 40),
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
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // الكارد الأول: يوجه لـ imag
            _buildChoiceCard(
              context,
              icon: Icons.image_outlined,
              title: 'صورة',
              subtitle: 'اختر من معرض الصور',
              ontap: () {
                //Navigator.push(
                //  context,
                //  MaterialPageRoute(builder: (context) => const image_screen()),
                // );
              },
            ),

            const SizedBox(height: 16),

            // الكارد الثاني: يوجه لـ color
            _buildChoiceCard(
              context,
              icon: Icons.palette_outlined,
              title: 'لون',
              subtitle: 'اختر لون خلفية',
              ontap: () {
                //Navigator.push(
                //   context,
                //  MaterialPageRoute(builder: (context) => const color()),
                //  );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ويدجت بناء الكارد بتنسيق يتناسب مع الخلفية الداكنة
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
          // استخدام لون أبيض بشفافية ليظهر النص الأبيض فوقه
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white12, width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white10,
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
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white30,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
