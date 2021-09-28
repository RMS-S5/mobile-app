import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../widgets/drawers/waiter_app_drawer.dart';
import '../../widgets/staff_app_bar.dart';
import '../../models/http_exception.dart';
import '../../widgets/simple_error_dialog.dart';

import '../../providers/orders.dart';
import '../../config/constants.dart';

class VerifyTableScreen extends StatefulWidget {
  static const routeName = '/verify-table';

  @override
  State<VerifyTableScreen> createState() => _VerifyTableScreenState();
}

class _VerifyTableScreenState extends State<VerifyTableScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _tableNumber = 0;
  var _showQrCode = false;
  var _tableVerificationCode = "";

  @override
  void didChangeDependencies() {
    _tableNumber = 0;
    _showQrCode = false;
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Orders>(context).fetchAndSetBranchTables().then((_) {
        setState(() {
          _isLoading = false;
        });
      }).onError((error, stackTrace) {
        setState(() {
          _isLoading = false;
        });
        showErrorDialog("Something went wrong!", context);
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  _submit() async {
    try {
      // if (!_formKey.currentState!.validate()) {
      //   // Invalid!
      //   return;
      // }
      // _formKey.currentState!.save();
      // setState(() {
      //   _isLoading = true;
      // });
      // if (_verifyData == null || _verifyData == "") {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   return;
      // }

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
    final orderProvider = Provider.of<Orders>(context);
    final tableNumbers = orderProvider.tableNumebrs;
    final viewTableNumbers = [0, ...tableNumbers];
    return Scaffold(
      appBar: staffAppBar(context),
      drawer: WaiterAppDrawer(drawerItemName: DrawerItems.VERIFYTABLE),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      // leading: Icon(Icons.table_chart),
                      title: Text('Table Number', style: inputTextStyle),
                      trailing: DropdownButton<String>(
                        value: _tableNumber.toString(),
                        hint: Text('Select a table number'),
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        // menuMaxHeight: 20,
                        // borderRadius: BorderRadius.all(Radius.circular(5)),
                        style: inputTextStyle,
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _showQrCode = false;
                            _tableNumber = int.parse(newValue ?? '0');
                          });
                        },
                        items: viewTableNumbers
                            .map<DropdownMenuItem<String>>((dynamic num) {
                          return DropdownMenuItem<String>(
                            value: num.toString(),
                            child: (num == 0)
                                ? Text("Select a table number")
                                : Text(num.toString()),
                          );
                        }).toList(),
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
                            'Submit',
                            style: titleTextStyle1.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              _showQrCode = true;
                              _tableVerificationCode = orderProvider
                                  .getVerificationCodeByTableNumber(
                                      _tableNumber);
                            });
                          }),
                    ]),
                    SizedBox(
                      height: 20,
                    ),
                    if (_showQrCode)
                      QrImage(
                        padding: EdgeInsets.all(5),
                        data: _tableVerificationCode,
                        version: QrVersions.auto,
                        size: 200.0,
                        errorStateBuilder: (cxt, err) {
                          return Container(
                            child: Center(
                              child: Text(
                                "Something went wrong...",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
