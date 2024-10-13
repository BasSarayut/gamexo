import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    // สร้าง AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat(); // ทำให้วนลูปไม่รู้จบ

    // สร้าง Animation ที่เปลี่ยนจาก 0 ถึง 2π
    _animation = Tween(begin: 0.0, end: 2 * pi).animate(_controller);
  }

  @override
  void dispose() {
    // ปล่อยหน่วยความจำเมื่อไม่ใช้งาน
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'XO Game Home',
          style: GoogleFonts.prompt(color: Colors.white), // ตั้งค่าสีข้อความเป็นสีขาว
        ),
        backgroundColor: Colors.transparent, // ทำให้พื้นหลังโปร่งใส
        elevation: 0, // ลบเงา
        centerTitle: true, // ตั้งค่าให้อยู่ตรงกลาง (ถ้าต้องการ)
        iconTheme: IconThemeData(color: Colors.white), // ตั้งค่าสีไอคอน
        // ตั้งค่า systemOverlayStyle เพื่อปรับสีของ status bar
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      extendBodyBehindAppBar: true,
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.purpleAccent,
                  Colors.redAccent,
                ],
                stops: [0.0, 0.5, 1.0],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                transform: GradientRotation(_animation.value),
              ),
            ),
            child: child,
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ปุ่มเริ่มเกม
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.blueAccent,
                  ),
                  onPressed: () {
                    Get.toNamed('/game');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.gamepad_outlined, color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        'เริ่มเกมส์',
                        style: GoogleFonts.prompt(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // ปุ่มดูประวัติการเล่น
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.grey,
                  ),
                  onPressed: () {
                    Get.toNamed('/replay');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.history_rounded, color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        'ดูประวัติการเล่น',
                        style: GoogleFonts.prompt(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
}
