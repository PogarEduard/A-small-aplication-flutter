import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invatare_flutter/objects/my_object.dart';
import 'package:invatare_flutter/objects/random_objects.dart';
import 'package:invatare_flutter/widgets/buttons.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum direction { Left, Rigth }

class _HomeScreenState extends State<HomeScreen> {
  double playerX = 0;
  double playerY = 0;
  double randObjX = 1;
  double randObjY = 1;
  bool pauseVar = false;
  double velocity = 50;

  void moveRight() {
    setState(() {
      if (playerX >= 1) {
      } else {
        playerX += 0.05;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (playerX <= -1) {
      } else {
        playerX -= 0.05;
      }
    });
  }

  void moveUp() {
    setState(() {
      if (playerY <= -1) {
      } else {
        playerY -= 0.05;
      }
    });
  }

  void moveDown() {
    setState(() {
      if (playerY >= 1) {
      } else {
        playerY += 0.05;
      }
    });
  }

  void moveDiagonalUpRight() {
    if (playerX >= 1 || playerY <= -1) {
    } else {
      playerX += 0.003;
      playerY -= 0.04;
    }
  }

  void moveDiagonalUpLeft() {
    if (playerX <= -1 || playerY <= -1) {
    } else {
      playerX -= 0.003;
      playerY -= 0.04;
    }
  }

  void moveDiagonalDownRight() {
    if (playerX >= 1 || playerY >= 1) {
    } else {
      playerX += 0.003;
      playerY += 0.04;
    }
  }

  void moveDiagonalDownLeft() {
    if (playerX <= -1 || playerY >= 1) {
    } else {
      playerX -= 0.003;
      playerY += 0.04;
    }
  }

  void restartGame() {
    setState(() {
      if (!pauseVar) {
        playerX = 0;
        playerY = 0;
        randObjX = 1;
        randObjY = 1;
      } else if (pauseVar) {
        playerX = 0;
        playerY = 0;
        randObjX = 1;
        randObjY = 1;
        pauseVar = !pauseVar;
      }
    });
  }

  void pauseGame() {
    setState(() {
      pauseVar = false;
    });
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => Center(
          child: AlertDialog(
        backgroundColor: Colors.grey[700],
        title: Center(
          child: Text(
            message,
            style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.aspectRatio * 15),
          ),
        ),
      )),
    );
  }

  double heightToCoordinate(double height) {
    double totalHeight = MediaQuery.of(context).size.height * 3 / 4;
    double objHeight = 1 - 2 * height / totalHeight;
    return objHeight;
  }

  void startTheGame() {
    double time = 0;
    double height = 0;
    var directionObj = direction.Left;

    setState(() {
      pauseVar = true;
    });
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        if (directionObj == direction.Left) {
          randObjX -= 0.005;
        } else if (directionObj == direction.Rigth) {
          randObjX += 0.005;
        }
        randObjY = heightToCoordinate(height);
      });

      if (height < 0) {
        time = 0;
      }

      if (randObjX <= -1) {
        directionObj = direction.Rigth;
      } else if (randObjX >= 1) {
        directionObj = direction.Left;
      }

      height = -1 * time * time + velocity * time;

      time += 0.1;

      if ((randObjX - playerX).abs() < 0.1 &&
          (randObjY - playerY).abs() < 0.22) {
        _showDialog('Ai pierdut');
        pauseVar = false;
      }

      if (!pauseVar) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (value) {
        if (value.isKeyPressed(LogicalKeyboardKey.arrowLeft) ||
            value.isKeyPressed(LogicalKeyboardKey.keyA)) {
          pauseVar ? moveLeft() : null;
        } else if (value.isKeyPressed(LogicalKeyboardKey.arrowRight) ||
            value.isKeyPressed(LogicalKeyboardKey.keyD)) {
          pauseVar ? moveRight() : null;
        } else if (value.isKeyPressed(LogicalKeyboardKey.arrowUp) ||
            value.isKeyPressed(LogicalKeyboardKey.keyW)) {
          pauseVar ? moveUp() : null;
        } else if (value.isKeyPressed(LogicalKeyboardKey.arrowDown) ||
            value.isKeyPressed(LogicalKeyboardKey.keyS)) {
          pauseVar ? moveDown() : null;
        }
        if (value.isKeyPressed(LogicalKeyboardKey.arrowUp) ||
            value.isKeyPressed(LogicalKeyboardKey.keyW) &&
                (value.isKeyPressed(LogicalKeyboardKey.arrowLeft) ||
                    value.isKeyPressed(LogicalKeyboardKey.keyA))) {
          pauseVar ? moveDiagonalUpLeft() : null;
        } else if (value.isKeyPressed(LogicalKeyboardKey.arrowUp) ||
            value.isKeyPressed(LogicalKeyboardKey.keyW) &&
                (value.isKeyPressed(LogicalKeyboardKey.arrowRight) ||
                    value.isKeyPressed(LogicalKeyboardKey.keyD))) {
          pauseVar ? moveDiagonalUpRight() : null;
        } else if (value.isKeyPressed(LogicalKeyboardKey.arrowDown) ||
            value.isKeyPressed(LogicalKeyboardKey.keyS) &&
                (value.isKeyPressed(LogicalKeyboardKey.arrowLeft) ||
                    value.isKeyPressed(LogicalKeyboardKey.keyA))) {
          pauseVar ? moveDiagonalDownLeft() : null;
        } else if (value.isKeyPressed(LogicalKeyboardKey.arrowDown) ||
            value.isKeyPressed(LogicalKeyboardKey.keyS) &&
                (value.isKeyPressed(LogicalKeyboardKey.arrowRight) ||
                    value.isKeyPressed(LogicalKeyboardKey.keyD))) {
          pauseVar ? moveDiagonalDownRight() : null;
        }
      },
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Center(
              child: Container(
                color: Colors.blue[100],
                child: Stack(
                  children: [
                    RandomObj(
                      randObjX: randObjX,
                      randObjY: randObjY,
                    ),
                    MyObj(
                      playerX: playerX,
                      playerY: playerY,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    icons: !pauseVar ? Icons.play_arrow : Icons.pause,
                    function: !pauseVar ? startTheGame : pauseGame,
                  ),
                  MyButton(
                    icons: Icons.restart_alt,
                    function: restartGame,
                  ),
                ],
              ),
              color: Colors.amber[100],
            ),
          )
        ],
      ),
    );
  }
}
