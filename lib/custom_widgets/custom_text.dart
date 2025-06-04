import 'package:flutter/material.dart';

class CustomIntroTitle extends StatelessWidget {
  final String title;

  const CustomIntroTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "$title\n",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4E4866),
                ),
              ),
              const TextSpan(
                text: "Help us to create your personalized plan",
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF626C72),
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
      ],
    );
  }
}
