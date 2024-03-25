import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/home.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  tz.initializeTimeZones();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

// This widget is the root of your application.
@override
Widget build(BuildContext context) {
  // SystemUiOverlayStyle(statusBarColor: Color.tdBlack); 
return MaterialApp(
  title: 'ToDo App',
  home: Home(),
  debugShowCheckedModeBanner: false,
);
}
}
// local storage
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  String _storedText = '';

  @override
  void initState() {
    super.initState();
    _loadStoredText();
  }

  // Function to load stored text from SharedPreferences
  Future<void> _loadStoredText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedText = prefs.getString('stored_text') ?? '';
    });
  }

  // Function to save text to SharedPreferences
  Future<void> _saveText(String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('stored_text', text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preferences Demo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter text'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Save text to SharedPreferences
                _saveText(_controller.text);
                setState(() {
                  _storedText = _controller.text;
                  _controller.clear();
                });
              },
              child: Text('Save Text'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Stored Text: $_storedText',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}






