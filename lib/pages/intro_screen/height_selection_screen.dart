import 'package:flutter/material.dart';

class HeightSelectionStep extends StatefulWidget {
  const HeightSelectionStep({super.key});

  @override
  State<HeightSelectionStep> createState() => _HeightSelectionStepState();
}

class _HeightSelectionStepState extends State<HeightSelectionStep> {
  final int minHeight = 1000;
  final int maxHeight = 2500;
  final int step = 25;

  late final List<int> heights;
  late final FixedExtentScrollController _controller;
  int _selectedHeight = 1650;

  @override
  void initState() {
    super.initState();
    heights = List.generate(
      ((maxHeight - minHeight) ~/ step + 1),
          (index) => minHeight + index * step,
    );
    _controller = FixedExtentScrollController(
      initialItem: (_selectedHeight - minHeight) ~/ step,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.1,
      child: Column(
        children: [
          const _HeightUnitLabel(),
          Expanded(
            child: _HeightSelectorWidget(
              heights: heights,
              controller: _controller,
              selectedHeight: _selectedHeight,
              onHeightChanged: (value) {
                setState(() => _selectedHeight = value);
              },
            ),
          ),
          SizedBox(height: size.height * 0.06),
        ],
      ),
    );
  }

}

class _HeightUnitLabel extends StatelessWidget {
  const _HeightUnitLabel();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF522ED2),
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      child: const Text(
        'Cm',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }
}

class _HeightSelectorWidget extends StatelessWidget {
  final List<int> heights;
  final FixedExtentScrollController controller;
  final int selectedHeight;
  final ValueChanged<int> onHeightChanged;

  const _HeightSelectorWidget({
    required this.heights,
    required this.controller,
    required this.selectedHeight,
    required this.onHeightChanged,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset(
          'assets/human.png',
          height: 260,
          color: const Color(0xFFB39DDB),
        ),
        SizedBox(width: screenWidth * 0.10),
        _HeightGauge(
          controller: controller,
          heights: heights,
          selectedHeight: selectedHeight,
          onHeightChanged: onHeightChanged,
        ),
      ],
    );
  }
}

class _HeightGauge extends StatelessWidget {
  final FixedExtentScrollController controller;
  final List<int> heights;
  final int selectedHeight;
  final ValueChanged<int> onHeightChanged;

  const _HeightGauge({
    required this.controller,
    required this.heights,
    required this.selectedHeight,
    required this.onHeightChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 90,
            height: 310,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFF1F4F8), width: 8),
            ),
            child: ListWheelScrollView.useDelegate(
              controller: controller,
              itemExtent: 17,
              perspective: 0.009,
              diameterRatio: 100,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) =>
                  onHeightChanged(heights[index]),
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: heights.length,
                builder: (context, index) {
                  final value = heights[index];
                  final isMajorTick = value % 50 == 0;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: isMajorTick
                            ? Text(
                          (value ~/ 10).toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: value == selectedHeight
                                ? const Color(0xFF522ED2)
                                : const Color(0xFF979797),
                          ),
                        )
                            : const SizedBox.shrink(),
                      ),
                      Container(
                        width: isMajorTick ? 25 : 15,
                        height: 5,
                        color: const Color(0xFFF1F4F8),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const Positioned(
            left: -20,
            child: Icon(
              Icons.play_arrow,
              color: Color(0xFF522ED2),
              size: 45,
            ),
          ),
        ],
      ),
    );
  }
}
