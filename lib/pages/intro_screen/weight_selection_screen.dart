import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WeightSelectionStep extends StatefulWidget {
  const WeightSelectionStep({super.key});

  @override
  State<WeightSelectionStep> createState() => _WeightSelectionStepState();
}

class _WeightSelectionStepState extends State<WeightSelectionStep> {
  double _weight = 95;
  bool _isKg = true;
  String unit = 'kg';

  final double _minWeightKg = 80;
  final double _maxWeightKg = 116;
  final Color _needleColor = const Color(0xFF522ED2);

  double get _minWeight => _isKg ? _minWeightKg : _minWeightKg * 2.20462;
  double get _maxWeight => _isKg ? _maxWeightKg : _maxWeightKg * 2.20462;

  void _toggleUnit(bool isKg) {
    if (_isKg != isKg) {
      setState(() {
        _isKg = isKg;
        _weight = isKg
            ? (_weight * 0.453592).clamp(_minWeightKg, _maxWeightKg)
            : (_weight * 2.20462).clamp(_minWeight, _maxWeight);
      });
    }
  }

  void _handleLabelFormatting(AxisLabelCreatedArgs args) {
    final double? labelValue = double.tryParse(args.text);
    if (labelValue != null) {
      args.text = labelValue.toStringAsFixed(0);

      if (labelValue.toStringAsFixed(0) == _weight.toStringAsFixed(0)) {
        args.labelStyle = const GaugeTextStyle(
          fontSize: 18,
          color: Color(0xFF522ED2),
          fontWeight: FontWeight.bold,
        );
      } else {
        args.labelStyle = const GaugeTextStyle(
          fontSize: 18,
          color: Color(0xFF4E4866),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _unitSwitcher(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          _buildWeightGauge(),
        ],
      ),
    );
  }

  Widget _buildWeightGauge() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                showAxisLine: false,
                minimum: _minWeight, // 80 (kg) or equivalent in lbs
                maximum: _maxWeight, // 115 (kg) or equivalent in lbs
                isInversed: true,
                startAngle: 180,
                endAngle: 0,
                onLabelCreated: _handleLabelFormatting,
                interval: 5,
                labelsPosition: ElementsPosition.outside,
                majorTickStyle: const MajorTickStyle(
                  length: 0.15,
                  lengthUnit: GaugeSizeUnit.factor,
                  thickness: 2,
                ),
                minorTicksPerInterval: 4,
                pointers: <GaugePointer>[
                  NeedlePointer(
                    value: _weight.clamp(_minWeight, _maxWeight),
                    enableDragging: true,
                    onValueChanged: (value) {
                      setState(() {
                        _weight = value.clamp(_minWeight, _maxWeight);
                      });
                    },
                    needleColor: _needleColor,
                    needleEndWidth: 16,
                    needleLength: 0.6,
                    tailStyle: TailStyle(
                      lengthUnit: GaugeSizeUnit.logicalPixel,
                      color: _needleColor,
                    ),
                    knobStyle: KnobStyle(
                      knobRadius: 16,
                      sizeUnit: GaugeSizeUnit.logicalPixel,
                      color: _needleColor,
                    ),
                  ),
                ],
              ),

            ],
          ),
          Positioned(
            bottom: 270 * 0.20,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: _weight.toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF522ED2),
                    ),
                  ),
                  TextSpan(
                    text: _isKg ? ' Kg' : ' LBS',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF4E4866),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _unitSwitcher() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4F8),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          _unitOption("Kg", _isKg),
          _unitOption("LBS", !_isKg),
        ],
      ),
    );
  }

  Widget _unitOption(String label, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _toggleUnit(label == "Kg"),
        child: Container(
          padding: const EdgeInsets.symmetric( vertical: 18),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF522ED2) : const Color(0xFFF1F4F8),
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF979797),
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}


