// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const JankenPage(),
    );
  }
}

class JankenPage extends StatefulWidget {
  const JankenPage({super.key});

  @override
  State<JankenPage> createState() => _JankenPageState();
}

class _JankenPageState extends State<JankenPage> {
  Icon computerHand = Icon(Icons.sports_mma_outlined);
  Icon myHand = Icon(Icons.sports_mma_outlined);
  String result = '引き分け';
  num battleCount = 0;
  num winCount = 0;
  num winRate = 0;

  void generateComputerHand() {
    Random().nextInt(3);
    final randomNum = Random().nextInt(3);
    computerHand = randomNumToHand(randomNum);
  }

  Icon randomNumToHand(int randomNum) {
    switch (randomNum) {
      case 0:
        return Icon(Icons.sports_mma_outlined);
      case 1:
        return Icon(Icons.pan_tool_alt_outlined);
      case 2:
        return Icon(Icons.back_hand_outlined);
      default:
        return Icon(Icons.sports_mma_outlined);
    }
  }

  void setMyHand(Icon setMyHand) {
    myHand = setMyHand;
    generateComputerHand();
    judge();
    battleCount++;
    winRateCalc();
    setState(() {});
  }

  void judge() {
    if (myHand.icon == computerHand.icon) {
      result = '引き分け';
    } else if (myHand.icon == Icons.sports_mma_outlined &&
            computerHand.icon == Icons.pan_tool_alt_outlined ||
        myHand.icon == Icons.pan_tool_alt_outlined &&
            computerHand.icon == Icons.back_hand_outlined ||
        myHand.icon == Icons.back_hand_outlined &&
            computerHand.icon == Icons.sports_mma_outlined) {
      result = '勝ち';
      winCount++;
    } else {
      result = '負け';
    }
  }

  void winRateCalc() {
    if (battleCount == 0) {
      winRate = 0;
    } else {
      winRate = (((winCount) / (battleCount) * 100).round());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('じゃんけん'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${winCount.toString()} / ${battleCount.toString()}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '勝率: ${winRate.toString()} %',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '結果: $result',
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 48),
            computerHand,
            SizedBox(height: 48),
            myHand,
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setMyHand(Icon(Icons.sports_mma_outlined));
                  },
                  child: Icon(Icons.sports_mma_outlined,
                      color: Colors.red, size: 32),
                ),
                ElevatedButton(
                  onPressed: () {
                    setMyHand(Icon(Icons.pan_tool_alt_outlined));
                  },
                  child: Icon(Icons.pan_tool_alt_outlined,
                      color: Colors.green, size: 32),
                ),
                ElevatedButton(
                  onPressed: () {
                    setMyHand(Icon(Icons.back_hand_outlined));
                  },
                  child: Icon(Icons.back_hand_outlined,
                      color: Colors.blue, size: 28),
                ),
              ],
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                battleCount = 0;
                winCount = 0;
                winRate = 0;
                setState(() {});
              },
              child: Text('リセット'),
            ),
          ],
        ),
      ),
    );
  }
}
