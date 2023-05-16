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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () { valueNotifier.value +=15;}, child: Text('Increment')),
                  SizedBox(width: 16,),
                  ElevatedButton(onPressed: () { valueNotifier.value -=15;}, child: Text('Decrement')),
                ],
              ),
              Expanded(
                child: Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: AnotherGauge(
                          valueNotifier: valueNotifier,
                          capBorderColor: Colors.white,
                          capBorderWidth: 5,
                          capColor: Colors.white10,
                          faceStartColor: Colors.blueGrey,
                          //faceEndColor: Colors.blueAccent,
                          subTicksColor: Colors.white,
                          needleColor: Colors.white,
                          mainTicksColor: Colors.red,
                          rangeNeedleColor: true,
                          strokeWidth: 10,
                          showFrame: true,
                          gaugeSize: 256,
                          segments: [
                            GaugeSegment('Low', 200, Colors.green),
                            GaugeSegment('Medium', 40, Colors.orange),
                            GaugeSegment('High', 20, Colors.red),
                          ],
                          valueSymbol: ' km/h',
                          displayWidget: const Text('Speed',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
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
