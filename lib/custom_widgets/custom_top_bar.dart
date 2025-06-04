import 'package:flutter/material.dart';

class CustomTopBar extends StatelessWidget {
  final int currentPage;
  final int totalSteps;
  final bool showSkip;
  final VoidCallback? onSkip;
  final VoidCallback? onBack;

  const CustomTopBar({
    super.key,
    required this.currentPage,
    required this.totalSteps,
    this.onSkip,
    this.onBack,
    this.showSkip = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              if (onBack != null)
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: onBack,
                    child: const Icon(Icons.arrow_back, size: 24),
                  ),
                ),
              const Spacer(),
              if (showSkip && onSkip != null)
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: onSkip,
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: Color(0xFF522ED2),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              totalSteps,
                  (index) => Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: 65,
                height: 5,
                decoration: BoxDecoration(
                  color: index <= currentPage
                      ? const Color(0xFF522ED2)
                      : const Color(0xFFF1F4F8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
