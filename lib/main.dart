import 'package:flutter/material.dart';
import 'package:counter_7/drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // App Root
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Program Counter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // Function to increment counter
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Function to decrement counter if counter is more than 0
  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App top bar
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: buildDrawer(context),
      // App main body
      body: Center(
        child: Column(
          // Stack widgets vertically
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _counter % 2 == 0 // Show "GANJIL" or "GENAP" based on counter
                ? const Text('GENAP', style: TextStyle(color: Colors.redAccent))
                : const Text('GANJIL',
                    style: TextStyle(color: Colors.blueAccent)),
            Text(
              // Show counter
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),

      // Buttons
      floatingActionButton: Row(
        // Stack widgets horizontally
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Button for decrement counter
          Visibility(
              visible: _counter > 0,
              child: Container(
                  margin: const EdgeInsets.all(10),
                  child: FloatingActionButton(
                    onPressed: _decrementCounter,
                    backgroundColor: Colors.blueAccent,
                    tooltip: 'Increment',
                    child: Icon(Icons.remove),
                  ))),
          // Button for increment counter
          Container(
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: _incrementCounter,
                backgroundColor: Colors.blueAccent,
                tooltip: 'Increment',
                child: Icon(Icons.add),
              )),
        ],
      ),
    );
  }
}
