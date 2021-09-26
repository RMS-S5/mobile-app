import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:form_validator/form_validator.dart';
import 'dart:async';

import '../welcome-screen.dart';
import '../../providers/user.dart';
import '../../models/http_exception.dart';
import '../../config/constants.dart';
import '../../widgets/simple_error_dialog.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, dynamic> _loginData = {
    'email': '',
    'password': '',
  };

  Map<String, dynamic> _registerData = {
    'email': '',
    'password': '',
    "mobileNumber": '',
    'firstName': '',
    'lastName': ''
  };

  bool _showPassword = false;
  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<User>(context, listen: false).login(
          _loginData['email'] ?? "",
          _loginData['password'] ?? "",
        );
        Navigator.of(context).pushReplacementNamed("/");
      } else {
        // Sign user up
        await Provider.of<User>(context, listen: false).customerRegister(
            _registerData['email'],
            _registerData['password'],
            _registerData['firstName'],
            _registerData['lastName'],
            _registerData['mobileNumber']);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("User registered successfully"),
          duration: Duration(milliseconds: 250),
        ));
        setState(() {
          _authMode = AuthMode.Login;
        });
      }
    } on HttpException catch (error) {
      showErrorDialog(error.toString(), context);
    } catch (error) {
      print(error);
      final errorMessage =
          'Could not authenticate you. Please try again later.';
      showErrorDialog(errorMessage, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 500 : 400,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 400 : 340),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(WelcomeScreen.routeName);
                  },
                  child: FittedBox(
                    child: RichText(
                      text: TextSpan(
                        style:
                            heading1Style.copyWith(fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: "NPN",
                            style: TextStyle(color: kSecondaryColor)
                                .copyWith(fontSize: 40),
                          ),
                          TextSpan(
                            text: "Food",
                            style: TextStyle(color: kPrimaryColor)
                                .copyWith(fontSize: 40),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      if (_authMode == AuthMode.Signup)
                        TextFormField(
                          style: inputTextStyle,
                          enabled: _authMode == AuthMode.Signup,
                          decoration: InputDecoration(labelText: 'First Name'),
                          validator: ValidationBuilder().minLength(3).build(),
                          onSaved: (value) {
                            _registerData['firstName'] = value;
                          },
                        ),
                      if (_authMode == AuthMode.Signup)
                        TextFormField(
                          style: inputTextStyle,
                          enabled: _authMode == AuthMode.Signup,
                          decoration: InputDecoration(labelText: 'Last Name'),
                          validator: ValidationBuilder().minLength(3).build(),
                          onSaved: (value) {
                            _registerData['lastName'] = value;
                          },
                        ),
                      if (_authMode == AuthMode.Signup)
                        TextFormField(
                          keyboardType: TextInputType.number,
                          style: inputTextStyle,
                          enabled: _authMode == AuthMode.Signup,
                          decoration:
                              InputDecoration(labelText: 'Mobile Number'),
                          validator: ValidationBuilder().minLength(9).build(),
                          onSaved: (value) {
                            _registerData['mobileNumber'] = value;
                          },
                        ),
                      TextFormField(
                        style: inputTextStyle,
                        decoration: InputDecoration(
                          labelText: 'E-Mail',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: ValidationBuilder().email().build(),
                        onSaved: (value) {
                          _loginData['email'] = value;
                          _registerData['email'] = value;
                        },
                      ),
                      TextFormField(
                        style: inputTextStyle,
                        decoration: InputDecoration(
                            hintText: "Forgot Password?",
                            labelText: 'Password',
                            suffix: IconButton(
                              icon: _showPassword
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility_rounded),
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                            )),
                        obscureText: !_showPassword,
                        controller: _passwordController,
                        validator: ValidationBuilder()
                            .minLength(6)
                            .maxLength(15)
                            .build(),
                        onSaved: (value) {
                          _loginData['password'] = value;
                          _registerData['password'] = value;
                        },
                      ),
                      if (_authMode == AuthMode.Login)
                        Row(
                          children: [
                            Spacer(),
                            TextButton(
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: kSuccessButtonColor,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      if (_authMode == AuthMode.Signup)
                        TextFormField(
                          style: inputTextStyle,
                          enabled: _authMode == AuthMode.Signup,
                          decoration:
                              InputDecoration(labelText: 'Confirm Password'),
                          obscureText: true,
                          validator: _authMode == AuthMode.Signup
                              ? (value) {
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match!';
                                  }
                                }
                              : null,
                        ),
                      SizedBox(
                        height: 8,
                      ),
                      if (_isLoading)
                        CircularProgressIndicator()
                      else
                        ElevatedButton(
                          child: Text(_authMode == AuthMode.Login
                              ? 'LOGIN'
                              : 'SIGN UP'),
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            onPrimary: kTextColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      Text(
                        '${_authMode == AuthMode.Login ? "Don’t have an Account ? " : "Already have an Account ? "}',
                        style: inputTextStyle,
                      ),
                      TextButton(
                        child: Text(
                          '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
                          style: TextStyle(
                            color: kPrimaryColor,
                          ),
                        ),
                        onPressed: _switchAuthMode,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
