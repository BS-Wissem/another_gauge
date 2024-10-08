library another_gauge;

import 'dart:math';

import 'package:flutter/material.dart';

///Class that holds the details of each segment on a CustomGauge with automatic value assignment
class GaugeRange {
  final Color color;
  final String? name;
  final double? position;
  double? size;
  GaugeRange(this.color,{this.name, this.position, this.size});
}

///Class that holds the details of each segment on a CustomGauge
///@Deprecated('Use AutoGaugeSegment')
class GaugeSegment implements Exception {
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
    this.offset = 0,
    this.startAngle = 135,
    this.sweepAngle = 270,
    this.color = Colors.white,
    this.width = 3,
    this.length = 0,
    this.step = 5,
    this.minValue = 0,
    this.maxValue = 100,
  });

  final double offset;
  final double startAngle;
  final double sweepAngle;
  final Color color;
  final double width;
  final double length;
  final int step;
  final double maxValue;
  final double minValue;

  @override
  void paint(Canvas canvas, Size size) {
    final tickPaint = Paint()
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..color = color;

    double start = size.width / 2;
    double end = size.width / 2;
    double tickAngle = sweepAngle * step / (maxValue - minValue);
    double minDimension = size.width > size.height ? size.height : size.width;
    var mRadius = minDimension / 2 - offset - 8;
    start -= mRadius;
    end -= mRadius - length;

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(-pi);
    canvas.translate(-size.width / 2, -size.height / 2);
    var angles = [
      for (var i = startAngle; i <= startAngle + sweepAngle; i += tickAngle) i
    ];
    for (double angle in angles) {
      canvas.save();
      canvas.translate(size.width / 2, size.height / 2);
      canvas.rotate(degToRad(angle));
      canvas.translate(-size.width / 2, -size.height / 2);
      canvas.drawLine(Offset(start, size.height / 2),
          Offset(end, size.height / 2), tickPaint);
      canvas.restore();
    }

    for (double angle in angles) {
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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MainTicksPainter extends CustomPainter {
  MainTicksPainter({
    this.offset = 0,
    this.startAngle = 135,
    this.sweepAngle = 270,
    this.color = Colors.white,
    this.width = 6,
    this.length = 15,
    this.step = 45,
    this.showValue = false,
    this.showMarkers = true,
    this.gaugeSpread = 100.0,
    this.minValue = 0,
    this.maxValue = 100,
    this.fontSize = 16,
    this.valuePadding = 8,
  });

  final double offset;
  final double startAngle;
  final double sweepAngle;
  final Color color;
  final double width;
  final double length;
  final int step;
  final bool showValue;
  final bool showMarkers;
  final double gaugeSpread;
  final double minValue;
  final double maxValue;
  final double valuePadding;
  final double fontSize;

  @override
  void paint(Canvas canvas, Size size) {
    final tickPaint = Paint()
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..color = color;

    double start = size.width / 2;
    double end = size.width / 2;
    double minDimension = size.width > size.height ? size.height : size.width;
    var mRadius = minDimension / 2 - offset - 8;
    start -= mRadius;
    end -= mRadius - length;
    double tickAngle = sweepAngle * step / (maxValue - minValue);
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(-pi);
    canvas.translate(-size.width / 2, -size.height / 2);
    List<double> angles = [
      for (double i = startAngle; i <= startAngle + sweepAngle; i += tickAngle)
        i
    ];
    //List<double> angles = List.generate(tickCount, (index) => index + step * 1.0);
    for (double angle in angles) {
      canvas.save();
      canvas.translate(size.width / 2, size.height / 2);
      canvas.rotate(degToRad(angle));
      canvas.translate(-size.width / 2, -size.height / 2);
      canvas.drawLine(Offset(start, size.height / 2),
          Offset(end, size.height / 2), tickPaint);
      canvas.restore();
    }
    int count = 0;
    for (double angle in angles) {
      canvas.save();
      canvas.translate(size.width / 2, size.height / 2);
      canvas.rotate(degToRad(angle));
      canvas.translate(-size.width / 2, -size.height / 2);
      canvas.drawLine(Offset(start, size.height / 2),
          Offset(end, size.height / 2), tickPaint);
      double tickValue = count * step + minValue;
      if (angle == angles.first) tickValue = minValue;
      if (angle == angles.last) tickValue = maxValue;
      Offset valueOffset =
          Offset(end + valuePadding, (size.height / 2) - valuePadding);
      if (showValue) {
        TextSpan textSpan = TextSpan(
          text: '$tickValue',
          style: TextStyle(
            color: color,
            fontSize: fontSize,
          ),
        );
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(
          minWidth: 0,
          maxWidth: size.width,
        );
        final pivot = textPainter.size.center(valueOffset);
        canvas.translate(pivot.dx, pivot.dy);
        canvas.rotate(degToRad(180 - angle));
        canvas.translate(-pivot.dx, -pivot.dy);
        textPainter.paint(canvas, valueOffset);
      } else if (showMarkers && angle == angles.first || angle == angles.last) {
        TextSpan textSpan = TextSpan(
          text: '$tickValue',
          style: TextStyle(
            color: color,
            fontSize: fontSize,
          ),
        );
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(
          minWidth: 0,
          maxWidth: size.width,
        );
        final pivot = textPainter.size.center(valueOffset);
        canvas.translate(pivot.dx, pivot.dy);
        canvas.rotate(degToRad(180 - angle));
        canvas.translate(-pivot.dx, -pivot.dy);
        textPainter.paint(canvas, valueOffset);
      }
      count++;
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

class CirclePainter extends CustomPainter {
  final Color startColor, endColor, capColor;
  final double capSize;
  final Color? borderColor, capBorderColor;
  final double? borderWidth, capBorderWidth;

  CirclePainter(
      {required this.startColor,
      required this.endColor,
      required this.capColor,
      required this.capSize,
      this.capBorderColor,
      this.capBorderWidth,
      this.borderColor,
      this.borderWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.width, size.height) * .5;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius);
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
    canvas.drawCircle(center, radius - borderWidth! * .5, paintFaceBorder);
    canvas.drawCircle(center, capSize * .5, paintCap);
    canvas.drawCircle(center, capSize * .5, paintCapBorder);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ArcPainter extends CustomPainter {
  ArcPainter({
    required this.strokeWidth,
    this.startAngle = 0,
    this.sweepAngle = 0,
    this.showSubTicks = true,
    this.showMainTicks = true,
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
    final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: dim * .5 - strokeWidth);
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

class CustomTextPainter extends CustomPainter {
  CustomTextPainter(
      {required this.text, required this.offset, required this.textStyle});

  final String text;
  final TextStyle textStyle;
  final Offset offset;

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
    textPainter.paint(canvas, offset);
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

  ///List of ranges in the Gauge.
  ///
  ///If nothing is supplied, the gauge will have one range (Max Value - Min Value)
  ///painted in defaultSegmentColor
  ///Each segment is represented by a GaugeRange object that has a color
  final List<GaugeRange>? ranges;

  ///Supply a min value for the Gauge. Defaults to 0
  final double minValue;

  ///Supply a max value for the Gauge. Defaults to 100
  final double maxValue;

  /// Needle start angle 0 is located at 3 o'clock
  final double needleStartAngle;

  ///Needle sweep angle
  final double needleSweepAngle;

  final double mainTicksValuePadding;

  final double mainTicksFontSize;

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
  final EdgeInsets? valuePadding;

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
  final bool showMainTickValue;
  final int mainTicksStep;
  //final int subTicksStep;

  /// Frame settings
  final bool showFrame;
  final double frameWidth;
  final double frameAngle;
  final Color frameColor;
  final Color frameBackgroundColor;
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
    this.borderOffset = 16,
    @Deprecated('Use autoSegments')
    this.segments,
    this.ranges,
    this.minValue = 0,
    this.maxValue = 100.0,
    this.needleStartAngle = 135,
    this.needleSweepAngle = 270,
    this.currentValueDecimals = 1,
    this.needleColor = Colors.black,
    this.defaultSegmentColor = Colors.grey,
    this.valueWidget,
    this.valueFontSize = 10,
    this.valueFontColor = Colors.black,
    this.valueSymbol = '',
    this.valuePadding,
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
    this.showMainTickValue = false,
    this.showSubTicks = true,
    this.showFrame = true,
    this.frameWidget,
    this.mainTicksValuePadding = 8,
    this.mainTicksFontSize = 16,
    this.mainTicksStep = 45,
    //this.subTicksStep = 5,
    this.frameWidth = 5,
    this.frameAngle = 0,
    this.frameColor = Colors.blueGrey,
    this.frameBackgroundColor = Colors.transparent,
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
  List<GaugeRange>? ranges;
  double? gaugeValue;

  @override
  initState() {
    super.initState();
    needleColor = widget.needleColor;
    segments = widget.segments;
    ranges = widget.ranges;
    //temporary mode until segment will be removed
    if (ranges!=null) {
      segments = [];
      double totalRange = widget.maxValue - widget.minValue;
      int sizeNotAssignedCount = 0;
      widget.ranges!.asMap().forEach((index, r) {
        double priorSize =0;
        if (index>0) priorSize = widget.ranges![index-1].position?? 0;
        //TODO fix use with position instead of size
        if (r.position!=null && false) {
          totalRange-= r.position! - priorSize;
        } else if (r.size !=null) {
          totalRange-= r.size!;
        } else {
          sizeNotAssignedCount++;
        }
      });

      for (GaugeRange r in widget.ranges!) {
        if (r.size==null && sizeNotAssignedCount!=0) {
          r.size=totalRange/sizeNotAssignedCount;
        }
        segments!.add(GaugeSegment(r.name?? '', r.size!, r.color));
      }
    }
    gaugeValue = widget.valueNotifier.value;
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
          borderColor: widget.faceBorderColor ?? Colors.transparent,
          borderWidth: widget.faceBorderWidth,
          capColor: widget.rangeNeedleColor
              ? needleColor!
              : widget.capColor ?? Colors.blueGrey[800]!,
          capSize: widget.capSize ?? widget.gaugeSize * .25,
          capBorderColor:
              widget.capBorderColor ?? widget.capColor ?? Colors.white,
          capBorderWidth: widget.capBorderWidth!,
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
              //startAngle: widget.needleStartAngle,
              //sweepAngle: widget.needleSweepAngle,
              startAngle: degToRad(widget.needleStartAngle),
              sweepAngle:
                  ((gaugeSpread - cumulativeSegmentSize) / gaugeSpread) *
                      degToRad(widget.needleSweepAngle),
              color: segment.segmentColor),
        ),
      );
      cumulativeSegmentSize = cumulativeSegmentSize + segment.segmentSize;
    }

    if (widget.showMainTicks) {
      paint.add(CustomPaint(
          size: Size(width, height),
          painter: MainTicksPainter(
              color: widget.mainTicksColor,
              width: widget.mainTickWidth,
              length: widget.mainTicksLength,
              showValue: widget.showMainTickValue,
              showMarkers: widget.showMarkers,
              gaugeSpread: gaugeSpread,
              minValue: widget.minValue,
              maxValue: widget.maxValue,
              step: widget.mainTicksStep,
              startAngle: widget.needleStartAngle,
              sweepAngle: widget.needleSweepAngle,
              valuePadding: widget.mainTicksValuePadding,
              fontSize: widget.mainTicksFontSize,
              offset: widget.segmentWidth! + widget.faceBorderWidth!)));
    }
    if (widget.showSubTicks) {
      paint.add(CustomPaint(
          size: Size(width, height),
          painter: SubTicksPainter(
              color: widget.subTicksColor,
              width: widget.subTickWidth,
              length: widget.subTicksLength,
              minValue: widget.minValue,
              maxValue: widget.maxValue,
              startAngle: widget.needleStartAngle,
              sweepAngle: widget.needleSweepAngle,
              //step: widget.subTicksStep,
              offset: widget.segmentWidth! + widget.faceBorderWidth!)));
    }
    return paint;
  }

  void updateData() {
    gaugeValue = widget.valueNotifier.value;
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
      if (totalSegmentSize!=0 && totalSegmentSize != (widget.maxValue - widget.minValue)) {
        throw Exception('Total segment size must equal (Max Size - Min Size)');
      }
    } else {
      //If no segments are supplied, default to one segment with default color
      segments = [
        GaugeSegment(
            '', (widget.maxValue - widget.minValue), widget.defaultSegmentColor)
      ];
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
          return ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: widget.gaugeSize + widget.borderOffset,
                maxWidth: widget.gaugeSize + widget.borderOffset),
            child: Stack(
              alignment: Alignment.center,
              children: [
                widget.showFrame
                    ? Transform.rotate(
                        angle: degToRad(widget.frameAngle),
                        child: Container(
                          width: widget.gaugeSize + widget.borderOffset,
                          height: widget.gaugeSize + widget.borderOffset,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: widget.frameBackgroundColor,
                              border: Border.all(
                                color: widget.frameColor,
                                width: widget.frameWidth,
                              ),
                              //borderRadius: const BorderRadius.all(Radius.circular(20))
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(
                                      (widget.gaugeSize + widget.borderOffset) /
                                          2),
                                  bottomLeft: Radius.circular(
                                      (widget.gaugeSize + widget.borderOffset) /
                                          2),
                                  topRight: const Radius.circular(20),
                                  topLeft: const Radius.circular(20))),
                        ),
                      )
                    : const SizedBox(),
                Padding(
                  padding: EdgeInsets.all(widget.borderOffset),
                  child: Stack(
                    children: <Widget>[
                      ...buildGauge(
                          segments!,
                          widget.gaugeSize + widget.borderOffset,
                          widget.gaugeSize + widget.borderOffset),
                      Container(
                        height: widget.gaugeSize + widget.borderOffset,
                        width: widget.gaugeSize + widget.borderOffset,
                        alignment: Alignment.center,
                        child: Transform.rotate(
                          angle: degToRad(widget.needleStartAngle) -
                              pi / 2 +
                              ((gaugeValue! - widget.minValue) /
                                  (widget.maxValue - widget.minValue) *
                                  degToRad(widget.needleSweepAngle)),
                          child: ClipPath(
                            clipper: GaugeNeedleClipper(),
                            child: Container(
                              width: widget.gaugeSize * .7 -
                                  widget.mainTicksLength,
                              height: widget.gaugeSize * .7 -
                                  widget.mainTicksLength,
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
                        height: widget.gaugeSize + widget.borderOffset,
                        width: widget.gaugeSize + widget.borderOffset,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0,
                                  (widget.capSize! / 2) +
                                      widget.mainTicksLength,
                                  0,
                                  0),
                              child: widget.displayWidget ??
                                  Text(widget.title,
                                      style: TextStyle(
                                        color: widget.valueFontColor,
                                      )),
                            ),
                            Padding(
                              padding: widget.valuePadding ??
                                  EdgeInsets.fromLTRB(
                                      0,
                                      0,
                                      0,
                                      (widget.capSize! / 2) +
                                          widget.mainTicksLength),
                              child: widget.valueWidget ??
                                  Text(
                                      widget.valueNotifier.value
                                              .toStringAsFixed(
                                                  currentValueDecimalPlaces) +
                                          ' ' +
                                          widget.valueSymbol,
                                      style: TextStyle(
                                          color: widget.valueFontColor,
                                          fontSize: widget.valueFontSize,
                                          fontWeight: FontWeight.bold)),
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
        });
  }
}

double degToRad(double deg) => deg * (pi / 180.0);
