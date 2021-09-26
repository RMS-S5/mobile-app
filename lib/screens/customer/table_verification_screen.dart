import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/drawers/customer_app_drawer.dart';
import '../../models/http_exception.dart';
import '../../widgets/simple_error_dialog.dart';
import 'components/app_bar.dart';
import 'components/cart_item.dart';

import '../../providers/orders.dart';
import '../../config/constants.dart';

class TableVerificationScreen extends StatefulWidget {
  static const routeName = '/customer/table-verification';

  @override
  State<TableVerificationScreen> createState() =>
      _TableVerificationScreenState();
}

class _TableVerificationScreenState extends State<TableVerificationScreen> {
  var _isInit = true;
  var _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _verifyData = "";

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Orders>(context).fetchAndSetTableData().then((_) {
        setState(() {
          _isLoading = false;
        });
      }).onError((error, stackTrace) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No verification code found!')));
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
      if (_verifyData == null || _verifyData == "") {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      final response = await Provider.of<Orders>(context, listen: false)
          .setVerificationCode(_verifyData);

      final snackBar = SnackBar(
        content: const Text('Table is verified'),
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
      print(error);
      setState(() {
        _isLoading = false;
      });
      const message = "Something went wrong.";
      showErrorDialog(message, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final tableData = Provider.of<Orders>(context).tableData;
    // final tableData = {};
    // bool showField = !tableData.isEmpty;
    return Scaffold(
      appBar: customerAppBar(context),
      drawer: CustomerAppDrawer(drawerItemName: DrawerItems.TABLE),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        style: inputTextStyle,
                        // enabled: tableData.isEmpty,
                        decoration: InputDecoration(
                          labelText: 'Verification Code',
                          icon: Icon(Icons.verified_user_outlined),
                        ),
                        onSaved: (value) {
                          _verifyData = value ?? "";
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: kRejectButtonColor,
                              onPrimary: kTextColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Clear',
                              style: titleTextStyle1.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            onPressed: () async {
                              try {
                                await Provider.of<Orders>(context,
                                        listen: false)
                                    .clearTableData();
                              } catch (error) {
                                showErrorDialog(error.toString(), context);
                              }
                            }),
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
                              'Submit',
                              style: titleTextStyle1.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            onPressed: _submit),
                      ]),
                      Consumer<Orders>(builder: (context, orderData, _) {
                        final tableData = orderData.tableData;
                        print(tableData);
                        print(!tableData.isEmpty);
                        bool showField = !tableData.isEmpty;
                        return Column(
                          children: [
                            if (showField)
                              ListTile(
                                leading:
                                    Icon(Icons.auto_awesome_mosaic_rounded),
                                title:
                                    Text('Table Number', style: inputTextStyle),
                                trailing: Text(
                                    tableData['tableNumber'].toString(),
                                    style: inputTextStyle),
                              ),
                            if (showField)
                              ListTile(
                                leading: Icon(Icons.balcony),
                                title:
                                    Text('Branch Name', style: inputTextStyle),
                                trailing: Text(
                                  tableData['branchName'],
                                  style: inputTextStyle,
                                ),
                              )
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
