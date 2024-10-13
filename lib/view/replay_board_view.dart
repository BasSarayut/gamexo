import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class ReplayBoardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> board = Get.arguments[0];
    final String result = Get.arguments[1];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'กระดานเกม',
          style: GoogleFonts.prompt(color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Text(
                    board[index],
                    style: GoogleFonts.prompt(
                      fontSize: 36,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Text(
            'ผลลัพธ์: $result',
            style: GoogleFonts.prompt(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
