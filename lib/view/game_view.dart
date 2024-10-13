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
        title: Text(
          'XO Game',
          style: GoogleFonts.prompt(color: Colors.black54),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
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
          ),
          Obx(() {
            if (controller.gameOver.value) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
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
                      controller.resetGame();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.replay_rounded,
                            color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          'เริ่มเกมส์ใหม่',
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
              );
            } else {
              return Container();
            }
          })
        ],
      ),
    );
  }
}
