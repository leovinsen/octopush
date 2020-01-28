import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopush/bloc/user_bloc.dart';
import 'package:octopush/bloc/user_event.dart';
import 'package:octopush/styles.dart';
import 'package:octopush/widgets/primary_button.dart';

class CareerChoicePage extends StatefulWidget {
  @override
  _CareerChoicePageState createState() => _CareerChoicePageState();
}

class _CareerChoicePageState extends State<CareerChoicePage> {
  int _selectedJob = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'But first we need to ask you: What do you want to be?',
                      style: subtitleStyleLight,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                _buildCareerSelectionArea(),
                SizedBox(
                  height: 20.0,
                ),
                PrimaryButton(
                  
                  buttonText: 'SUBMIT',
                  onPressed: () => _submitJob(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitJob(BuildContext context) {
    if (_selectedJob == -1) {
      _showErrorJobNotChosenDialog();
    } else {
      BlocProvider.of<UserBloc>(context).add(InitializeGame(_selectedJob));
      Navigator.of(context).pop();
    }
  }

  void _showErrorJobNotChosenDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Text('You have not chosen your career'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ));
  }

  Widget _buildCareerSelectionArea() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildHalfOfScreen(
          jobIndex: 0,
          jobName: 'Employee',
          imgPath: 'assets/career_employee.png',
          income: 'Fixed',
          risk: 'Low',
          salary: 'Moderate but stable',
        ),
        _buildHalfOfScreen(
          jobIndex: 1,
          jobName: 'Self-Employed',
          imgPath: 'assets/career_self_employed.png',
          income: 'Non-Fixed',
          risk: 'High',
          salary: 'High but fluctuating',
        ),
      ],
    );
  }

  Widget _buildHalfOfScreen(
      {int jobIndex,
      String jobName,
      String imgPath,
      String income,
      String risk,
      String salary}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Image.asset(
                          imgPath,
                          height: 120.0,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                        Checkbox(
                          value: _selectedJob == jobIndex,
                          onChanged: (bool) => _selectJob(jobIndex),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      '$jobName',
                      style: captionStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Card(
              color: Theme.of(context).accentColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Income: $income',
                      style: baseStyleLight,
                    ),
                    Text(
                      'Risk: $risk',
                      style: baseStyleLight,
                    ),
                    Text(
                      'Salary: $salary',
                      style: baseStyleLight,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _selectJob(int i) {
    setState(() {
      _selectedJob = i;
    });
  }
}
