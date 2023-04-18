import 'package:flutter/material.dart';
import 'package:forestapp/widget/topNavBar.dart';
import 'confirmDialog.dart';
import 'dashboardScreen.dart';
import 'package:forestapp/widget/bottomNavBar.dart';
import 'package:forestapp/widget/topNavBarBasic.dart';
import 'package:dotted_border/dotted_border.dart';

class DamageReport extends StatefulWidget {
  @override
  _DamageReportState createState() => _DamageReportState();
}

class _DamageReportState extends State<DamageReport> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _description;
  String _dropdownValue = 'Walderlebnisfad';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBarBasic(
        title: 'Schadenbericht',returnStatus: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 158, 158, 158).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'SchadenTitel',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your SchadenTitel';
                    }
                    return null;
                  },
                  onSaved: (value) => _title = value?.trim(),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Beschreibung',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Beschreibung';
                    }
                    return null;
                  },
                  onSaved: (value) => _description = value?.trim(),
                ),
                SizedBox(height: 22.0),
                Row(children: <Widget>[
                  const Text(
                    'Standort',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 100.0),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    height: 50,
                    width: 210,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 30, 143, 73),
                        borderRadius: BorderRadius.circular(30)),
                    child: DropdownButton<String>(
                      value: _dropdownValue,
                      items: <String>[
                        'Walderlebnisfad',
                        'Köpferbrunnen',
                        'Naturkugelbahn'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _dropdownValue = newValue!;
                        });
                      },
                    ),
                  ),
                ]),
                SizedBox(height: 25.0),
                DottedBorder(
                    child: Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // --
                    },
                    icon: Icon(
                      Icons.upload_file_outlined,
                      size: 50,
                      color: Colors.black,
                    ),
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(400, 90)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                    ),
                    label: Text(
                      "Upload Additional file",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                )),
                SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: () {
                    _showDialog(context);
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => BottomTabBar()),
                      );
                    }
                  },
                  child: Text(
                    'Absenden',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(300, 50)),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 20.0),
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 15, 15, 15),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 30, 143, 73),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    VoidCallback continueCallBack = () => {
          Navigator.of(context).pop(),
          // code on continue comes here
        };
    ConfirmDialog alert = ConfirmDialog("", "Absenden?", continueCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
