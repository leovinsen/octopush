import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopush/bloc/user_bloc.dart';
import 'package:octopush/bloc/user_event.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  //Mock university names
  final universities = [
    'Universitas Indonesia',
    'Universitas Trisakti',
    'Universitas Atma Jaya',
    'Institut Teknologi Bandung'
  ];

  TextEditingController _nameTextController;
  TextEditingController _phoneTextController;
  List<DropdownMenuItem> _universityDropdownItems;
  var _formKey;

  String _selectedUniversity;
  bool _agreeToTerms = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _phoneTextController = TextEditingController();

    _universityDropdownItems = universities
        .map((univ) => DropdownMenuItem(
              child: Text(univ),
              value: univ,
            ))
        .toList();

    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/logo_cimb.png',
                  height: 100.0,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Your name'),
                  controller: _nameTextController,
                  validator: (name) {
                    if (name.isEmpty) return 'Name cannot be empty';

                    return null;
                  },
                ),

                SizedBox(
                  height: 20.0,
                ),

                TextFormField(
                  decoration: InputDecoration(hintText: 'Phone number'),
                  controller: _phoneTextController,
                  validator: (phone) {
                    if (phone.isEmpty) return 'Phone number cannot be empty';

                    if (!phone.startsWith('08'))
                      return "Please enter a phone number that starts with '08'";

                    return null;
                  },
                ),

                SizedBox(
                  height: 20.0,
                ),

                DropdownButton<String>(
                  value: _selectedUniversity,
                  isExpanded: true,
                  hint: Text('Choose a university'),
                  items: _universityDropdownItems,
                  onChanged: (univ) => setState(() {
                    _selectedUniversity = univ;
                  }),
                ),

                // SizedBox(height: 40.0,),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Checkbox(
                        value: _agreeToTerms,
                        onChanged: (val) {
                          setState(() {
                            _agreeToTerms = val;
                          });
                        },
                        checkColor: Colors.white,
                        activeColor: Theme.of(context).primaryColorDark),
                    Text('I hereby agree to terms & conditions')
                  ],
                ),

                SizedBox(
                  height: 20.0,
                ),

                RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  child: _loading
                      ? Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          'SUBMIT',
                          style: TextStyle(color: Colors.white),
                        ),
                  onPressed: _submitUser,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitUser() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });
      _saveUser();
    }
  }

  void _saveUser() async {
    //Pretend we are communication with our servers
    await Future.delayed(Duration(seconds: 2));
    var event = RegisterUser(_nameTextController.text, _phoneTextController.text,
        _selectedUniversity);

        setState(() {
          _loading = false;
        });
    await _showDialogRegistrationSuccess();
    BlocProvider.of<UserBloc>(context).add(event);
  }

  Future<void> _showDialogRegistrationSuccess() async {
    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content:
                  Text('Hooray! You have successfully registered for OctoPush'),
              actions: <Widget>[
                FlatButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop()
                    ),
              ],
            ));
  }
}
