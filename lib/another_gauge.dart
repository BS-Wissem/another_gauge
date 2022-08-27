library another_gauge;
//from library another_gauge 1.0.0

// ignore_for_file: must_be_immutable
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
  SubTicksPainter({
    this.startAngle = 135,
    this.sweepAngle = 270,
    this.color = Colors.white,
    this.width = 3,
    this.length = 0,
    this.step = 5,
    required this.radius,
  });

  final double startAngle;
  final double sweepAngle;
  final Color color;
  final double width;
  final double length;
  final int step;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final tickPaint = Paint()
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..color = color;

    double start = size.width / 2;
    double end = size.width / 2;
    // double minDimension = size.width > size.height ? size.height : size.width;
    // var mRadius = minDimension / 2;
    // var innerCirclePadding = 90;
    //var innerCirclePadding = 90;
    //var mRadius = radius - width;
    start -= radius;
    end -= radius - length;

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
    this.startAngle = 135,
    this.sweepAngle = 270,
    this.color = Colors.white,
    this.width = 6,
    this.length = 15,
    this.step = 45,
    required this.radius,
  });

  final double startAngle;
  final double sweepAngle;
  final Color color;
  final double width;
  final double length;
  final int step;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final tickPaint = Paint()
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..color = color;

    double start = size.width / 2;
    double end = size.width / 2;
    // double minDimension = size.width > size.height ? size.height : size.width;
    // var mRadius = minDimension / 2;
    // var innerCirclePadding = 90;
    // mRadius = mRadius - innerCirclePadding;
    // mRadius = radius - innerCirclePadding;
    start -= radius;
    end -= radius - length;

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
  DotTicksPainter( {
    this.startAngle = 135,
    this.sweepAngle = 270,
    this.showSubTicks = true,
    this.showMainTicks =true,
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
      for (double i = startAngle ; startAngle + sweepAngle >= i; i = i + 5) {
        canvas.drawCircle(
            _getDegreeOffsetOnCircle(mDottedCircleRadius, i ),
            minDimension * .002,
            tickPaint);
      }
    }
    //draw division dots circle(big one)
    if (showMainTicks) {
      tickPaint.color = Colors.grey;
      for (double i = startAngle; startAngle + sweepAngle >= i; i = i + 45) {
        canvas.drawCircle(
            _getDegreeOffsetOnCircle(mDottedCircleRadius, i ),
            minDimension * .012,
            tickPaint);
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

class ArcPainter extends CustomPainter {
  ArcPainter( {
    this.startAngle = 0,
    this.sweepAngle = 0,
    this.showSubTicks = true,
    this.showMainTicks =true,
    this.color = Colors.grey,
    required this.strokeWidth
  });

  final double startAngle;
  final double sweepAngle;
  final Color color;
  final double strokeWidth;
  final bool showSubTicks;
  final bool showMainTicks;
  Offset? center;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(size.width * 0.1, size.height * 0.1,
        size.width * 0.9, size.height * 0.9);
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

///Customizable Gauge widget for Flutter
class AnotherGauge extends StatefulWidget {
  ///Size of the widget - This widget is rendered in a square shape
  final double gaugeSize;
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
  double? currentValue;
  ///Current value decimal point places
  final int currentValueDecimals;
  ///Custom color for the needle on the Gauge. Defaults to Colors.black
  Color needleColor;
  bool rangeNeedleColor;
  ///The default Segment color. Defaults to Colors.grey
  final Color defaultSegmentColor;
  ///Widget that is used to show the current value on the Gauge. Defaults to show the current value as a Decimal with 1 digit
  ///If value must not be shown, supply Container()
  final Widget? valueWidget;
  final double? valueFontSize;
  final Color? valueFontColor;
  /// Add a symbol to value example %, PSI etc
  String valueSymbol;
  ///Widget to show any other text for the Gauge. Defaults to Container()
  final Widget? displayWidget;
  ///Specify if you want to display Min and Max value on the Gauge widget
  final bool showMarkers;
  ///Custom styling for the Min marker. Defaults to black font with size 10
  final TextStyle startMarkerStyle;
  ///Custom styling for the Max marker. Defaults to black font with size 10
  final TextStyle endMarkerStyle;
  final double? strokeWidth;

  /// Cap settings
  Color? capColor ;
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

  AnotherGauge(
      {Key? key,
        this.gaugeSize = 200,
        this.segments,
        this.minValue = 0,
        this.maxValue = 100.0,
        this.currentValue,
        this.currentValueDecimals = 1,
        this.needleColor = Colors.black,
        this.defaultSegmentColor = Colors.grey,
        this.valueWidget,
        this.valueFontSize =10,
        this.valueFontColor = Colors.black,
        this.valueSymbol = '',
        this.displayWidget,
        this.showMarkers = true,
        this.strokeWidth = 10,
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
        this.rangeNeedleColor = false,
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
      })
      : super(key: key);
}

class AnotherGaugeState extends State<AnotherGauge> {

  void refresh(value) async {
    setState(() {
      widget.currentValue = value;
    });
  }

  //This method builds out multiple arcs that make up the Gauge
  //using data supplied in the segments property
  List<Widget> buildGauge(List<GaugeSegment> segments) {
    List<CustomPaint> arcs = [];
    double cumulativeSegmentSize = 0.0;
    double gaugeSpread = widget.maxValue - widget.minValue;

    //Iterate through the segments collection in reverse order
    //First paint the arc with the last segment color, then paint multiple arcs in sequence until we reach the first segment

    //Because all these arcs will be painted inside of a Stack, it will overlay to represent the eventual gauge with
    //multiple segments
    for (var segment in segments.reversed) {
      arcs.add(
        CustomPaint(
          size: Size(widget.gaugeSize, widget.gaugeSize),
          painter: ArcPainter(
              strokeWidth: widget.strokeWidth!,
              startAngle: 0.75 * pi,
              sweepAngle: 1.5 *
                  ((gaugeSpread - cumulativeSegmentSize) / gaugeSpread) *
                  pi,
              color: segment.segmentColor),
        ),
      );
      cumulativeSegmentSize = cumulativeSegmentSize + segment.segmentSize;
    }
    if (widget.showSubTicks) {
      arcs.add(
          CustomPaint(
              size: Size(widget.gaugeSize, widget.gaugeSize),
              painter: SubTicksPainter(color: widget.subTicksColor, width: widget.subTickWidth, length: widget.subTicksLength,
                  radius: widget.gaugeSize *.35 )
          )
      );
    }
    if (widget.showMainTicks) {
      arcs.add(
          CustomPaint(
              size: Size(widget.gaugeSize, widget.gaugeSize),
              painter: MainTicksPainter(color: widget.mainTicksColor, width: widget.mainTickWidth,
                  length: widget.mainTicksLength, radius: widget.gaugeSize *.35)
          )
      );
    }
    return arcs;
  }

  @override
  Widget build(BuildContext context) {
    List<GaugeSegment>? segments = widget.segments;
    double? currentValue = widget.currentValue;
    int currentValueDecimalPlaces = widget.currentValueDecimals;

    if (widget.currentValue! < widget.minValue) {
      currentValue = widget.minValue;
    }
    if (widget.currentValue! > widget.maxValue) {
      currentValue = widget.maxValue;
    }
    // Make sure the decimal place if supplied meets Darts bounds (0-20)
    if (currentValueDecimalPlaces < 0) {
      currentValueDecimalPlaces = 0;
    }
    if (currentValueDecimalPlaces > 20) {
      currentValueDecimalPlaces = 20;
    }
    //If segments is supplied, validate that the sum of all segment sizes = (maxValue - minValue)
    if (segments != null) {
      double totalSegmentSize = 0;
      bool colorUpdated = false;
      for (var segment in segments) {
        totalSegmentSize = totalSegmentSize + segment.segmentSize;
        if (widget.rangeNeedleColor && (currentValue! <= totalSegmentSize)) {
          if (!colorUpdated) {
            widget.needleColor = segment.segmentColor;
            widget.capColor = segment.segmentColor;
            colorUpdated = true;
          }
        }
      }
      if (totalSegmentSize != (widget.maxValue - widget.minValue)) {
        throw Exception('Total segment size must equal (Max Size - Min Size)');
      }
    } else {
      //If no segments are supplied, default to one segment with default color
      segments = [
        GaugeSegment('', (widget.maxValue - widget.minValue), widget.defaultSegmentColor)
      ];
    }

    return SizedBox(
      height: widget.gaugeSize,
      width: widget.gaugeSize,
      child: Stack(
        children: <Widget>[
          widget.showFrame?
          widget.frameWidget ??
          Center(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: widget.frameColor,
                    width: widget.frameWidth,
                  ),
                  //borderRadius: const BorderRadius.all(Radius.circular(20))
                  borderRadius: BorderRadius.only(bottomRight:Radius.circular(widget.gaugeSize / 2),
                      bottomLeft:Radius.circular(widget.gaugeSize / 2),
                      topRight: const Radius.circular(20), topLeft: const Radius.circular(20))
              ),
            ),
          ) : const SizedBox(),
          Center(
            child: Container(
              width: widget.gaugeSize * 0.9,
              height: widget.gaugeSize * 0.9,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    widget.faceStartColor!,
                    widget.faceEndColor!,
                  ],
                ),
                shape: BoxShape.circle,
                color: Colors.teal,
                border: Border.all(
                  width: widget.faceBorderWidth!,
                  color: widget.faceBorderColor?? Colors.blueGrey[900]!,
                ),
                //borderRadius: const BorderRadius.all(Radius.circular(20))
              ),
            ),
          ),
          Center(
            child: Container(
              width: widget.capSize ?? widget.gaugeSize *0.15,
              height: widget.capSize ?? widget.gaugeSize *0.15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.capColor?? Colors.blueGrey[800],
                border: Border.all(
                  width: widget.capBorderWidth!,
                  color: widget.capBorderColor?? Colors.white,
                ),
                //borderRadius: const BorderRadius.all(Radius.circular(20))
              ),
            ),
          ),
          ...buildGauge(segments),
          widget.showMarkers
              ? CustomPaint(
              size: Size(widget.gaugeSize, widget.gaugeSize),
              painter: GaugeMarkerPainter(
                  widget.minValue.toString(),
                  Offset(widget.gaugeSize * 0.1, widget.gaugeSize * 0.85),
                  widget.startMarkerStyle))
              : Container(),
          widget.showMarkers
              ? CustomPaint(
              size: Size(widget.gaugeSize, widget.gaugeSize),
              painter: GaugeMarkerPainter(
                  widget.maxValue.toString(),
                  Offset(widget.gaugeSize * 0.8, widget.gaugeSize * 0.85),
                  widget.endMarkerStyle))
              : Container(),
          Container(
            height: widget.gaugeSize,
            width: widget.gaugeSize,
            alignment: Alignment.center,
            child: Transform.rotate(
              angle: (pi / 4) +
                  ((currentValue! - widget.minValue) /
                      (widget.maxValue - widget.minValue) *
                      1.5 *
                      pi),
              child: ClipPath(
                clipper: GaugeNeedleClipper(),
                child: Container(
                  width: widget.gaugeSize * 0.75,
                  height: widget.gaugeSize * 0.75,
                  color: widget.needleColor,
                ),
              ),
            ),
          ),
          Container(
            height: widget.gaugeSize,
            width: widget.gaugeSize,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //const SizedBox(height: 4,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.displayWidget ?? Container(),
                  ],
                ),
                //const SizedBox(height: 16,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.valueWidget ??
                        Text(
                          currentValue.toStringAsFixed(currentValueDecimalPlaces) + widget.valueSymbol,
                          style: TextStyle(color: widget.valueFontColor, fontSize: widget.valueFontSize, fontWeight: FontWeight.bold),),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
