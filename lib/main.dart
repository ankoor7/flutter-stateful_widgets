import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  double _numberFrom;
  String _startMeasure;
  String _convertedMeasure;

  @override
  void initState() {
    _numberFrom = 0;
    _startMeasure = _measures[0];
    _convertedMeasure = _measures[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formBody = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        makeFlex(Text(
          'Convert',
          style: labelStyle,
        )),
        makeFlex(TextField(
          style: inputStyle,
          decoration: const InputDecoration(
            hintText: 'Please type the value to convert',
          ),
          onChanged: (String text) {
            setState(() {
              _numberFrom = double.tryParse(text) ?? 0;
            });
          },
        )),
        makeFlex(DropdownButton(
          items: _measures.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (String value) {
            setState(() {
              _startMeasure = value;
            });
          },
          value: _startMeasure,
          hint: Text('Select Item'),
        )),
        makeFlex(Text(
          'To',
          style: labelStyle,
        )),
        makeFlex(DropdownButton(
          items: _measures.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (String value) {
            setState(() {
              _convertedMeasure = value;
            });
          },
          value: _convertedMeasure,
          hint: Text('Select Item'),
        )),
        makeFlex(RaisedButton(
            child: Text('Convert', style: inputStyle), onPressed: () => true)),
        makeFlex(Text((_numberFrom == 0) ? '' : _numberFrom.toString(),
            style: labelStyle)),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Measures Converter'),
      ),
      body: Container(
        padding: screenBodyPadding,
        // make form scrollable, or expand to fit the screen
        // LayoutBuilder > SingleChildScrollView > ConstrainedBox > IntrinsicHeight
        // https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: formBody,
                ),
              )
            );
          },
        ),
      ),
    );
  }
}

// Styles
final TextStyle inputStyle = TextStyle(
  fontSize: 20,
  color: Colors.blue[900],
);

final TextStyle labelStyle = TextStyle(
  fontSize: 24,
  color: Colors.grey[700],
);

const EdgeInsets screenBodyPadding = EdgeInsets.symmetric(
  horizontal: 20,
);

Widget makeFlex(Widget child) {
  // Make widget flex, but not to take up the maximum space.
  return Flexible(
    fit: FlexFit.loose,
    child: child,
  );
}

// Constants
const List<String> _measures = [
  'meters',
  'kilometers',
  'grams',
  'kilograms',
  'feet',
  'miles',
  'pounds (lbs)',
  'ounces',
];
