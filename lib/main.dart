import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int? count;

  incrementCount() async {
    SharedPreferences prefs = await _prefs;
    setState(() {
      count = (prefs.getInt("count") ?? 0) + 1;
      prefs.setInt("count", count!);
    });
  }

  @override
  void initState() {
    _prefs.then((SharedPreferences prefs) {
      count = prefs.getInt("count") ?? 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Test Shared Preferences"),
        ),
      ),
      body: Center(
        child: Text("count is : $count"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => incrementCount(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
