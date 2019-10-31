import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final ThemeData androidTheme = new ThemeData(
      fontFamily: 'is',
      primaryColorDark: Color(0xFF185a9d),
      primaryColorLight: Color(0xFF43cea2),
      accentColor: Color(0xFF43cea2),
      primaryColor: Colors.white,
      primaryTextTheme: TextTheme(caption: TextStyle(fontSize: 12.0)));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: androidTheme,
      home: new MyHomePage(title: 'دیت تایم پیکر فارسی'),
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
  String label;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    label = 'انتخاب تاریخ زمان';
  }

  void _showDateTimePicker() {
    showDialog(
      context: context,
      builder: (BuildContext _) {
        return PersianDateTimePicker(
          initial: '1398/03/20 19:50',
          type: 'datetime',
          color: Colors.redAccent,
          onSelect: (date) {
            setState(() {
              label = date;
            });
          },
        );
      },
    );
  }

  void _showDatePicker() {
    showDialog(
      context: context,
      builder: (BuildContext _) {
        return PersianDateTimePicker(
          initial: '1398/3/20',
          disable: ['friday', '1398/3/21', '13985/3/21'],
          type: 'date',
          onSelect: (date) {
            setState(() {
              label = date;
            });
          },
        );
      },
    );
  }

  void _showYearPicker() {
    showDialog(
      context: context,
      builder: (BuildContext _) {
        return PersianDateTimePicker(
          initial: '1397',
          type: 'year',
          disable: ['1400', '1395'],
          onSelect: (date) {
            setState(() {
              label = date;
            });
          },
        );
      },
    );
  }

  void _showMonthPicker() {
    showDialog(
      context: context,
      builder: (BuildContext _) {
        return PersianDateTimePicker(
          initial: '03',
          disable: ['2','03'],
          type: 'month',
          onSelect: (date) {
            setState(() {
              label = date;
            });
          },
        );
      },
    );
  }

  void _showTimePicker() {
    showDialog(
      context: context,
      builder: (BuildContext _) {
        return PersianDateTimePicker(
          initial: '19:50',
          disable: ['20:50','20:51','20:55'],
          type: 'time',
          onSelect: (date) {
            setState(() {
              label = date;
            });
          },
        );
      },
    );
  }

  void _showRangeDatePicker() {
    showDialog(
      context: context,
      builder: (BuildContext _) {
        return PersianDateTimePicker(
          initial: '1398/03/22#1399/03/25',
          type: 'rangedate',
          color: Colors.orangeAccent,
          onSelect: (date) {
            setState(() {
              label = date;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title,style: TextStyle(fontFamily: 'IS'),),
        ),
        body: new Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  _showDateTimePicker();
                },
                child: Text('تاریخ زمان'),
              ),
              RaisedButton(
                onPressed: () {
                  _showDatePicker();
                },
                child: Text('تاریخ '),
              ),
              RaisedButton(
                onPressed: () {
                  _showYearPicker();
                },
                child: Text('سال '),
              ),
              RaisedButton(
                onPressed: () {
                  _showMonthPicker();
                },
                child: Text('ماه '),
              ),
              RaisedButton(
                onPressed: () {
                  _showRangeDatePicker();
                },
                child: Text('بازه تاریخ '),
              ),
              RaisedButton(
                onPressed: () {
                  _showTimePicker();
                },
                child: Text(' زمان'),
              ),
              Text(label)
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            _showDatePicker();
          },
          tooltip: 'Increment',
          child: new Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
