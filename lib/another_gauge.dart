library another_gauge;

import 'dart:math';
import 'package:flutter/material.dart';

///Class that holds the details of each segment on a CustomGauge
class GaugeSegment {
  final String segmentName;
  final double segmentSize;
  final Color segmentColor;

  GaugeSegment(this.segmentName, this.segmentSize, this.segmentColor);
}

class GaugeNeedleClipper extends CustomClipper<Path> {
  //Note that x,y coordinate system starts at the bottom right of the canvas
  //with x moving from right to left and y moving from bottom to top
  //Bottom right is 0,0 and top left is x,y
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.62);
    path.lineTo(1.1 * size.width * 0.5, size.height * 0.6);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(0.9 * size.width * 0.5, size.height * 0.6);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(GaugeNeedleClipper oldClipper) => false;
}

class SubTicksPainter extends CustomPainter {
  SubTicksPainter( {
    this.offset = 0,
    this.startAngle = 135,
    this.sweepAngle = 270,
    this.color = Colors.white,
    this.width = 3,
    this.length = 0,
    this.step = 5,
  });
  final double offset;
  final double startAngle;
  final double sweepAngle;
  final Color color;
  final double width;
  final double length;
  final int step;

  @override
  void paint(Canvas canvas, Size size) {
    final tickPaint = Paint()
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..color = color;

    double start = size.width / 2;
    double end = size.width / 2;
    double minDimension = size.width > size.height ? size.height : size.width;
    var mRadius = minDimension / 2 - offset -8;
    start -= mRadius;
    end -= mRadius - length;

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(-pi);
    canvas.translate(-size.width / 2, -size.height / 2);
    var angles = [for (var i = startAngle; i <= startAngle + sweepAngle; i+= step) i];
    for (double angle in angles ) {
      canvas.save();
      canvas.translate(size.width / 2, size.height / 2);
      canvas.rotate(degToRad(angle));
      canvas.translate(-size.width / 2, -size.height / 2);
      canvas.drawLine(Offset(start, size.height / 2),
          Offset(end, size.height / 2), tickPaint);
      canvas.restore();
    }

    for (double angle in angles ) {
      canvas.save();
      canvas.translate(size.width / 2, size.height / 2);
      canvas.rotate(degToRad(angle));
      canvas.translate(-size.width / 2, -size.height / 2);
      canvas.drawLine(Offset(start, size.height / 2),
          Offset(end, size.height / 2), tickPaint);
      canvas.restore();
    }

    canvas.restore();

  }
  static double degToRad(double deg) => deg * (pi / 180.0);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MainTicksPainter extends CustomPainter {
  MainTicksPainter( {
    this.offset=0,
    this.startAngle = 135,
    this.sweepAngle = 270,
    this.color = Colors.white,
    this.width = 6,
    this.length = 15,
    this.step = 45,
  });
  final double offset;
  final double startAngle;
  final double sweepAngle;
  final Color color;
  final double width;
  final double length;
  final int step;

  @override
  void paint(Canvas canvas, Size size) {
    final tickPaint = Paint()
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..color = color;

    double start = size.width / 2;
    double end = size.width / 2;
    double minDimension = size.width > size.height ? size.height : size.width;
    var mRadius = minDimension / 2 - offset -8;
    start -= mRadius;
    end -= mRadius - length;

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(-pi);
    canvas.translate(-size.width / 2, -size.height / 2);
    var angles = [for (var i = startAngle; i <= startAngle + sweepAngle; i+= step) i];
    for (double angle in angles ) {
      canvas.save();
      canvas.translate(size.width / 2, size.height / 2);
      canvas.rotate(degToRad(angle));
      canvas.translate(-size.width / 2, -size.height / 2);
      canvas.drawLine(Offset(start, size.height / 2),
          Offset(end, size.height / 2), tickPaint);
      canvas.restore();
    }

    for (double angle in angles ) {
      canvas.save();
      canvas.translate(size.width / 2, size.height / 2);
      canvas.rotate(degToRad(angle));
      canvas.translate(-size.width / 2, -size.height / 2);
      canvas.drawLine(Offset(start, size.height / 2),
          Offset(end, size.height / 2), tickPaint);
      canvas.restore();
    }
    canvas.restore();
  }
  static double degToRad(double deg) => deg * (pi / 180.0);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DotTicksPainter extends CustomPainter {
  DotTicksPainter({
    this.startAngle = 135,
    this.sweepAngle = 270,
    this.showSubTicks = true,
    this.showMainTicks = true,
    this.subTicksColor = Colors.grey,
    this.mainTicksColor = Colors.grey,
  });

  final double startAngle;
  final double sweepAngle;
  final Color subTicksColor;
  final Color mainTicksColor;
  final bool showSubTicks;
  final bool showMainTicks;
  Offset? center;

  @override
  void paint(Canvas canvas, Size size) {
    //get the center of the view
    center = size.center(const Offset(0, 0));
    double minDimension = size.width > size.height ? size.height : size.width;
    var mRadius = minDimension / 2;
    var innerCirclePadding = 90;
    var mDottedCircleRadius = mRadius - innerCirclePadding;

    final tickPaint = Paint()
      ..color = subTicksColor
      ..style = PaintingStyle.fill;

    //draw subDivision dots circle(small one)
    if (showSubTicks) {
      tickPaint.color = Colors.white;
      for (double i = startAngle; startAngle + sweepAngle >= i; i = i + 5) {
        canvas.drawCircle(_getDegreeOffsetOnCircle(mDottedCircleRadius, i), minDimension * .002, tickPaint);
      }
    }
    //draw division dots circle(big one)
    if (showMainTicks) {
      tickPaint.color = Colors.grey;
      for (double i = startAngle; startAngle + sweepAngle >= i; i = i + 45) {
        canvas.drawCircle(_getDegreeOffsetOnCircle(mDottedCircleRadius, i), minDimension * .012, tickPaint);
      }
    }
  }

  static num degToRad(num deg) => deg * (pi / 180.0);

  Offset _getDegreeOffsetOnCircle(double radius, double angle) {
    double radian = degToRad(angle) as double;
    double dx = (center!.dx + radius * cos(radian));
    double dy = (center!.dy + radius * sin(radian));
    return Offset(dx, dy);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


class CirclePainter extends CustomPainter {
  final Color startColor, endColor, capColor;
  final double capSize;
  final Color? borderColor, capBorderColor;
  final double? borderWidth, capBorderWidth;
  CirclePainter({
    required this.startColor,
    required this.endColor,
    required this.capColor,
    required this.capSize,
    this.capBorderColor,
    this.capBorderWidth,
    this.borderColor,
    this.borderWidth
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.width, size.height)*.5;
    final Offset center = Offset(size.width/2, size.height/2);
    final rect = Rect.fromCircle(center: Offset(size.width/2, size.height/2), radius: radius);
    final Gradient gradient = RadialGradient(
      colors: <Color>[
        startColor,
        endColor,
      ],
    );
    var paintFace = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;
    Paint paintFaceBorder = Paint()
      ..color = borderColor!
      ..strokeWidth = borderWidth!
      ..style = PaintingStyle.stroke;

    var paintCap = Paint()
      ..color = capColor
      ..style = PaintingStyle.fill;
    Paint paintCapBorder = Paint()
      ..color = capBorderColor!
      ..strokeWidth = capBorderWidth!
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, paintFace);
    canvas.drawCircle(center, radius-borderWidth!*.5, paintFaceBorder);
    canvas.drawCircle(center, capSize*.5, paintCap);
    canvas.drawCircle(center, capSize*.5, paintCapBorder);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ArcPainter extends CustomPainter {
  ArcPainter( {
    required this.strokeWidth,
    this.startAngle = 0,
    this.sweepAngle = 0,
    this.showSubTicks = true,
    this.showMainTicks =true,
    this.color = Colors.grey,
  });
  final double strokeWidth;
  final double startAngle;
  final double sweepAngle;
  final Color color;
  final bool showSubTicks;
  final bool showMainTicks;
  Offset? center;

  @override
  void paint(Canvas canvas, Size size) {
    final dim = min(size.width, size.height);
    final rect = Rect.fromCircle(center: Offset(size.width/2, size.height/2), radius: dim*.5-strokeWidth);
    final Gradient gradient = RadialGradient(
      colors: <Color>[
        color,
        Colors.teal,
        color,
        Colors.cyan,
        color,
      ],
    );
    const useCenter = false;
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class GaugeMarkerPainter extends CustomPainter {
  GaugeMarkerPainter(this.text, this.position, this.textStyle);

  final String text;
  final TextStyle textStyle;
  final Offset position;

  @override
  void paint(Canvas canvas, Size size) {
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ChildSizeNotifier extends StatelessWidget {
  final ValueNotifier<Size> notifier = ValueNotifier(const Size(0, 0));
  final Widget Function(BuildContext context, Size size, Widget? child) builder;
  final Widget? child;
  ChildSizeNotifier({
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
          (_) {
        notifier.value = (context.findRenderObject() as RenderBox).size;
      },
    );
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: builder,
      child: child,
    );
  }
}

///Customizable Gauge widget for Flutter
class AnotherGauge extends StatefulWidget {
  ///Size of the widget - This widget is rendered in a square shape
  final double gaugeSize;
  ///Offset border from gauge face
  final double borderOffset;
  ///Supply the list of segments in the Gauge.
  ///
  ///If nothing is supplied, the gauge will have one segment with a segment size of (Max Value - Min Value)
  ///painted in defaultSegmentColor
  ///
  ///Each segment is represented by a GaugeSegment object that has a name, segment size and color
  final List<GaugeSegment>? segments;

  ///Supply a min value for the Gauge. Defaults to 0
  final double minValue;

  ///Supply a max value for the Gauge. Defaults to 100
  final double maxValue;

  ///Current value of the Gauge
  final ValueNotifier valueNotifier;

  ///Gauge title
  final String title;

  ///Current value decimal point places
  final int currentValueDecimals;

  ///Custom color for the needle on the Gauge. Defaults to Colors.black
  final Color needleColor;
  final bool rangeNeedleColor;

  ///The default Segment color. Defaults to Colors.grey
  final Color defaultSegmentColor;

  ///Widget that is used to show the current value on the Gauge. Defaults to show the current value as a Decimal with 1 digit
  ///If value must not be shown, supply Container()
  final Widget? valueWidget;
  final double? valueFontSize;
  final Color? valueFontColor;

  /// Add a symbol to value example %, PSI etc
  final String valueSymbol;

  ///Widget to show any other text for the Gauge. Defaults to Container()
  final Widget? displayWidget;

  ///Specify if you want to display Min and Max value on the Gauge widget
  final bool showMarkers;

  ///Custom styling for the Min marker. Defaults to black font with size 10
  final TextStyle startMarkerStyle;

  ///Custom styling for the Max marker. Defaults to black font with size 10
  final TextStyle endMarkerStyle;
  final double? segmentWidth;

  /// Cap settings
  final Color? capColor;

  final double? capSize;
  final double? capBorderWidth;
  final Color? capBorderColor;

  /// Face settings
  final Color? faceStartColor;
  final Color? faceEndColor;
  final Color? faceBorderColor;
  final double? faceBorderWidth;

  final bool showMainTicks;
  final bool showSubTicks;

  /// Frame settings
  final bool showFrame;
  final double frameWidth;
  final Color frameColor;
  final Widget? frameWidget;

  /// Ticks settings
  final Color mainTicksColor;
  final double mainTickWidth;
  final double mainTicksLength;
  final Color subTicksColor;
  final double subTickWidth;
  final double subTicksLength;

  @override
  AnotherGaugeState createState() => AnotherGaugeState();

  AnotherGauge({
    Key? key,
    required this.valueNotifier,
    this.gaugeSize = 200,
    this.borderOffset=16,
    this.segments,
    this.minValue = 0,
    this.maxValue = 100.0,
    this.currentValueDecimals = 1,
    this.needleColor = Colors.black,
    this.defaultSegmentColor = Colors.grey,
    this.valueWidget,
    this.valueFontSize = 10,
    this.valueFontColor = Colors.black,
    this.valueSymbol = '',
    this.title = '',
    this.displayWidget,
    this.showMarkers = true,
    this.segmentWidth = 10,
    this.startMarkerStyle = const TextStyle(fontSize: 10, color: Colors.black),
    this.endMarkerStyle = const TextStyle(fontSize: 10, color: Colors.black),
    this.faceStartColor = Colors.cyan,
    this.faceEndColor = Colors.teal,
    this.faceBorderColor,
    this.faceBorderWidth = 4,
    this.capBorderColor,
    this.capBorderWidth = 4,
    this.capColor,
    this.capSize,
    this.rangeNeedleColor = true,
    this.showMainTicks = true,
    this.showSubTicks = true,
    this.showFrame = true,
    this.frameWidget,
    this.frameWidth = 5,
    this.frameColor = Colors.blueGrey,
    this.mainTicksColor = Colors.white,
    this.mainTickWidth = 6,
    this.mainTicksLength = 15,
    this.subTicksColor = Colors.white,
    this.subTickWidth = 3,
    this.subTicksLength = 0,
  }) : super(key: key);
}

class AnotherGaugeState extends State<AnotherGauge> {
  Color? needleColor;
  List<GaugeSegment>? segments;
  double? gaugeValue;
  @override
  initState() {
    super.initState();
    needleColor = widget.needleColor;
    segments = widget.segments;
    gaugeValue=widget.valueNotifier.value;
  }

  //This method builds out multiple arcs that make up the Gauge
  //using data supplied in the segments property
  List<Widget> buildGauge(List<GaugeSegment> segments, width, height) {
    List<CustomPaint> paint = [];
    double cumulativeSegmentSize = 0.0;
    double gaugeSpread = widget.maxValue - widget.minValue;

    //Iterate through the segments collection in reverse order
    //First paint the arc with the last segment color, then paint multiple arcs in sequence until we reach the first segment

    //Because all these arcs will be painted inside of a Stack, it will overlay to represent the eventual gauge with
    //multiple segments
    paint.add(
      CustomPaint(
        size: Size(width, height),
        painter: CirclePainter(
          startColor: widget.faceStartColor!,
          endColor: widget.faceEndColor!,
          borderColor: widget.faceBorderColor?? Colors.transparent,
          borderWidth: widget.faceBorderWidth,
          capColor: widget.rangeNeedleColor? needleColor!: widget.capColor?? Colors.blueGrey[800]!,
          capSize: widget.capSize?? widget.gaugeSize*.25,
          capBorderColor: widget.capBorderColor?? widget.capColor?? Colors.white,
          capBorderWidth: widget.capBorderWidth! ,
        ),
      ),
    );
    // paint.add(
    //   CustomPaint(
    //     size: Size(widget.capSize!, widget.capSize!),
    //     painter: CirclePainter(
    //         startColor: widget.capColor!,
    //         endColor: widget.capBorderColor?? widget.capColor!,
    //     ),
    //   ),
    // );
    for (var segment in segments.reversed) {
      paint.add(
        CustomPaint(
          size: Size(width, height),
          painter: ArcPainter(
              strokeWidth: widget.segmentWidth!,
              startAngle: 0.75 * pi,
              sweepAngle: 1.5 *
                  ((gaugeSpread - cumulativeSegmentSize) / gaugeSpread) *
                  pi,
              color: segment.segmentColor),
        ),
      );
      cumulativeSegmentSize = cumulativeSegmentSize + segment.segmentSize;
    }

    if (widget.showMainTicks) {
      paint.add(
          CustomPaint(
              size: Size(width, height),
              painter: MainTicksPainter(
                  color: widget.mainTicksColor,
                  width: widget.mainTickWidth,
                  length: widget.mainTicksLength,
                  offset: widget.segmentWidth! + widget.faceBorderWidth!
              )
          )
      );
    }
    if (widget.showSubTicks) {
      paint.add(
          CustomPaint(
              size: Size(width, height),
              painter: SubTicksPainter(
                  color: widget.subTicksColor,
                  width: widget.subTickWidth,
                  length: widget.subTicksLength,
                  offset: widget.segmentWidth! + widget.faceBorderWidth!)
          )
      );
    }
    return paint;
  }

  void updateData() {
    gaugeValue=widget.valueNotifier.value;
    if (widget.valueNotifier.value! < widget.minValue) {
      gaugeValue = widget.minValue;
    }
    if (widget.valueNotifier.value! > widget.maxValue) {
      gaugeValue = widget.maxValue;
    }
    if (segments != null) {
      double totalSegmentSize = 0;
      bool colorUpdated = false;
      for (var segment in segments!) {
        totalSegmentSize = totalSegmentSize + segment.segmentSize;
        if (widget.rangeNeedleColor && (gaugeValue! <= totalSegmentSize)) {
          if (!colorUpdated) {
            needleColor = segment.segmentColor;
            colorUpdated = true;
          }
        }
      }
      if (totalSegmentSize != (widget.maxValue - widget.minValue)) {
        throw Exception('Total segment size must equal (Max Size - Min Size)');
      }
    } else {
      //If no segments are supplied, default to one segment with default color
      segments = [GaugeSegment('', (widget.maxValue - widget.minValue), widget.defaultSegmentColor)];
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentValueDecimalPlaces = widget.currentValueDecimals;

    // Make sure the decimal place if supplied meets Darts bounds (0-20)
    if (currentValueDecimalPlaces < 0) {
      currentValueDecimalPlaces = 0;
    }
    if (currentValueDecimalPlaces > 20) {
      currentValueDecimalPlaces = 20;
    }
    //If segments is supplied, validate that the sum of all segment sizes = (maxValue - minValue)
    //double radius = widget.gaugeSize * 0.9;

    return ValueListenableBuilder(
      valueListenable: widget.valueNotifier,
      builder: (context, value, child) {
        updateData();
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              height: widget.gaugeSize+widget.borderOffset,
              width: widget.gaugeSize+widget.borderOffset,
              child: Stack(
                children: [
                  widget.showFrame?
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: widget.frameColor,
                          width: widget.frameWidth,
                        ),
                        //borderRadius: const BorderRadius.all(Radius.circular(20))
                        borderRadius: BorderRadius.only(bottomRight:Radius.circular((widget.gaugeSize+widget.borderOffset) / 2),
                            bottomLeft:Radius.circular((widget.gaugeSize+widget.borderOffset) / 2),
                            topRight: const Radius.circular(20), topLeft: const Radius.circular(20))
                    ),
                  ) : const SizedBox(),
                  Padding(
                    padding: EdgeInsets.all(widget.borderOffset),
                    child: Stack(
                      children: <Widget>[
                        ...buildGauge(segments!,constraints.maxWidth,constraints.maxHeight),
                        widget.showMarkers
                            ? Container(
                                height: widget.gaugeSize-widget.mainTicksLength-widget.faceBorderWidth!,
                                width: widget.gaugeSize,
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(height: 8,),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,16,0,0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(widget.minValue.toString()),
                                          Text(widget.maxValue.toString()),
                                          //const SizedBox(width: 16,),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            :  const SizedBox(),
                        //face
                        // Center(
                        //   child: Container(
                        //     width: radius,
                        //     height: radius,
                        //     decoration: BoxDecoration(
                        //       gradient: RadialGradient(
                        //         colors: [
                        //           widget.faceStartColor!,
                        //           widget.faceEndColor!,
                        //         ],
                        //       ),
                        //       shape: BoxShape.circle,
                        //       color: Colors.teal,
                        //       border: Border.all(
                        //         width: widget.faceBorderWidth!,
                        //         color: widget.faceBorderColor?? Colors.blueGrey[900]!,
                        //       ),
                        //       //borderRadius: const BorderRadius.all(Radius.circular(20))
                        //     ),
                        //   ),
                        // ),
                        // //cap
                        // Center(
                        //   child: Container(
                        //     width: widget.capSize ?? widget.gaugeSize *0.15,
                        //     height: widget.capSize ?? widget.gaugeSize *0.15,
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       color: widget.rangeNeedleColor? needleColor : widget.capColor?? Colors.blueGrey[800],
                        //       border: Border.all(
                        //         width: widget.capBorderWidth!,
                        //         color: widget.capBorderColor?? Colors.white,
                        //       ),
                        //       //borderRadius: const BorderRadius.all(Radius.circular(20))
                        //     ),
                        //   ),
                        // ),
                        //segments
                        // widget.showMarkers
                        //     ? CustomPaint(
                        //     size: Size(widget.gaugeSize, widget.gaugeSize),
                        //     painter: GaugeMarkerPainter(
                        //         widget.minValue.toString(),
                        //         Offset(widget.gaugeSize * 0.2, widget.gaugeSize * 0.7),
                        //         widget.startMarkerStyle))
                        //     : Container(),
                        // widget.showMarkers
                        //     ? CustomPaint(
                        //     size: Size(widget.gaugeSize, widget.gaugeSize),
                        //     painter: GaugeMarkerPainter(
                        //         widget.maxValue.toString(),
                        //         Offset(widget.gaugeSize*0.7, widget.gaugeSize*0.7),
                        //         widget.endMarkerStyle))
                        //     : Container(),
                        //needle
                        Container(
                          height: widget.gaugeSize+widget.borderOffset,
                          width: widget.gaugeSize+widget.borderOffset,
                          alignment: Alignment.center,
                          child: Transform.rotate(
                            angle: (pi / 4) +
                                ((gaugeValue! - widget.minValue) /
                                    (widget.maxValue - widget.minValue) *
                                    1.5 *
                                    pi),
                            child: ClipPath(
                              clipper: GaugeNeedleClipper(),
                              child: Container(
                                width: widget.gaugeSize*.7- widget.mainTicksLength,
                                height: widget.gaugeSize*.7- widget.mainTicksLength,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: needleColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //title and value
                        Container(
                          height: widget.gaugeSize+widget.borderOffset,
                          width: widget.gaugeSize+widget.borderOffset,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0,(widget.capSize!/2)+widget.mainTicksLength,0,0),
                                child: widget.displayWidget ?? Text(widget.title,style: TextStyle(color: widget.valueFontColor,)),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0,0,0,(widget.capSize!/2)+widget.mainTicksLength),
                                child: widget.valueWidget ??
                                    Text(widget.valueNotifier.value.toStringAsFixed(currentValueDecimalPlaces) +' '+widget.valueSymbol,
                                      style: TextStyle(color: widget.valueFontColor, fontSize: widget.valueFontSize, fontWeight: FontWeight.bold)
                                    ),
                              ),
                              //SizedBox(height: widget.capSize,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        );
      }
    );
  }
}
