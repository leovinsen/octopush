import 'package:audioplayers/audio_cache.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:octopush/model/time_interval.dart';
import 'package:octopush/model/transaction.dart';
import 'package:octopush/repository/challenge_repository.dart';
import 'package:octopush/repository/transaction_repository.dart';
import 'package:octopush/styles.dart';
import 'package:octopush/widgets/primary_button.dart';
import 'package:octopush/widgets/primary_container.dart'
    show getPrimaryDecoration;
import 'package:octopush/widgets/safe_scaffold.dart';

import 'package:octopush/audiocache_ext.dart';

import 'quiz_challenge/widgets/reward_indicator.dart';

enum Answer { A, B, C, D }

const quizInterval = TimeInterval.DAY11_B;

class QuizChallengeSplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var player = AudioCache()..playIntro();

    return SafeScaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'WHO WANTS TO BE A',
              textAlign: TextAlign.center,
              style: subtitleStyleLight,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'JUTAWAN',
              textAlign: TextAlign.center,
              style: titleStyleLight,
            ),
            SizedBox(
              height: 20.0,
            ),
            PrimaryButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => QuizChallengePage(),
                ),
              ),
              buttonText: 'START',
            ),
          ],
        ),
      ),
    );
  }
}

class QuizChallengePage extends StatefulWidget {
  @override
  _QuizChallengePageState createState() => _QuizChallengePageState();
}

class _QuizChallengePageState extends State<QuizChallengePage> {
  List<Quiz> quizzes;

  int index;

  int chosenAnswerIndex;

  bool _gameOver;

  AudioCache player;

  @override
  void initState() {
    super.initState();
    quizzes = quizMap.map((map) => Quiz.fromMap(map)).toList();
    index = 0;
    chosenAnswerIndex = -1;
    _gameOver = false;
    player = AudioCache();
  }

  @override
  Widget build(BuildContext context) {
    Quiz quiz = quizzes[index];

    return SafeScaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RewardIndicator(
                currentReward:
                    index == 0 ? 0.0 : quizzes[index - 1].reward.toDouble(),
                nextReward: quiz.reward.toDouble(),
                maxReward: quizzes.last.reward.toDouble(),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  'Question ${index + 1}/${quizzes.length}',
                  style: titleStyleLight,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(
                color: Colors.white,
                height: 1,
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  quiz.question,
                  style: captionStyleLight,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              AnswerList(
                quiz: quiz,
                onAnswerChosen: (int index) {
                  this.chosenAnswerIndex = index;
                  setState(() {});
                },
                chosenAnswerIndex: chosenAnswerIndex,
                correctAnswerIndex: _gameOver ? quiz.correctAnswer.index : -1,
              ),
              SizedBox(
                height: 20.0,
              ),
              PrimaryButton(
                buttonText: _gameOver ? "Quit" : "Submit",
                onPressed: chosenAnswerIndex != -1
                    ? () => _onBtnTap(quiz, context)
                    : null,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onBtnTap(Quiz quiz, BuildContext context) {
    if (_gameOver) {
      Navigator.of(context).pop();
    } else {
      _submitAnswer(quiz, context);
    }
  }

  void _submitAnswer(Quiz quiz, BuildContext context) {
    if (quiz.correctAnswer.index != chosenAnswerIndex) {
      _handleWrongAnswer();
      return;
    }
    _handleCorrectAnswer();
  }

  void _handleCorrectAnswer() {
    player.play('sound_correct_answer.mp3');

    if (index + 1 == quizzes.length) {
      _handleVictory();
    } else {
      //Go to next question
      chosenAnswerIndex = -1;
      index++;

      setState(() {});
    }
  }

  void _handleWrongAnswer() {
    player.play('sound_wrong_answer.mp3');
    _gameOver = true;
    setState(() {});
    _giveWinnings();
  }

  void _handleVictory() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => _VictoryPage(),
      ),
    );
    _giveWinnings();
  }

  void _giveWinnings() async {
    var transactionRepository = TransactionRepository();
    var reward = Transaction(null, DateTime.now(), quizInterval.index,
        "Who Wants To Be Jutawan Rwards", quizzes[index].reward.toDouble());

    await transactionRepository.addTranscation(reward);

    var challengeRepository = ChallengeRepository();
    var c = await challengeRepository.getOne(quizInterval.index)
      ..markDone();
    await challengeRepository.update(c);
  }
}

class _VictoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var player = AudioCache()..playIntro();
    return SafeScaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You won 10M IDR! We will transfer the reward to you shortly.',
              textAlign: TextAlign.center,
              style: titleStyleLight,
            ),
            SizedBox(
              height: 20.0,
            ),
            PrimaryButton(
              onPressed: () =>
                  Navigator.of(context).popUntil(ModalRoute.withName('/')),
              buttonText: 'Finish',
            ),
          ],
        ),
      ),
    );
  }
}

class AnswerList extends StatefulWidget {
  final Quiz quiz;
  final Function(int) onAnswerChosen;
  final int chosenAnswerIndex;
  final int correctAnswerIndex;

