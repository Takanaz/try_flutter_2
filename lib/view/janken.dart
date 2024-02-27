// ignore_for_file: prefer_const_constructors
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class JankenPage extends StatefulWidget {
  const JankenPage({super.key});

  @override
  State<JankenPage> createState() => _JankenPageState();
}

class _JankenPageState extends State<JankenPage> {
  Icon computerHand = Icon(Icons.landscape_rounded);
  Icon myHand = Icon(Icons.landscape_rounded);
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
        return Icon(Icons.landscape_rounded, color: Colors.red, size: 27);
      case 1:
        return Icon(Icons.content_cut_rounded, color: Colors.green, size: 18);
      case 2:
        return Icon(Icons.note_outlined, color: Colors.blue, size: 21);
      default:
        return Icon(Icons.landscape_rounded, color: Colors.red, size: 27);
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
    } else if (myHand.icon == Icons.landscape_rounded &&
            computerHand.icon == Icons.content_cut_rounded ||
        myHand.icon == Icons.content_cut_rounded &&
            computerHand.icon == Icons.note_outlined ||
        myHand.icon == Icons.note_outlined &&
            computerHand.icon == Icons.landscape_rounded) {
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
        title: Text('じゃんけん'),
        backgroundColor: Colors.purple.shade100,
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
            SizedBox(height: 24),
            Text(
              '結果: $result',
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 48),
            computerHand,
            SizedBox(height: 24),
            Text('VS', style: TextStyle(fontSize: 24)),
            SizedBox(height: 24),
            myHand,
            SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setMyHand(Icon(Icons.landscape_rounded,
                        color: Colors.red, size: 27));
                  },
                  child: Icon(Icons.landscape_rounded,
                      color: Colors.red, size: 36),
                ),
                ElevatedButton(
                  onPressed: () {
                    setMyHand(Icon(Icons.content_cut_rounded,
                        color: Colors.green, size: 18));
                  },
                  child: Icon(Icons.content_cut_rounded,
                      color: Colors.green, size: 24),
                ),
                ElevatedButton(
                  onPressed: () {
                    setMyHand(Icon(Icons.note_outlined,
                        color: Colors.blue, size: 21));
                  },
                  child:
                      Icon(Icons.note_outlined, color: Colors.blue, size: 28),
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
