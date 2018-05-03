import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class NumberPicker extends StatefulWidget {

  final int maximum;
  final int initialValue;
  final ValueChanged<int> onChanged;

  NumberPicker(@required this.maximum, this.onChanged, this.initialValue, {Key key}) :
        super(key: key);

  @override
  State<StatefulWidget> createState() =>
      new NumberPickerState(maximum, initialValue, onChanged,);
}

class NumberPickerState extends State<NumberPicker> {

  ValueChanged<int> _onChanged;
  int _maximum;
  int _value = 0;

  NumberPickerState(int maximum, int initialValue, ValueChanged<int> onChanged) {
    this._maximum = maximum;
    this._value = initialValue;
    this._onChanged = onChanged;
  }

  _increment() {
    if (_value >= _maximum) return;
    setState(() {
      _value = _value + 1;
      if (_onChanged != null) {
        _onChanged(_value);
      }
    });
  }

  _decrement() {
    if (_value == 0) return;
    setState(() {
      _value = _value - 1;
      if (_onChanged != null) {
        _onChanged(_value);
      }
    });
  }

  getValue() {
    return _value;
  }

  setValue(int value) {
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        children: <Widget>[
          new Container(
            child: new RaisedButton(
              child: new Text("-", style: new TextStyle(color: Colors.white)),
              color: Colors.lightBlue,
              splashColor: Colors.blueAccent,
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
              child: new Text("+", style: new TextStyle(color: Colors.white)),
              color: Colors.lightBlue,
              splashColor: Colors.blueAccent,
              onPressed: _increment,
            ),
            width: 40.0,
          ),
        ],
      ),
    );
  }
}