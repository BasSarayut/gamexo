import 'dart:math';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

class GameController extends GetxController{
  var board = RxList<String>(List.filled(9, ''));
  var currentPlayer = 'X'.obs;
  var gameOver = false.obs;

    void makeMove(int index) {
    if (board[index] == '' && !gameOver.value) {
      board[index] = currentPlayer.value;
      if (checkWin(currentPlayer.value)) {
        gameOver.value = true;
        saveGame(currentPlayer.value);
        Get.snackbar('Game Over', '${currentPlayer.value} Wins!');
      } else if (!board.contains('')) {
        gameOver.value = true;
        saveGame('Draw');
        Get.snackbar('Game Over', 'It\'s a Draw!');
      } else {
        switchPlayer();
        if (currentPlayer.value == 'O') {
          botMove();
        }
      }
    }
  }


  void botMove() {
    Future.delayed(const Duration(milliseconds: 200), () {
      var emptyIndexes = <int>[];
      for (int i = 0; i < board.length; i++) {
        if (board[i] == '') emptyIndexes.add(i);
      }
      if (emptyIndexes.isNotEmpty) {
        var randomIndex =
            emptyIndexes[Random().nextInt(emptyIndexes.length)];
        board[randomIndex] = currentPlayer.value;
        if (checkWin(currentPlayer.value)) {
          gameOver.value = true;
          saveGame(currentPlayer.value);
          Get.snackbar('Game Over', '${currentPlayer.value} Wins!');
        } else if (!board.contains('')) {
          gameOver.value = true;
          saveGame('Draw');
          Get.snackbar('Game Over', 'It\'s a Draw!');
        } else {
          switchPlayer();
        }
      }
    });
  }

  void switchPlayer() {
    currentPlayer.value = currentPlayer.value == 'X' ? 'O' : 'X';
  }

  bool checkWin(String player) {
    // ตรวจสอบแนวชนะ
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8], // แนวนอน
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8], // แนวตั้ง
      [0, 4, 8],
      [2, 4, 6], // แนวทแยง
    ];
    for (var pattern in winPatterns) {
      if (board[pattern[0]] == player &&
          board[pattern[1]] == player &&
          board[pattern[2]] == player) {
        return true;
      }
    }
    return false;
  }

  void saveGame(String result) async {
    var gameBox = await Hive.openBox('game_history');
    gameBox.add({
      'board': board.toList(),
      'result': result,
      'date': DateTime.now(),
    });
  }

  void resetGame() {
    board.value = List.filled(9, '');
    currentPlayer.value = 'X';
    gameOver.value = false;
  }
}
