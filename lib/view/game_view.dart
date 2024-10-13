import 'package:flutter/material.dart';
import 'package:gamexo/controller/game_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GameView extends StatelessWidget {
  final GameController controller = Get.put(GameController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('XO Game',style: GoogleFonts.prompt(
          color: Colors.black54
        ),),
      ),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: 9,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              controller.makeMove(index);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Obx(() => Text(
                      controller.board[index],
                      style: GoogleFonts.prompt(fontSize: 60),
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
