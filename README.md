# another_gauge
Fully customizable Gauge widget for Flutter

<img src="https://github.com/BS-Wissem/another_gauge/raw/master/GaugeExample.png" height="480px" >

## Installing:
In your pubspec.yaml, add the following dependency
```yaml
dependencies:
  another_gauge: 1.0.0
```

## Example Usage:
```dart
import 'package:another_gauge/another_gauge.dart';

PrettyGauge(
    gaugeSize: 200,
    segments: [
        GaugeSegment('Low', 20, Colors.red),
        GaugeSegment('Medium', 40, Colors.orange),
        GaugeSegment('High', 40, Colors.green),
    ],
    currentValue: 46,
    displayWidget: Text('Fuel in tank', style: TextStyle(fontSize: 12)),
),

```
## Features:
* Fully featured Gauge widget that is forked from pretty_gauge


## License:
This project is licensed under the BSD 2-Clause license - see the LICENSE file for details