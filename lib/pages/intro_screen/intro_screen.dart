import 'package:flutter/material.dart';
import 'package:health_fit/pages/intro_screen/gender_selection_screen.dart';
import 'package:health_fit/pages/intro_screen/height_selection_screen.dart';
import 'package:health_fit/pages/intro_screen/weight_selection_screen.dart';

import '../../custom_widgets/custom_next_button.dart';
import '../../custom_widgets/custom_text.dart';
import '../../custom_widgets/custom_top_bar.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentPage = 0;

  final List<_IntroStep> steps = [
    _IntroStep(widget: Center( child: Image.asset(
      'assets/human.png',
      height: 300,
      color: const Color(0xFFB39DDB))),  title: "Health fit"),
    const _IntroStep(widget: GenderSelectionStep(), title: "What's your gender"),
    const _IntroStep(widget: HeightSelectionStep(), title: "What's your height?"),
    const _IntroStep(widget: WeightSelectionStep(), title: "What's your weight?"),
  ];

  void goToNextStep() {
    if (currentPage < steps.length - 1) {
      setState(() => currentPage++);
    }
  }

  void skipToLastStep() {
    setState(() => currentPage = steps.length - 1);
  }

  void goBack() {
    if (currentPage > 0) {
      setState(() => currentPage--);
    }
  }

  int getVisibleStepIndex() =>
      steps.sublist(0, currentPage).where((step) => step.showInSteps).length;

  int getTotalVisibleSteps() =>
      steps.where((step) => step.showInSteps).length;

  double getProgressPercent() {
    final total = getTotalVisibleSteps();
    if (total == 0) return 0;

    double progress = getVisibleStepIndex() / total;

    switch (currentPage) {
      case 0:
        return 0.25;
      case 1:
        return 0.50;
      case 2:
        return 0.75;
      case 3:
        return 1.0;
      default:
        return progress;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = steps[currentPage];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (currentStep.showInSteps)
              CustomTopBar(
                currentPage: getVisibleStepIndex(),
                totalSteps: getTotalVisibleSteps(),
                onSkip: currentPage < steps.length - 1 ? skipToLastStep : null,
                onBack: currentPage > 0 ? goBack : null,
              ),

            if (currentStep.showInSteps && currentStep.title != null)
              CustomIntroTitle(title: currentStep.title!),

            Expanded(child: currentStep.widget),

            CustomNextButton(
              onTap: goToNextStep,
              progress: getProgressPercent(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          ],
        ),
      ),
    );
  }
}

class _IntroStep {
  final Widget widget;
  final String? title;
  final bool showInSteps;

  const _IntroStep({
    required this.widget,
    this.title,
    this.showInSteps = true,
  });
}
