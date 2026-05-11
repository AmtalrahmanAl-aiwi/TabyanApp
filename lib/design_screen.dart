import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DesignScreen extends StatefulWidget {
  final String? selectedImage;
  final Color? backgroundColor;

  const DesignScreen({
    super.key,
    this.selectedImage,
    this.backgroundColor,
  });

  @override
  State<DesignScreen> createState() => _DesignScreenState();
}

class _DesignScreenState extends State<DesignScreen> {
  final ScrollController _scrollController = ScrollController();
  
  List<dynamic> ayat = []; 
  List<dynamic> filteredAyat = [];
  String? selectedSurah;
  
  String displayText = 'بسم الله الرحمن الرحيم';
  double textOpacity = 1.0;
  Color textColor = Colors.white;
  double fontSize = 28;
  
  // خط الآيات ثابت (عثماني)
  static const String quranFont = 'Amiri';
  
  // خط النصوص العادية (قابل للتغيير)
  String normalFont = 'Almarai';
  
  // هل النص الحالي آية؟
  bool isAyahSelected = false;
  
  // كل الخطوط المتاحة للنصوص العادية
  final List<String> fonts = ['Almarai', 'ArabSwell', 'Amiri', 'Scheherazade', 'Setareh', 'Cairo'];
  
  final List<Color> textColors = [
    Colors.white,
    Colors.black,
    const Color(0xFFD4AF37),
    const Color(0xFF2D0A1A),
    const Color(0xFF1A237E),
    const Color(0xFF004D40),
    const Color(0xFFBF360C),
  ];

