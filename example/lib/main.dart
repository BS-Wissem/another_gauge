import 'package:another_gauge/another_gauge.dart';
import 'package:flutter/material.dart';

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
    ValueNotifier<bool> tickNotifier = ValueNotifier(false);
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
                      Text('Main tick value'),
                      StatefulBuilder(
                        builder: (context, setState) {
                          return Switch(
                            value: tickNotifier.value,
                            onChanged: (value) => setState(() =>tickNotifier.value = !tickNotifier.value));
                        }
                      ),
                      ElevatedButton(
                          onPressed: () {
                            valueNotifier.value += 15;
                          },
                          child: Text('Increment')),
                      SizedBox(
                        width: 16,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            valueNotifier.value -= 15;
                          },
                          child: Text('Decrement')),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: ValueListenableBuilder(
                        valueListenable: tickNotifier,
                        builder: (context, val, child) {
                          return AnotherGauge(
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
                            showMainTickValue : tickNotifier.value,
                            mainTicksColor: Colors.white,
                            rangeNeedleColor: true,
                            frameColor: Colors.blueGrey.shade600,
                            segmentWidth: 15,
                            showFrame: true,
                            gaugeSize: 350,
                            capSize: 80,
                            segments: [
                              GaugeSegment('Low', 70, Colors.green),
                              GaugeSegment('Medium', 100, Colors.orange),
                              GaugeSegment('High', 90, Colors.red),
                            ],
                            valueSymbol: 'km/h',
                            valueFontColor: Colors.white,
                            displayWidget: Padding(
                              padding: const EdgeInsets.only(top: 36.0),
                              child: const Text('Speed',
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            ),
                            maxValue: 260,
                          );
                        }
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
