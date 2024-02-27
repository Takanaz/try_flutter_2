// ignore_for_file: prefer_const_constructors
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AttimuitehoiPage extends StatefulWidget {
  const AttimuitehoiPage({super.key});

  @override
  State<AttimuitehoiPage> createState() => _AttimuitehoiPageState();
}

class _AttimuitehoiPageState extends State<AttimuitehoiPage> {
  Icon computerDirection = Icon(Icons.north_rounded);
  Icon myDirection = Icon(Icons.north_rounded);
  String result = '';
  num battleCount = 0;
  num winCount = 0;
  num winRate = 0;

  void generateComputerDirection() {
    Random().nextInt(4);
    final randomNum = Random().nextInt(4);
    computerDirection = randomNumToDirection(randomNum);
  }

  Icon randomNumToDirection(int randomNum) {
    switch (randomNum) {
      case 0:
        return Icon(Icons.north_rounded, size: 24);
      case 1:
        return Icon(Icons.east_rounded, size: 24);
      case 2:
        return Icon(Icons.south_rounded, size: 24);
      case 3:
        return Icon(Icons.west_rounded, size: 24);
      default:
        return Icon(Icons.north_rounded, size: 24);
    }
  }

  void setMyDirection(Icon setMyDirection) {
    myDirection = setMyDirection;
    generateComputerDirection();
    judge();
    battleCount++;
    winRateCalc();
    setState(() {});
  }

  void judge() {
    if (myDirection.icon != computerDirection.icon) {
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
      winRate = (winCount / battleCount * 100).round();
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
        title: Text('あっち向いてホイ'),
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
            computerDirection,
            SizedBox(height: 24),
            myDirection,
            SizedBox(height: 48),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setMyDirection(Icon(Icons.north_rounded, size: 24));
                  },
                  child: Text('↑'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        setMyDirection(Icon(Icons.west_rounded, size: 24));
                      },
                      child: Text('←'),
                    ),
                    SizedBox(width: 24),
                    ElevatedButton(
                      onPressed: () {
                        setMyDirection(Icon(Icons.east_rounded, size: 24));
                      },
                      child: Text('→'),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    setMyDirection(Icon(Icons.south_rounded, size: 24));
                  },
                  child: Text('↓'),
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