  @override
  void initState() {
    super.initState();
    loadAyat();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> loadAyat() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data.json');
      final List<dynamic> data = json.decode(jsonString);
      setState(() {
        ayat = data;
        filteredAyat = List.from(data);
      });
    } catch (e) {
      debugPrint('Error loading ayat: $e');
    }
  }

  void filterAyat(String search) {
    setState(() {
      if (search.isEmpty) {
        filteredAyat = List.from(ayat);
      } else {
        filteredAyat = ayat.where((ayah) {
          final text = ayah['text']?.toString().toLowerCase() ?? '';
          final surah = ayah['surah']?.toString().toLowerCase() ?? '';
          final query = search.toLowerCase();
          return text.contains(query) || surah.contains(query);
        }).toList();
      }
    });
  }

  void showAyahSearch() {
    setState(() {
      filteredAyat = List.from(ayat);
    });
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Color(0xFF1A0510),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: StatefulBuilder(
          builder: (context, setModalState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Color(0xFFD4AF37)),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'البحث في الآيات',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Almarai',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    style: const TextStyle(color: Colors.white, fontFamily: 'Almarai'),
                    decoration: InputDecoration(
                      hintText: 'اكتب كلمة من الآية أو اسم السورة...',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                      filled: true,
                      fillColor: const Color(0xFF2D0A1A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.search, color: Color(0xFFD4AF37)),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filterAyat(value);
                      });
                      setModalState(() {});
                    },
                  ),
                ),
                
                const SizedBox(height: 10),
                
                Expanded(
                  child: RawScrollbar(
                    thumbVisibility: true,
                    trackVisibility: true,
                    interactive: true,
                    thickness: 6,
                    radius: const Radius.circular(10),
                    thumbColor: const Color(0xFFD4AF37),
                    trackColor: const Color(0xFFD4AF37).withOpacity(0.1),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredAyat.length,
                      itemBuilder: (context, index) {
                        final ayah = filteredAyat[index];
                        return ListTile(
                          onTap: () {
                            setState(() {
                              displayText = ayah['text'] ?? '';
                              selectedSurah = '${ayah['surah']} - الآية ${ayah['ayah']}';
                              isAyahSelected = true;  // ← آية
                            });
                            Navigator.pop(context);
                          },
                          leading: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD4AF37).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                '${ayah['ayah']}',
                                style: const TextStyle(
                                  color: Color(0xFFD4AF37),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            ayah['text'] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Almarai',
                              fontSize: 15,
                              height: 1.5,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.rtl,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              'سورة ${ayah['surah']}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontFamily: 'Almarai',
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void showTextEditor() {
    final TextEditingController controller = TextEditingController(text: displayText);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A0510),
        title: const Text(
          'تعديل النص',
          style: TextStyle(color: Colors.white, fontFamily: 'Almarai'),
        ),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white, fontFamily: 'Almarai'),
          maxLines: 5,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF2D0A1A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                displayText = controller.text;
                isAyahSelected = false;  // ← نص عادي
              });
              Navigator.pop(context);
            },
            child: const Text(
              'حفظ',
              style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void showColorPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A0510),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'اختر لون النص',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Almarai',
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: textColors.map((color) {
                final isSelected = textColor == color;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      textColor = color;
                    });
                    Navigator.pop(context);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? Border.all(color: const Color(0xFFD4AF37), width: 3)
                          : null,
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.4),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void showFontPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A0510),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'اختر الخط',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Almarai',
              ),
            ),
            const SizedBox(height: 20),
            // عرض جميع الخطوط للنصوص العادية
            ...fonts.map((font) => ListTile(
              onTap: () {
                setState(() {
                  normalFont = font;  // ← تغيير خط النص العادي
                });
                Navigator.pop(context);
              },
              leading: Icon(
                font == normalFont ? Icons.check_circle : Icons.circle_outlined,
                color: const Color(0xFFD4AF37),
              ),
              title: Text(
                font,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: font,
                  fontSize: 18,
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  void saveDesign() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'تم حفظ التصميم!',
          style: TextStyle(fontFamily: 'Almarai'),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color(0xFFD4AF37),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  ImageProvider? getBackgroundImage() {
    if (widget.selectedImage == null) return null;
    
    if (widget.selectedImage!.startsWith('assets/')) {
      return AssetImage(widget.selectedImage!);
    }
    
    return FileImage(File(widget.selectedImage!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0208),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF2D0A1A),
                  const Color(0xFF2D0A1A).withOpacity(0.8),
                ],
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                ),
                const Expanded(
                  child: Text(
                    'التصميم',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Almarai',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  onPressed: saveDesign,
                  icon: const Icon(Icons.save_alt_rounded, color: Color(0xFFD4AF37)),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                constraints: const BoxConstraints(
                  maxWidth: 400,
                  maxHeight: 600,
                ),
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? const Color(0xFF3D1025),
                  borderRadius: BorderRadius.circular(20),
                  image: getBackgroundImage() != null
                      ? DecorationImage(
                          image: getBackgroundImage()!,
                          fit: BoxFit.cover,
                        )
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: (widget.backgroundColor ?? Colors.black).withOpacity(0.4),
                      blurRadius: 25,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: widget.selectedImage != null
                        ? Colors.black.withOpacity(0.3)
                        : null,
                    padding: const EdgeInsets.all(30),
                    child: Center(
                      child: Opacity(
                        opacity: textOpacity,
                        child: Text(
                          displayText,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          // ← هنا الفرق: آية vs نص عادي
                          style: TextStyle(
                            fontFamily: isAyahSelected ? quranFont : normalFont,
                            color: textColor,
                            fontSize: fontSize,
                            fontWeight: FontWeight.normal,
                            height: isAyahSelected ? 2.2 : 1.5,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  const Color(0xFF1A0510),
                  const Color(0xFF1A0510).withOpacity(0.9),
                ],
              ),
              border: const Border(
                top: BorderSide(color: Color(0xFFD4AF37), width: 0.5),
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildToolButton(
                      icon: Icons.search_rounded,
                      label: 'آية',
                      onTap: showAyahSearch,
                    ),
                    
                    const SizedBox(width: 12),
                    
                    _buildToolButton(
                      icon: Icons.edit_note_rounded,
                      label: 'نص',
                      onTap: showTextEditor,
                    ),
                    
                    const SizedBox(width: 12),
                    
                    _buildToolButton(
                      icon: Icons.color_lens_rounded,
                      label: 'لون',
                      onTap: showColorPicker,
                      color: textColor,
                    ),
                    
                    const SizedBox(width: 12),
                    
                    _buildSliderButton(
                      icon: Icons.opacity_rounded,
                      label: 'شفافية',
                      value: textOpacity,
                      min: 0.1,
                      max: 1.0,
                      divisions: 9,
                      onChanged: (value) {
                        setState(() {
                          textOpacity = value;
                        });
                      },
                    ),
                    
                    const SizedBox(width: 12),
                    
                    _buildSliderButton(
                      icon: Icons.format_size_rounded,
                      label: 'الحجم',
                      value: fontSize,
                      min: 16,
                      max: 72,
                      divisions: 28,
                      onChanged: (value) {
                        setState(() {
                          fontSize = value;
                        });
                      },
                    ),
                    
                    const SizedBox(width: 12),
                    
                    _buildToolButton(
                      icon: Icons.font_download_rounded,
                      label: 'خط',
                      onTap: showFontPicker,
                    ),
                    
                    const SizedBox(width: 12),
                    
                    _buildToolButton(
                      icon: Icons.save_rounded,
                      label: 'حفظ',
                      onTap: saveDesign,
                      isGold: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
    bool isGold = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isGold
              ? const Color(0xFFD4AF37).withOpacity(0.2)
              : const Color(0xFF2D0A1A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isGold ? const Color(0xFFD4AF37) : Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color ?? (isGold ? const Color(0xFFD4AF37) : Colors.white),
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isGold ? const Color(0xFFD4AF37) : Colors.white.withOpacity(0.8),
                fontSize: 11,
                fontFamily: 'Almarai',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderButton({
    required IconData icon,
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
  }) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: const Color(0xFF1A0510),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => StatefulBuilder(
            builder: (context, setModalState) => Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label == 'شفافية' ? 'شفافية النص' : 'حجم الخط',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Almarai',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    label == 'شفافية' 
                        ? '${(value * 100).toInt()}%'
                        : '${value.toInt()}',
                    style: const TextStyle(
                      color: Color(0xFFD4AF37),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Slider(
                    value: value,
                    min: min,
                    max: max,
                    divisions: divisions,
                    activeColor: const Color(0xFFD4AF37),
                    inactiveColor: Colors.white.withOpacity(0.2),
                    onChanged: (newValue) {
                      setModalState(() {
                        onChanged(newValue);
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF2D0A1A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(height: 4),
            Text(
              label == 'شفافية' 
                  ? '${(value * 100).toInt()}%'
                  : '${value.toInt()}',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 11,
                fontFamily: 'Almarai',
              ),
            ),
          ],
        ),
      ),
    );
  }
}