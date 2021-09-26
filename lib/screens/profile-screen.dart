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

class ProfileScreen extends StatefulWidget {
  static final routeName = "/profile";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _isInit = true;
  var _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, dynamic> _userUpdatedData = {};

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
      if (_userUpdatedData == null || _userUpdatedData.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      final response = await Provider.of<User>(context, listen: false)
          .updateUser(_userUpdatedData);

      final snackBar = SnackBar(
        content: const Text('User detaild modified'),
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
      const message = "Something went wrong.";
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
                  // enabled: false,
                  // readOnly: true,
                  initialValue: userData['firstName'],
                  decoration: InputDecoration(
                    prefix: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('First Name : ', style: inputTextStyle),
                    ),
                    icon: Icon(Icons.three_p_outlined),
                  ),
                  validator: ValidationBuilder().minLength(3).build(),
                  onSaved: (value) {
                    if (value == userData['firstName']) {
                      return;
                    }
                    _userUpdatedData['firstName'] = value;
                  },
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                title: TextFormField(
                  style: inputTextStyle,
                  // enabled: false,
                  // readOnly: true,
                  initialValue: userData['lastName'],
                  decoration: InputDecoration(
                    prefix: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Last Name : ', style: inputTextStyle),
                    ),
                    icon: Icon(Icons.toc),
                  ),
                  validator: ValidationBuilder().minLength(3).build(),
                  onSaved: (value) {
                    if (value == userData['lastName']) {
                      return;
                    }
                    _userUpdatedData['lastName'] = value;
                  },
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                title: TextFormField(
                  style: inputTextStyle,
                  enabled: false,
                  readOnly: true,
                  initialValue: userData['email'],
                  decoration: InputDecoration(
                    prefix: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Email : ', style: inputTextStyle),
                    ),
                    icon: Icon(Icons.email),
                  ),
                  onSaved: (_) {},
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                title: TextFormField(
                  style: inputTextStyle,
                  keyboardType: TextInputType.number,
                  initialValue: userData['mobileNumber'],
                  decoration: InputDecoration(
                    prefix: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Mobile : ', style: inputTextStyle),
                    ),
                    icon: Icon(Icons.mobile_screen_share_rounded),
                  ),
                  validator: ValidationBuilder().phone().build(),
                  onSaved: (value) {
                    if (value == userData['mobileNumber']) {
                      return;
                    }
                    _userUpdatedData['mobileNumber'] = value;
                  },
                ),
              ),
              if (userData['accountType'] != 'Customer')
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: TextFormField(
                    style: inputTextStyle,
                    enabled: false,
                    readOnly: true,
                    initialValue: userData['branchName'],
                    decoration: InputDecoration(
                      prefix: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Branch Name : ', style: inputTextStyle),
                      ),
                      icon: Icon(Icons.mobile_screen_share_rounded),
                    ),
                    onSaved: (value) {},
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              Row(children: [
                SizedBox(
                  width: 20,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Change Password',
                      style: titleTextStyle1.copyWith(color: kPrimaryColor),
                    )),
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
                      'Update',
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
