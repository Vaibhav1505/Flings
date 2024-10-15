import 'dart:async';
import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  // Step 1: Create a StreamController
  final StreamController<int> _counterController = StreamController<int>();
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    // Step 2: Start emitting counter values
    _startCounter();
  }

  void _startCounter() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      _counter++;
      // Step 3: Emit the new counter value
      _counterController.sink.add(_counter);
    });
  }

  @override
  void dispose() {
    // Step 4: Close the StreamController when done
    _counterController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Stream Example'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: _counterController.stream,
          builder: (context, snapshot) {
            print(snapshot.connectionState);

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text(
                'Counter: ${snapshot.data}',
                style: TextStyle(fontSize: 24),
              );
            }
          },
        ),
      ),
    );
  }
}
