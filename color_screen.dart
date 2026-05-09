import 'package:flutter/material.dart';
import 'package:tabyan1/design_screen.dart';

class ColorScreen extends StatefulWidget {
  const ColorScreen({super.key});

  @override
  State<ColorScreen> createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {
  final ScrollController _scrollController = ScrollController();

  final List<Color> colors = [
    const Color(0xFFE53935), const Color(0xFFD81B60),
    const Color(0xFF8E24AA), const Color(0xFF5E35B1),
    const Color(0xFF3949AB), const Color(0xFF1E88E5),
    const Color(0xFF039BE5), const Color(0xFF00ACC1),
    const Color(0xFF00897B), const Color(0xFF43A047),
    const Color(0xFF7CB342), const Color(0xFFC0CA33),
    const Color(0xFFFDD835), const Color(0xFFFFB300),
    const Color(0xFFFB8C00), const Color(0xFFF4511E),
    const Color(0xFF6D4C41), const Color(0xFF757575),
    const Color(0xFF546E7A), const Color(0xFF263238),
    const Color(0xFF1A237E), const Color(0xFF004D40),
    const Color(0xFF3E2723), const Color(0xFF212121),
  ];

  Color? selectedColor;

  void _goToDesignScreen(Color color) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => DesignScreen(backgroundColor: color),
      ),
      (route) => route.isFirst,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2D0A1A),
              Color(0xFF1A0510),
              Color(0xFF0D0208),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'اختر لون الخلفية',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Almarai",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              
              const SizedBox(height: 10),
              
             
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 32),
                  child: RawScrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    trackVisibility: true,
                    interactive: true,
                    thickness: 8,
                    radius: const Radius.circular(10),
                    thumbColor: const Color(0xFFD4AF37),
                    trackColor: const Color(0xFFD4AF37).withOpacity(0.15),
                    minThumbLength: 40,
                    child: GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(right: 12, top: 4, bottom: 4),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 1,
                      ),
                      itemCount: colors.length,
                      itemBuilder: (context, index) {
                        final color = colors[index];
                        final isSelected = selectedColor == color;
                        
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColor = color;
                            });
                          },
                          onDoubleTap: () => _goToDesignScreen(color),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFFD4AF37),
                                        blurRadius: 20,
                                        spreadRadius: 3,
                                      ),
                                      BoxShadow(
                                        color: color,
                                        blurRadius: 25,
                                        spreadRadius: 8,
                                      ),
                                    ]
                                  : [
                                      BoxShadow(
                                        color: color.withOpacity(0.2),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                              border: isSelected
                                  ? Border.all(
                                      color: const Color(0xFFD4AF37),
                                      width: 3,
                                    )
                                  : null,
                            ),
                            child: isSelected
                                ? const Center(
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              if (selectedColor != null)
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFD4AF37), Color(0xFFB8860B)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFD4AF37).withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => _goToDesignScreen(selectedColor!),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ابدأ التصميم',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Almarai",
                                ),
                              ),
                              SizedBox(width: 12),
                              Icon(
                                Icons.brush,
                                color: Colors.white,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}