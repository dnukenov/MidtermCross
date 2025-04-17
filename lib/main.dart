import 'package:flutter/material.dart';

void main() {
  runApp(SavingsApp());
}

class SavingsApp extends StatefulWidget {
  @override
  State<SavingsApp> createState() => _SavingsAppState();
}

class _SavingsAppState extends State<SavingsApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void _cycleLanguage() {
    // Временно отключено
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Savings Calculator",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: SavingsHomePage(
        toggleTheme: _toggleTheme,
        cycleLanguage: _cycleLanguage,
        currentLanguage: 'en',
        themeMode: _themeMode,
      ),
      routes: {
        '/about': (_) => AboutPage(),
      },
    );
  }
}

class SavingsHomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final VoidCallback cycleLanguage;
  final String currentLanguage;
  final ThemeMode themeMode;

  SavingsHomePage({
    required this.toggleTheme,
    required this.cycleLanguage,
    required this.currentLanguage,
    required this.themeMode,
  });

  @override
  State<SavingsHomePage> createState() => _SavingsHomePageState();
}

class _SavingsHomePageState extends State<SavingsHomePage> {
  List<String> savingsList = List.generate(5, (i) => "Savings Entry ${i + 1}");

  void _addEntry() {
    setState(() {
      savingsList.add("Savings Entry ${savingsList.length + 1}");
    });
  }

  void _removeEntry(int index) {
    setState(() {
      savingsList.removeAt(index);
    });
  }

  void _renameEntry(int index) async {
    TextEditingController controller = TextEditingController(text: savingsList[index]);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Rename Entry"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Enter new name"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  savingsList[index] = controller.text;
                });
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Savings Calculator"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                "Track your savings, reduce expenses,\nand save for your big goals.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView.builder(
                    itemCount: savingsList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _removeEntry(index),
                        onLongPress: () => _renameEntry(index),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: Icon(Icons.monetization_on),
                            title: Text(savingsList[index]),
                            subtitle: Text("Detail for month ${index + 1}"),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 12),
              Center(
                child: Text(
                  "Developed by Nukenov Daniyar\nCourse: Crossplatform Development\nAstana IT University\nTeacher: Abzal Kyzyrkanov",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'themeBtn',
            onPressed: widget.toggleTheme,
            mini: true,
            child: Icon(Icons.brightness_6),
            tooltip: 'Toggle Theme',
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'langBtn',
            onPressed: widget.cycleLanguage,
            mini: true,
            child: Icon(Icons.language),
            tooltip: 'Switch Language (disabled)',
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'addBtn',
            onPressed: _addEntry,
            child: Icon(Icons.add),
            tooltip: 'Add Entry',
          ),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            "This is the About page.\n\nHere you could provide information about your app, version, team, or purpose.\n\nThe layout is responsive and supports dark mode.",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
