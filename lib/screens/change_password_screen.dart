import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:form_validator/form_validator.dart';

import '../models/http_exception.dart';
import '../widgets/simple_error_dialog.dart';
import './customer/components/app_bar.dart';
import '../widgets/staff_app_bar.dart';

import '../providers/user.dart';
import '../config/constants.dart';

class ChangePasswordScreen extends StatefulWidget {
  static final routeName = "/password-change";

  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var _isInit = true;
  var _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? _password = "";
  String? _currentPassword = "";
  bool _showPasswordField = false;
  bool _showCurrentPasswordField = false;
  bool _showConfirmPasswordField = false;
  TextEditingController _passwordController = TextEditingController();

  Future<void> _submit() async {
    try {
      if (!_formKey.currentState!.validate()) {
        // Invalid!
        return;
      }
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      if (_password == null ||
          _password == "" ||
          _currentPassword == null ||
          _currentPassword == "") {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      final response = await Provider.of<User>(context, listen: false)
          .chnagePassword(
              {'currentPassword': _currentPassword, 'password': _password});

      final snackBar = SnackBar(
        content: const Text('Passowrd Chnaged'),
        duration: Duration(
          milliseconds: 2000,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        _isLoading = false;
      });
    } on HttpException catch (error) {
      setState(() {
        _isLoading = false;
      });
      showErrorDialog(error.toString(), context);
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      const message = "Something went wrong! Check your internet connection.";
      showErrorDialog(message, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<User>(context).userData;
    final deviceOrientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: (userData['accountType'] == 'Customer')
          ? customerAppBar(context)
          : staffAppBar(context),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CircleAvatar(
                maxRadius: 60,
                minRadius: 50,
                backgroundImage: AssetImage(avatarImagePath),
              ),
              SizedBox(
                height: 40,
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                title: TextFormField(
                  style: inputTextStyle,
                  obscureText: !_showCurrentPasswordField,
                  decoration: InputDecoration(
                    label: Text('Current Password : ', style: inputTextStyle),
                    // icon: Icon(Icons.password_outlined),sfsdf
                    suffix: IconButton(
                      icon: _showCurrentPasswordField
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility_rounded),
                      onPressed: () {
                        setState(() {
                          _showCurrentPasswordField =
                              !_showCurrentPasswordField;
                        });
                      },
                    ),
                  ),
                  validator: ValidationBuilder().minLength(3).build(),
                  onSaved: (value) {
                    if (value == null || value == "") {
                      return;
                    }
                    _currentPassword = value;
                  },
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                title: TextFormField(
                  style: inputTextStyle,
                  controller: _passwordController,
                  obscureText: !_showPasswordField,
                  decoration: InputDecoration(
                    label: Text('Password : ', style: inputTextStyle),
                    // icon: Icon(Icons.password_outlined),
                    suffix: IconButton(
                      icon: _showPasswordField
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility_rounded),
                      onPressed: () {
                        setState(() {
                          _showPasswordField = !_showPasswordField;
                        });
                      },
                    ),
                  ),
                  validator: ValidationBuilder().minLength(3).build(),
                  onSaved: (value) {
                    if (value == null || value == "") {
                      return;
                    }
                    _password = value;
                  },
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                title: TextFormField(
                  style: inputTextStyle,
                  enabled: true,
                  initialValue: "",
                  validator: (value) {
                    if (value != _passwordController.text) {
                      print(_passwordController.text);
                      return 'Passwords do not match!';
                    }
                  },
                  obscureText: !_showConfirmPasswordField,
                  decoration: InputDecoration(
                    label: Text('Confirm Password : ', style: inputTextStyle),
                    // icon: Icon(Icons.confirmation_num),
                    suffix: IconButton(
                      icon: _showConfirmPasswordField
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility_rounded),
                      onPressed: () {
                        setState(() {
                          _showConfirmPasswordField =
                              !_showConfirmPasswordField;
                        });
                      },
                    ),
                  ),
                  onSaved: (_) {},
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(children: [
                Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      onPrimary: kTextColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Update password',
                      style: titleTextStyle1.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    onPressed: _submit),
                SizedBox(
                  width: 15,
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
