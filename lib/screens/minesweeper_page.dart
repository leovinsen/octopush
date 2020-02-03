import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:octopush/constants.dart';
import 'package:octopush/model/time_interval.dart';
import 'package:octopush/model/transaction.dart';
import 'package:octopush/repository/challenge_repository.dart';
import 'package:octopush/repository/transaction_repository.dart';
import 'package:octopush/styles.dart';

// Types of images available
enum ImageType {
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  bomb,
  facingDown,
  flagged,
}

const TILE_BOUNTY = 10 * MILLION;
const TRACK_CHA_CHING = 'sound_cha_ching.mp3';
const TRACK_GAME_OVER = 'sound_game_over.mp3';
const minesweeperInterval = TimeInterval.DAY1_B;

class MinesweeperPage extends StatefulWidget {
  @override
  _MinesweeperPageState createState() => _MinesweeperPageState();
}

class _MinesweeperPageState extends State<MinesweeperPage> {
  // Row and column count of the board
  int rowCount = 14;
  int columnCount = 10;

  // The grid of squares
  List<List<BoardSquare>> board;

  // "Opened" refers to being clicked already
  List<bool> openedSquares;

  // A flagged square is a square a user has added a flag on by long pressing
  List<bool> flaggedSquares;

  // Probability that a square will be a bomb
  int bombProbability = 3;
  int maxProbability = 15;

  int bombCount = 0;
  int squaresLeft;

  // Number of consecutive clicks by user
  int clicksSurvived = 0;

  // To play game over and successful click sounds
  final player = AudioCache();

