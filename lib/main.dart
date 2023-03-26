import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var loading = false;
  var progressValue = 0.0;

  @override
  void initState() {
    loading = false;
    progressValue = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          title: Text("My First APP"),
          centerTitle: true,
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.all(16),
                child: loading
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LinearProgressIndicator(value: progressValue),
                    Text(
                      "${(progressValue * 100).round()}%",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                )
                    : Text(
                  "Press button to download",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ))),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              loading = !loading;
              _updateProgress();
            });
          },
          child: Icon(Icons.cloud_download),
        ),
      ),
    );
  }

  void _updateProgress() {
    const onSec = const Duration(seconds: 1);
    Timer.periodic(onSec, (Timer t) {
      setState(() {
        progressValue += 0.2;
        if (progressValue.toStringAsFixed(1) == "1.0") {
          loading = false;
          t.cancel();
          progressValue = 0.0;
          return;
        }
      });
    });
  }
}
