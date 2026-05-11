import 'package:flutter/material.dart';
import 'package:tabyan1/image_screen.dart';
import 'package:tabyan1/color_screen.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2D0A1A), Color(0xFF1A0510), Color(0xFF0D0208)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar مخصص
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Color(0xFFF9F7F8),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'اختر الخلفية',
                        style: TextStyle(
                          color: Color(0xFFF9F7F8),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Almarai",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48), // توازن للـ IconButton
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),

                      // عنوان مع أيقونة
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD4AF37).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.auto_fix_high_rounded,
                              color: Color(0xFFD4AF37),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'كيف تريد خلفية التصميم؟',
                            style: TextStyle(
                              color: const Color(0xFFF9F7F8).withOpacity(0.9),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Almarai",
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 50),

                      // بطاقة الصور مع ظل
                      _buildChoiceCard(
                        context,
                        icon: Icons.image_outlined,
                        title: 'صورة',
                        subtitle: 'اختر من معرض الصور',
                        gradientColors: const [
                          Color.fromARGB(255, 72, 3, 3),
                          Color.fromARGB(255, 91, 4, 54),
                        ],
                        onTap: () => Navigator.push(
                          context,
                          _buildPageRoute(ImageScreen()),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // بطاقة الألوان مع ظل
                      _buildChoiceCard(
                        context,
                        icon: Icons.palette_outlined,
                        title: 'لون',
                        subtitle: 'اختر لون خلفية',
                        gradientColors: const [
                          Color.fromARGB(255, 64, 16, 1),
                          Color.fromARGB(255, 88, 5, 58),
                        ],
                        onTap: () => Navigator.push(
                          context,
                          _buildPageRoute(const ColorScreen()),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          splashColor: gradientColors[0],
          highlightColor: gradientColors[0],
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                
                colors: [const Color(0xFFFDFCFD), const Color(0xFFF5F3F4)
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFD4AF37),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // أيقونة متدرجة
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: gradientColors,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: gradientColors[0],
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                        
                      ),
                    ],
                  ),
                  child: Icon(icon, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF2D0A1A),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Almarai",
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: const Color(0xFF2D0A1A),
                          fontSize: 14,
                          fontFamily: "Almarai",
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xFFD4AF37),
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // انتقال متحرك بين الشاشات
  PageRouteBuilder _buildPageRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}
