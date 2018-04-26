import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterantistorm/entriesstorage.dart';
import 'package:flutterantistorm/entrycount.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'E Times',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'E Times'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  EntryCount entryCount;
  EntriesStorage entriesStorage;
  int _timesCount = 0;

  _MyHomePageState() {
    entryCount = new EntryCount();
    entryCount.loadState().then((value) {
      setState(() {
        _timesCount = value;
      });
    });

    entriesStorage = new EntriesStorage();
    entriesStorage.loadEntries();
  }

  Future _addEntry() async {
    entryCount.addEntry().then((value) {
      setState(() {
        _timesCount = value;
      });
    });
    entriesStorage.addEntry(new DateTime.now().millisecondsSinceEpoch);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Align(
        alignment: Alignment.topLeft,
        child: new Padding(
          padding: new EdgeInsets.all(18.0),

          child: new Column(
            children: <Widget>[

              new Text("Entries count: "),
              new Text('$_timesCount'),

            ],
          ),

        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _addEntry,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
