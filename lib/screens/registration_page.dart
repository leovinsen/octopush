import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopush/bloc/user_bloc.dart';
import 'package:octopush/bloc/user_event.dart';
import 'package:octopush/styles.dart';

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
              child: Text(
                univ,
                style: baseStyle,
              ),
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
        child: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _logo(),
                      _form(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        color: Colors.white,
      ),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/img_cimb_niaga.png',
            height: 60.0,
            width: 180.0,
            fit: BoxFit.contain,
          ),
          Image.asset(
            'assets/ic_octo_192.png',
            height: 100.0,
            width: 100.0,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  Widget _form() {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'Your name'),
            controller: _nameTextController,
            style: baseStyle,
            validator: (name) {
              if (name.isEmpty) return 'Name cannot be empty';

              return null;
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'Phone number'),
            controller: _phoneTextController,
            style: baseStyle,
            validator: (phone) {
              if (phone.isEmpty) return 'Phone number cannot be empty';

              if (!phone.startsWith('08'))
                return "Please enter a phone number that starts with '08'";

              return null;
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          DropdownButton<String>(
            value: _selectedUniversity,
            isExpanded: true,
            hint: Text(
              'Choose a university',
              style: baseStyle,
            ),
            items: _universityDropdownItems,
            onChanged: (univ) => setState(() {
              _selectedUniversity = univ;
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Checkbox(
                  value: _agreeToTerms,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (val) {
                    setState(() {
                      _agreeToTerms = val;
                    });
                  },
                  checkColor: Colors.white,
                  activeColor: Theme.of(context).primaryColorDark,
                  tristate: false,
                ),
                Text(
                  'I hereby agree to terms & conditions',
                  style: baseStyle,
                )
              ],
            ),
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
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
    var event = RegisterUser(_nameTextController.text,
        _phoneTextController.text, _selectedUniversity);

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
                    onPressed: () => Navigator.of(context).pop()),
              ],
            ));
  }
}
