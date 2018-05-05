import 'dart:async';

import 'package:etimes/chartpainter.dart';
import 'package:flutter/material.dart';
import 'package:etimes/entriesstorage.dart';
import 'package:etimes/numberpicker.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var currentTime = _initializePickers();
    return new MaterialApp(
      title: 'E Times',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MainPage(
          title: 'E Times',
          hour: currentTime[0],
          minute: currentTime[1]
      ),
    );
  }

  _initializePickers() {
    var now = new DateTime.now();
    var hour = now.hour;
    var minute = now.minute;
    return [hour, minute];
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title, this.hour, this.minute}) : super(key: key);

  final String title;
  final int hour;
  final int minute;

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final hourKey = new GlobalKey<NumberPickerState>();
  final minuteKey = new GlobalKey<NumberPickerState>();

  EntriesStorage entriesStorage;
  List<int> _values;

  _MainPageState() {
    entriesStorage = new EntriesStorage();
    entriesStorage.loadEntries().then((list) {
      setState(() {
        _values = list;
      });
    });
  }

  Future _addEntry() async {
    var value = hourKey.currentState.getValue() * 60 +
        minuteKey.currentState.getValue();

    entriesStorage.addEntry(value);
    entriesStorage.loadEntries().then((list) {
      setState(() {
        _values = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Padding(
          padding: new EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 26.0),
          child:
          new Column(
            children: <Widget>[
              new Expanded(

                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Expanded(
                    child: new CustomPaint(
                        painter: new DotChartPainter(this._values)
                  ),
                    )
                  ],
                ),

              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  new Padding(
                    child: new Text("Choose time:"),
                    padding: new EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 8.0),
                  ),
                  new Row(
                    children: <Widget>[
                      new NumberPicker(maximum: 18, minimum: 8, onChanged: null, initialValue: widget.hour, key: hourKey),
                      new Padding(
                          padding: new EdgeInsets.fromLTRB(
                              10.0, 0.0, 10.0, 0.0),
                          child: new Text(":")
                      ),
                      new NumberPicker(maximum: 59, minimum: 0, onChanged: null, initialValue: widget.minute, key: minuteKey)
                    ],

                  ),
                ],),
            ],
          ),
        ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _addEntry,
        tooltip: 'Increment',
        child: new Icon(Icons.check),
      ),
    );
  }
}
