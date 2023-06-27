import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:flutter_blue/flutter_blue.dart';

void main() {
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Flutter BLE App',
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
            ),
            home: const MyHomePage(title: 'BLE App'),
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
    Timer? timer;

    Future<void> test() async {
        FlutterBlue flutterBlue = FlutterBlue.instance;
        print('stocazzoooo');
        await flutterBlue.startScan(timeout: const Duration(seconds: 4));
        var subscription = flutterBlue.scanResults.listen((results) {
        for (ScanResult r in results) {
                print('${r.device.name} found! rssi: ${r.rssi}');
            }
        });

        flutterBlue.stopScan();
    }

    @override
    void initState() {
        super.initState();
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            setState(() {
                _counter = Random().nextInt(100);
            });
        });

        test();
    }

    void _incrementCounter() {
        setState(() {
            _counter += 1;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text(widget.title),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        RotatedBox(
                            quarterTurns: 3, 
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Slider(
                                    value: (_counter / 100.0), 
                                    onChanged: (value) => {},
                                ),
                            ),
                        ),
                        Text('Value: $_counter'),
                    ],
                ),
            ),
            //floatingActionButton: FloatingActionButton(
            //    onPressed: _incrementCounter,
            //    tooltip: 'Increment',
            //    child: const Icon(Icons.add),
            //),
        );
    }
}
