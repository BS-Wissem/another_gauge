import 'package:flutter/material.dart';
import 'package:another_gauge/another_gauge.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('AnotherGauge examples'),
          ),
          body: Container(
              color: Colors.grey[200],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black87,
                          border: Border.all(
                            color: Colors.blueGrey,
                            width: 1,
                          ),
                          //borderRadius: const BorderRadius.all(Radius.circular(20))
                          borderRadius: BorderRadius.only(bottomRight:Radius.circular(200/ 2),
                              bottomLeft:Radius.circular(200 / 2),
                              topRight: const Radius.circular(20), topLeft: const Radius.circular(20))
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            AnotherGauge(
                              capBorderColor: Colors.white,
                              capBorderWidth: 2,
                              capColor: Colors.white10,
                              faceStartColor: Colors.blueGrey,
                              faceEndColor: Colors.black87,
                              subTicksColor: Colors.white,
                              needleColor: Colors.white,
                              mainTicksColor: Colors.red,
                              strokeWidth: 1,
                              showFrame: false,
                              gaugeSize: 200,
                              segments: [
                                GaugeSegment('Low', 200, Colors.green),
                                GaugeSegment('Medium', 40, Colors.orange),
                                GaugeSegment('High', 20, Colors.red),
                              ],
                              currentValue: 60,
                              valueSymbol: ' km/h',
                              displayWidget: const Text('Speed',
                                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                              maxValue: 260,
                            ),
                            AnotherGauge(
                              capBorderColor: Colors.white,
                              capBorderWidth: 2,
                              capColor: Colors.white10,
                              faceStartColor: Colors.blueGrey,
                              faceEndColor: Colors.black87,
                              subTicksColor: Colors.white,
                              needleColor: Colors.white,
                              mainTicksColor: Colors.red,
                              strokeWidth: 1,
                              showFrame: false,
                              mainTickWidth: 2,
                              mainTicksLength: 2,
                              subTickWidth: 0.5,
                              frameWidth: 1,
                              rangeNeedleColor: true,
                              gaugeSize: 100,
                              segments: [
                                GaugeSegment('Critically Low', 10, Colors.red),
                                GaugeSegment('Low', 20, Colors.orange),
                                GaugeSegment('Medium', 20, Colors.yellow),
                                GaugeSegment('High', 50, Colors.green),
                              ],
                              currentValue: 15,
                              showMarkers: false,
                              valueWidget: Container(),
                              displayWidget:
                              const Text('Fuel', style: TextStyle(color: Colors.white,fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                            AnotherGauge(
                              capBorderColor: Colors.white,
                              capBorderWidth: 2,
                              capColor: Colors.white10,
                              faceStartColor: Colors.blueGrey,
                              faceEndColor: Colors.black87,
                              subTicksColor: Colors.white,
                              needleColor: Colors.white,
                              mainTicksColor: Colors.red,
                              strokeWidth: 1,
                              showFrame: false,
                              gaugeSize: 200,
                              rangeNeedleColor: false,
                              segments: [
                                GaugeSegment('Medium', 6000, Colors.green),
                                GaugeSegment('High', 1000, Colors.red),
                              ],
                              currentValue: 0,
                              showMarkers: false,
                              displayWidget: const Text('RPM',
                                  style: TextStyle(color: Colors.white,fontSize: 12, fontWeight: FontWeight.bold)),
                              maxValue: 7000,
                            ),
                          ]),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.blueGrey,
                            width: 1,
                          ),
                          //borderRadius: const BorderRadius.all(Radius.circular(20))
                          borderRadius: BorderRadius.only(bottomRight:Radius.circular(200/ 2),
                              bottomLeft:Radius.circular(200 / 2),
                              topRight: const Radius.circular(20), topLeft: const Radius.circular(20))
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            AnotherGauge(
                              capBorderColor: Colors.grey,
                              capBorderWidth: 2,
                              capColor: Colors.black,
                              faceStartColor: Colors.white,
                              faceEndColor: Colors.white30,
                              subTicksColor: Colors.grey,
                              needleColor: Colors.black,
                              mainTicksColor: Colors.red,
                              strokeWidth: 2,
                              showFrame: false,
                              gaugeSize: 200,
                              segments: [
                                GaugeSegment('Low', 200, Colors.green),
                                GaugeSegment('Medium', 40, Colors.orange),
                                GaugeSegment('High', 20, Colors.red),
                              ],
                              currentValue: 60,
                              valueSymbol: ' km/h',
                              displayWidget: const Text('Speed',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              maxValue: 260,
                            ),
                            AnotherGauge(
                              capBorderColor: Colors.black12,
                              capBorderWidth: 1,
                              capColor: Colors.black,
                              faceStartColor: Colors.white,
                              faceEndColor: Colors.white30,
                              subTicksColor: Colors.grey,
                              needleColor: Colors.black,
                              mainTicksColor: Colors.red,
                              strokeWidth: 2,
                              showFrame: false,
                              mainTickWidth: 2,
                              mainTicksLength: 2,
                              subTickWidth: 0.5,
                              frameWidth: 1,
                              rangeNeedleColor: true,
                              gaugeSize: 100,
                              segments: [
                                GaugeSegment('Critically Low', 10, Colors.red),
                                GaugeSegment('Low', 20, Colors.orange),
                                GaugeSegment('Medium', 20, Colors.yellow),
                                GaugeSegment('High', 50, Colors.green),
                              ],
                              currentValue: 15,
                              showMarkers: false,
                              valueWidget: Container(),
                              displayWidget:
                              const Text('Fuel', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                            AnotherGauge(
                              capBorderColor: Colors.grey,
                              capBorderWidth: 2,
                              capColor: Colors.black,
                              faceStartColor: Colors.white,
                              faceEndColor: Colors.white30,
                              subTicksColor: Colors.grey,
                              needleColor: Colors.black,
                              mainTicksColor: Colors.red,
                              strokeWidth: 2,
                              showFrame: false,
                              gaugeSize: 200,
                              rangeNeedleColor: false,
                              segments: [
                                GaugeSegment('Medium', 6000, Colors.green),
                                GaugeSegment('High', 1000, Colors.red),
                              ],
                              currentValue: 0,
                              showMarkers: false,
                              displayWidget: const Text('RPM',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              maxValue: 7000,
                            ),
                          ]),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueGrey,
                            width: 5,
                          ),
                          //borderRadius: const BorderRadius.all(Radius.circular(20))
                          borderRadius: BorderRadius.only(bottomRight:Radius.circular(200/ 2),
                              bottomLeft:Radius.circular(200 / 2),
                              topRight: const Radius.circular(20), topLeft: const Radius.circular(20))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                        AnotherGauge(
                          showFrame: false,
                          gaugeSize: 200,
                          segments: [
                            GaugeSegment('Low', 200, Colors.green),
                            GaugeSegment('Medium', 40, Colors.orange),
                            GaugeSegment('High', 20, Colors.red),
                          ],
                          currentValue: 60,
                          valueSymbol: ' km/h',
                          displayWidget: const Text('Speed',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          maxValue: 260,
                        ),
                          AnotherGauge(
                            showFrame: false,
                            strokeWidth: 2,
                            mainTickWidth: 2,
                            mainTicksLength: 2,
                            subTickWidth: 0.5,
                            frameWidth: 1,
                            capBorderWidth: 1,
                            rangeNeedleColor: true,
                            gaugeSize: 100,
                            segments: [
                              GaugeSegment('Critically Low', 10, Colors.red),
                              GaugeSegment('Low', 20, Colors.orange),
                              GaugeSegment('Medium', 20, Colors.yellow),
                              GaugeSegment('High', 50, Colors.green),
                            ],
                            currentValue: 45,
                            needleColor: Colors.blue,
                            showMarkers: false,
                            valueWidget: Container(),
                            displayWidget:
                            const Text('Fuel', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        AnotherGauge(
                          showFrame: false,
                          gaugeSize: 200,
                          rangeNeedleColor: true,
                          segments: [
                            GaugeSegment('Medium', 6000, Colors.green),
                            GaugeSegment('High', 1000, Colors.red),
                          ],
                          currentValue: 0,
                          needleColor: Colors.red,
                          showMarkers: false,
                          displayWidget: const Text('RPM',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          maxValue: 7000,
                        ),
                      ]),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //   AnotherGauge(
                    //     strokeWidth: 2,
                    //     mainTickWidth: 2,
                    //     mainTicksLength: 2,
                    //     subTickWidth: 0.5,
                    //     frameWidth: 1,
                    //     capBorderWidth: 2,
                    //     showFrame: false,
                    //     gaugeSize: 100,
                    //     segments: [
                    //       GaugeSegment('Low', 20, Colors.blue[200]!),
                    //       GaugeSegment('Medium', 40, Colors.blue),
                    //       GaugeSegment('High', 40, Colors.blue[800]!),
                    //     ],
                    //     currentValue: 70,
                    //     displayWidget:
                    //         const Text('Temp', style: TextStyle(fontSize: 12)),
                    //   ),
                    //   AnotherGauge(
                    //     strokeWidth: 2,
                    //     mainTickWidth: 2,
                    //     mainTicksLength: 2,
                    //     subTickWidth: 0.5,
                    //     frameWidth: 1,
                    //     capBorderWidth: 2,
                    //     showFrame: true,
                    //     gaugeSize: 100,
                    //     segments: [
                    //       GaugeSegment('Critically Low', 10, Colors.red),
                    //       GaugeSegment('Low', 20, Colors.orange),
                    //       GaugeSegment('Medium', 20, Colors.yellow),
                    //       GaugeSegment('High', 50, Colors.green),
                    //     ],
                    //     currentValue: 45,
                    //     needleColor: Colors.tealAccent,
                    //     showMarkers: false,
                    //     valueWidget: Container(),
                    //     displayWidget:
                    //         const Text('Fuel', style: TextStyle(fontSize: 12)),
                    //   ),
                    //   AnotherGauge(
                    //     strokeWidth: 2,
                    //     mainTickWidth: 2,
                    //     mainTicksLength: 2,
                    //     subTickWidth: 0.5,
                    //     frameWidth: 1,
                    //     capBorderWidth: 2,
                    //     showFrame: false,
                    //     gaugeSize: 100,
                    //     minValue: 30,
                    //     maxValue: 150,
                    //     segments: [
                    //       GaugeSegment('Low', 20, Colors.red),
                    //       GaugeSegment('Slightly Low', 20, Colors.yellow),
                    //       GaugeSegment('Correct', 20, Colors.green),
                    //       GaugeSegment('High', 60, Colors.orange),
                    //     ],
                    //     currentValue: 72,
                    //     displayWidget:
                    //         const Text('Pulse', style: TextStyle(fontSize: 12)),
                    //   ),
                    //   AnotherGauge(
                    //     strokeWidth: 2,
                    //     mainTickWidth: 2,
                    //     mainTicksLength: 2,
                    //     subTickWidth: 0.5,
                    //     frameWidth: 1,
                    //     capBorderWidth: 2,
                    //     showFrame: true,
                    //     minValue: 0,
                    //     maxValue: 150,
                    //     gaugeSize: 100,
                    //     segments: [
                    //       GaugeSegment('Good', 80, Colors.green),
                    //       GaugeSegment('High', 70, Colors.red),
                    //     ],
                    //     currentValue: 75,
                    //     showMarkers: false,
                    //     displayWidget:
                    //         const Text('Speed', style: TextStyle(fontSize: 12)),
                    //   ),
                    // ])
                  ])),
        ));
  }
}
