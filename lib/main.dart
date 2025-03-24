import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String displayText = "Hello World!";
  Color backgroundColor = Colors.white;

  void addText() {
    setState(() {
      displayText = "World Hello!";
    });
  }

  void removeText() {
    setState(() {
      displayText = "";
    });
  }

  void changeBackground() {
    setState(() {
      backgroundColor = backgroundColor == Colors.white ? Colors.blue : Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: Text("Flutter App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(displayText, style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(onPressed: addText, child: Text("add text")),
            ElevatedButton(onPressed: removeText, child: Text("del text")),
            ElevatedButton(onPressed: changeBackground, child: Text("change bg")),
          ],
        ),
      ),
    );
  }
}

