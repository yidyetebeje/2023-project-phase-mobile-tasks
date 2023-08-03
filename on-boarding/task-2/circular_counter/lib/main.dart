import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Counter(),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  var _counter = 0;
  void incrementCounter() {
    setState(() {
      if (_counter == 10) {
        _counter = 0;
      } else {
        _counter++;
      }
    });
  }

  void decrementCounter() {
    setState(() {
      if (_counter == 0) {
        _counter = 10;
      } else {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_counter.toString(),style: const TextStyle(
            color: Colors.deepPurple,
          )),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  onPressed: decrementCounter, child: const Text('Decrement')),
              FilledButton(
                  onPressed: incrementCounter, child: const Text('Increment')),
            ],
          )
        ],
      ),
    ));
  }
}
