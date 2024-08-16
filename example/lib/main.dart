import 'package:flutter/material.dart';
import 'package:another_gauge/another_gauge.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ValueNotifier<double> valueNotifier = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('AnotherGauge examples'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () { valueNotifier.value +=15;}, child: Text('Increment')),
                    SizedBox(width: 16,),
                    ElevatedButton(onPressed: () { valueNotifier.value -=15;}, child: Text('Decrement')),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: AnotherGauge(
                          valueNotifier: valueNotifier,
                          capBorderColor: Colors.white,
                          capBorderWidth: 10,
                          capColor: Colors.white10,
                          faceBorderColor: Colors.blueGrey.shade800,
                          faceStartColor: Colors.teal,
                          faceEndColor: Colors.cyan,
                          faceBorderWidth: 15,
                          subTicksColor: Colors.white,
                          needleColor: Colors.white,
                          mainTicksColor: Colors.red,
                          rangeNeedleColor: true,
                          frameColor: Colors.blueGrey.shade600,
                          segmentWidth: 15,
                          showFrame: true,
                          gaugeSize: 350,
                          capSize: 80,
                          segments: [
                            GaugeSegment('Low', 200, Colors.green),
                            GaugeSegment('Medium', 40, Colors.orange),
                            GaugeSegment('High', 20, Colors.red),
                          ],
                          valueSymbol: 'km/h',
                          displayWidget: Padding(
                            padding: const EdgeInsets.only(top:16.0),
                            child: const Text('Speed',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                          maxValue: 260,
                      ),
                    ),
                ),
              ),
            ],
          )
        )
    );
  }
}
