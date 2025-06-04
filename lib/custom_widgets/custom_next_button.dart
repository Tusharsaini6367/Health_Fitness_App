import 'package:flutter/material.dart';

class CustomNextButton extends StatelessWidget {
  final VoidCallback onTap;
  final double progress;

  const CustomNextButton({
    super.key,
    required this.onTap,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 66,
          height: 66,
          child: Transform.rotate(
            angle: 3.14159,
            child: CircularProgressIndicator(
              value: progress, // from 0.0 to 1.0
              strokeWidth: 5,
              backgroundColor: Colors.transparent,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF522ED2)),
            ),
          )
        ),

        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF522ED2),
            ),
            child: const Icon(Icons.arrow_forward, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