  @override
  void initState() {
    super.initState();
    _initialiseGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              color: Theme.of(context).accentColor,
              padding: const EdgeInsets.all(8.0),
              height: 60.0,
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.black87,
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Reward:',
                      style: minesweeperTextStyle,
                    ),
                    Text(
                      '${clicksSurvived}M IDR',
                      style: minesweeperTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            // The grid of squares
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columnCount,
              ),
              itemBuilder: (context, position) {
                // Get row and column number of square
                int rowNumber = (position / columnCount).floor();
                int columnNumber = (position % columnCount);

                Image image;

                if (openedSquares[position] == false) {
                  if (flaggedSquares[position] == true) {
                    image = getImage(ImageType.flagged);
                  } else {
                    image = getImage(ImageType.facingDown);
                  }
                } else {
                  if (board[rowNumber][columnNumber].hasBomb) {
                    image = getImage(ImageType.bomb);
                  } else {
                    image = getImage(
                      getImageTypeFromNumber(
                          board[rowNumber][columnNumber].bombsAround),
                    );
                  }
                }

                return InkWell(
                  // Opens square
                  onTap: () {
                    clicksSurvived++;

                    var soundtrack = TRACK_CHA_CHING;

                    if (board[rowNumber][columnNumber].hasBomb) {
                      clicksSurvived--;
                      _handleGameOver();
                      soundtrack = TRACK_GAME_OVER;
                    }

                    if (board[rowNumber][columnNumber].bombsAround == 0) {
                      _handleTap(rowNumber, columnNumber);
                    } else {
                      setState(() {
                        openedSquares[position] = true;
                        squaresLeft = squaresLeft - 1;
                      });
                    }

                    if (squaresLeft <= bombCount) {
                      _handleWin();
                    }

                    player.play(soundtrack);
                  },
                  // Flags square
                  onLongPress: () {
                    if (openedSquares[position] == false) {
                      setState(() {
                        flaggedSquares[position] = true;
                      });
                    }
                  },
                  splashColor: Colors.grey,
                  child: Container(
                    color: Colors.grey,
                    child: image,
                  ),
                );
              },
              itemCount: rowCount * columnCount,
            ),
          ],
        ),
      ),
    );
  }

  // Initialises all lists
  void _initialiseGame() {
    // Initialise all squares to having no bombs
    board = List.generate(rowCount, (i) {
      return List.generate(columnCount, (j) {
        return BoardSquare();
      });
    });

    // Initialise list to store which squares have been opened
    openedSquares = List.generate(rowCount * columnCount, (i) {
      return false;
    });

    flaggedSquares = List.generate(rowCount * columnCount, (i) {
      return false;
    });

    // Resets bomb count
    bombCount = 0;
    squaresLeft = rowCount * columnCount;

    // Randomly generate bombs
    Random random = new Random();
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < columnCount; j++) {
        int randomNumber = random.nextInt(maxProbability);
        if (randomNumber < bombProbability) {
          board[i][j].hasBomb = true;
          bombCount++;
        }
      }
    }

    // Check bombs around and assign numbers
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < columnCount; j++) {
        if (i > 0 && j > 0) {
          if (board[i - 1][j - 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i > 0) {
          if (board[i - 1][j].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i > 0 && j < columnCount - 1) {
          if (board[i - 1][j + 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (j > 0) {
          if (board[i][j - 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (j < columnCount - 1) {
          if (board[i][j + 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i < rowCount - 1 && j > 0) {
          if (board[i + 1][j - 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i < rowCount - 1) {
          if (board[i + 1][j].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i < rowCount - 1 && j < columnCount - 1) {
          if (board[i + 1][j + 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }
      }
    }

    setState(() {});
  }

  // This function opens other squares around the target square which don't have any bombs around them.
  // We use a recursive function which stops at squares which have a non zero number of bombs around them.
  void _handleTap(int i, int j) {
    int position = (i * columnCount) + j;
    openedSquares[position] = true;
    squaresLeft = squaresLeft - 1;

    if (i > 0) {
      if (!board[i - 1][j].hasBomb &&
          openedSquares[((i - 1) * columnCount) + j] != true) {
        if (board[i][j].bombsAround == 0) {
          _handleTap(i - 1, j);
        }
      }
    }

    if (j > 0) {
      if (!board[i][j - 1].hasBomb &&
          openedSquares[(i * columnCount) + j - 1] != true) {
        if (board[i][j].bombsAround == 0) {
          _handleTap(i, j - 1);
        }
      }
    }

    if (j < columnCount - 1) {
      if (!board[i][j + 1].hasBomb &&
          openedSquares[(i * columnCount) + j + 1] != true) {
        if (board[i][j].bombsAround == 0) {
          _handleTap(i, j + 1);
        }
      }
    }

    if (i < rowCount - 1) {
      if (!board[i + 1][j].hasBomb &&
          openedSquares[((i + 1) * columnCount) + j] != true) {
        if (board[i][j].bombsAround == 0) {
          _handleTap(i + 1, j);
        }
      }
    }

    setState(() {});
  }

  // Function to handle when a bomb is clicked.

  void _handleGameOver() {
    _saveWinnings();
    _createDialog(false);
  }

  void _handleWin() {
    _saveWinnings();
    _createDialog(true);
  }

  Future<void> _saveWinnings() async {
    var repository = TransactionRepository();

    Transaction t = Transaction(null, DateTime.now(), TimeInterval.DAY1_B.index,
        "Minesweeper Rewards", _calculateReward().toDouble());
    repository.addTranscation(t);

    var challengeRepository = ChallengeRepository();
    
    var c = await challengeRepository.getOne(minesweeperInterval.index)
      ..markDone();

    await challengeRepository.update(c);
  }

  void _createDialog(bool win) {
    var title = win ? "Congratulations!" : "Game Over!";
    var content = win ? "You Won!" : "Too bad, you found a mine!";

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text("$content You earned ${clicksSurvived}M IDR!"),
          actions: <Widget>[
            FlatButton(
              onPressed: _returnToHome,
              child: Text("Back to Home Page"),
            ),
          ],
        );
      },
    );
  }

  void _returnToHome() {
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }

  ///User earns [TILE_BOUNTY] for each click that does not kill them
  int _calculateReward() {
    return clicksSurvived * TILE_BOUNTY;
  }

  Image getImage(ImageType type) {
    switch (type) {
      case ImageType.zero:
        return Image.asset('assets/0.png');
      case ImageType.one:
        return Image.asset('assets/1.png');
      case ImageType.two:
        return Image.asset('assets/2.png');
      case ImageType.three:
        return Image.asset('assets/3.png');
      case ImageType.four:
        return Image.asset('assets/4.png');
      case ImageType.five:
        return Image.asset('assets/5.png');
      case ImageType.six:
        return Image.asset('assets/6.png');
      case ImageType.seven:
        return Image.asset('assets/7.png');
      case ImageType.eight:
        return Image.asset('assets/8.png');
      case ImageType.bomb:
        return Image.asset('assets/bomb.png');
      case ImageType.facingDown:
        return Image.asset('assets/facingDown.png');
      case ImageType.flagged:
        return Image.asset('assets/flagged.png');
      default:
        return null;
    }
  }

  ImageType getImageTypeFromNumber(int number) {
    switch (number) {
      case 0:
        return ImageType.zero;
      case 1:
        return ImageType.one;
      case 2:
        return ImageType.two;
      case 3:
        return ImageType.three;
      case 4:
        return ImageType.four;
      case 5:
        return ImageType.five;
      case 6:
        return ImageType.six;
      case 7:
        return ImageType.seven;
      case 8:
        return ImageType.eight;
      default:
        return null;
    }
  }
}

class BoardSquare {
  bool hasBomb;
  int bombsAround;

  BoardSquare({this.hasBomb = false, this.bombsAround = 0});
}
