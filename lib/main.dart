import 'package:flutter/material.dart';
import 'package:gamexo/view/game_view.dart';
import 'package:gamexo/view/home_view.dart';
import 'package:gamexo/view/replay_board_view.dart';
import 'package:gamexo/view/replay_view.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'XO Game',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeView()),
        GetPage(name: '/game', page: () => GameView()),
        GetPage(name: '/replay', page: () => ReplayView()),
        GetPage(name: '/replayboard', page: () => ReplayBoardView()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
