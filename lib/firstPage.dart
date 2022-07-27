import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstPageScreen extends StatefulWidget {
  const FirstPageScreen({Key? key}) : super(key: key);

  @override
  State<FirstPageScreen> createState() => _FirstPageScreenState();
}

class _FirstPageScreenState extends State<FirstPageScreen> {
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  int selectedColor = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    SharedPreferences _prefs = await _sharedPreferences;
    selectedColor = _prefs.getInt("ColorKey") ?? 0;
    setState(() {});
  }

  void setData(BuildContext context, int color) async {
    SharedPreferences _prefs = await _sharedPreferences;
    _prefs.setInt("ColorKey", color);
    selectedColor = color;
    Navigator.of(context).pop();

    setState(() {});
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content:
              Text('Select the color that you want to save in the database.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Red'),
              onPressed: () {
                setData(context, 0);
              },
            ),
            TextButton(
              child: const Text('Green'),
              onPressed: () {
                setData(context, 1);
              },
            ),
            TextButton(
              child: const Text('Yellow'),
              onPressed: () {
                setData(context, 2);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            child: Container(
                color: selectedColor == 0
                    ? Colors.red
                    : selectedColor == 1
                        ? Colors.green
                        : Colors.yellow)),
        ElevatedButton(
            onPressed: () {
              _showMyDialog();
            },
            child: Text("Change Color"))
      ],
    ));
  }
}