  const AnswerList(
      {Key key,
      this.quiz,
      this.onAnswerChosen,
      this.chosenAnswerIndex,
      this.correctAnswerIndex})
      : super(key: key);

  @override
  _AnswerListState createState() => _AnswerListState();
}

class _AnswerListState extends State<AnswerList> {
  // int chosenAnswerIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.quiz.answers.length,
      itemBuilder: (_, i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Container(
            decoration: getPrimaryDecoration(context),
            padding: const EdgeInsets.all(3.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: backgroundColor,
              ),
              padding: const EdgeInsets.only(
                  left: 16.0, right: 10.0, top: 8.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.quiz.answers[i],
                      style: largeTextStyleLight,
                    ),
                  ),
                  Theme(
                    data: ThemeData(
                      primarySwatch: Colors.red,
                      accentColor: accentColor,
                      scaffoldBackgroundColor: backgroundColor,
                      unselectedWidgetColor: Colors.white,
                    ),
                    child: CircularCheckBox(
                      value: _shouldShowCorrectAnswer(i) ||
                          widget.chosenAnswerIndex == i,
                      activeColor: _shouldShowCorrectAnswer(i)
                          ? Colors.amber
                          : Theme.of(context).toggleableActiveColor,
                      onChanged: (val) => widget.onAnswerChosen(i),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool _shouldShowCorrectAnswer(int index) {
    return widget.correctAnswerIndex == index;
  }
}

class Quiz {
  final String question;
  final List<String> answers;
  final Answer correctAnswer;
  final int reward;

  Quiz(this.question, this.answers, this.correctAnswer, this.reward);

  Quiz.fromMap(Map<String, dynamic> map)
      : question = map['question'],
        answers = map['answers'],
        correctAnswer = Answer.values[map['correct_answer']],
        reward = map['reward'];
}

const List<Map<String, dynamic>> quizMap = [
  {
    "question":
        "What is the minimum age to apply for a car loan in CIMB Niaga?",
    "answers": ["16", "18", "21", "25"],
    "correct_answer": 2,
    "reward": 100000
  },
  {
    "question": "Which of these products is not CIMB Niaga’s Savings product?",
    "answers": [
      "On Account",
      "Indie Account",
      "Tabunganku",
      "Tabungan CIMB Senior"
    ],
    "correct_answer": 3,
    "reward": 250000
  },
  {
    "question": "What is the definition of someone being financially literate?",
    "answers": [
      "Having the ability to understand and effectively apply various financial skills",
      "Having a bank account and understanding a bank’s products",
      "Having theoretical financial knowledge",
      "Having knowledge on currencies"
    ],
    "correct_answer": 0,
    "reward": 500000
  },
  {
    "question": "What is the definition of someone being financially included?",
    "answers": [
      "Having easy and affordable access to financial knowledge",
      "Having a bank account and being able to use the features of a bank and make use of the products",
      "Being able to store money and draw money at any time anywhere",
      "Having access to useful and affordable financial products and services that meet their needs"
    ],
    "correct_answer": 3,
    "reward": 750000
  },
  {
    "question": "What is the definition of budget?",
    "answers": [
      "The action or process of paying someone/something",
      "A sum of money due as one of several equal payments for something spread over a period of time",
      "An estimate of income and expenditure for a set period of time",
      "Money paid regularly at a particular rate "
    ],
    "correct_answer": 2,
    "reward": 1000000
  },
  {
    "question": "What is the definition of insurance?",
    "answers": [
      "An investment program funded by shareholders that trades in diversified holdings and is professionally managed",
      "An arrangement by which a company provides a guarantee of compensation in return for payment of a premium",
      "A bank account that earns interest",
      "A sum of money that is expected to be paid back with interest"
    ],
    "correct_answer": 1,
    "reward": 1500000
  },
  {
    "question": "What is the definition of the unbanked?",
    "answers": [
      "People who do not have their own bank accounts",
      "A group of people who do not have financial knowledge",
      "People who do not know how to deposit or draw money",
      "People who do not have sufficient knowledge on bank products"
    ],
    "correct_answer": 0,
    "reward": 3000000
  },
  {
    "question": "Which investment manager is in collaboration with CIMB Niaga?",
    "answers": ["Principle", "JP Morgan Chase", "Allianz", "UBS"],
    "correct_answer": 0,
    "reward": 5000000
  },
  {
    "question": "What does financial deepening mean?",
    "answers": [
      "Having deep and extensive financial knowledge",
      "The increase of financial services and locations of financial services",
      "The increase of amount of people who need financial services",
      "The availability of financial knowledge access"
    ],
    "correct_answer": 1,
    "reward": 7000000
  },
  {
    "question":
        "What is the name of CIMB Niaga’s health insurance that provides protection due to unexpected illness?",
    "answers": ["Xtra Kesehatan", "Xtra Sehat", "Xtra Medika", "Xtra Health"],
    "correct_answer": 2,
    "reward": 10000000
  },
];
