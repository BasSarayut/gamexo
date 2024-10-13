import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class ReplayView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ประวัติการเล่น',
          style: GoogleFonts.prompt(color: Colors.black),
        ),
      ),
      body: FutureBuilder(
        future: Hive.openBox('game_history'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var gameBox = Hive.box('game_history');

            if (gameBox.isEmpty) {
              return Center(
                child: Text(
                  'ไม่มีประวัติ',
                  style: GoogleFonts.prompt(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: gameBox.length,
                itemBuilder: (context, index) {
                  var game = gameBox.getAt(index);
                  return ListTile(
                    title: game['result'] == 'Draw'
                        ? Text(
                            'เกมที่ ${index + 1}: เสมอกัน 😢',
                            style: GoogleFonts.prompt(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        : Text(
                            'เกมที่ ${index + 1}: ${game['result']} เป็นฝ่ายชนะ 🎉',
                            style: GoogleFonts.prompt(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                    subtitle: Text(
                      game['date'].toString(),
                      style: GoogleFonts.prompt(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    onTap: () {
                      Get.toNamed('/replayboard',
                          arguments: [game['board'], game['result']]);
                    },
                  );
                },
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'มีบางอย่างเกิดข้อผิดพลาด',
                style: GoogleFonts.prompt(
                    fontSize: 18,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
