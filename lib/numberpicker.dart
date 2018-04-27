import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class NumberPicker extends StatefulWidget {

  final int maximum;
  final ValueChanged<int> onChanged;

  const NumberPicker(
      @required this.maximum,
      @required this.onChanged);

  @override
  State<StatefulWidget> createState() => new _NumberPickerState(maximum, onChanged);
}

class _NumberPickerState extends State<NumberPicker> {

  ValueChanged<int> _onChanged;
  int _maximum;
  int _value = 0;

  _NumberPickerState(int maximum, ValueChanged<int> onChanged) {
    this._maximum = maximum;
    this._onChanged = onChanged;
  }

  _increment() {
    if (_value >= _maximum) return;
    setState(() {
      _value = _value + 1;
      _onChanged(_value);
    });
  }

  _decrement() {
    if (_value == 0) return;
    setState(() {
      _value = _value - 1;
      _onChanged(_value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        children: <Widget>[
          new Container(
            child: new RaisedButton(
              child: new Text("-"),
              color: Colors.blueAccent,
              splashColor: Colors.red,
              onPressed: _decrement,
            ),
            width: 40.0,
          ),
          new Container(
            child: new Text(
              "$_value",
              style: new TextStyle(
                  color: Colors.black,
                  decorationColor: Colors.amberAccent
              ),
              textAlign: TextAlign.center,
            ),
            width: 40.0,
          ),
          new Container(
            child: new RaisedButton(
              child: new Text("+"),
              color: Colors.blueAccent,
              splashColor: Colors.red,
              onPressed: _increment,
            ),
            width: 40.0,
          ),
        ],
      ),
    );
  }
}