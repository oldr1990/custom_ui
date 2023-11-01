import 'package:custom_ui/hexagonal_button.dart';
import 'package:custom_ui/regular_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  List<String> labels = [
    'HexagonalButton',
    'HexagonalButton  very long text, bla bla bla, some important information bla bla bla'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              for (var label in labels)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: HexagonalButton(
                      color: Colors.blue,
                      onTap: _incrementCounter,
                      child: Text(label)),
                ),
              Divider(),
              for (var label in labels)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: RegularButton(
                      color: Colors.blue,
                      onTap: _incrementCounter,
                      child: Text(label)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}




