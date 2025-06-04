import 'package:flutter/material.dart';

class GenderSelectionStep extends StatefulWidget {
  const GenderSelectionStep({super.key});

  @override
  State<GenderSelectionStep> createState() => _GenderSelectionStepState();
}

class _GenderSelectionStepState extends State<GenderSelectionStep> {
  String selectedGender = 'Male';

  void _selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
    debugPrint("Selected Gender: $gender");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _GenderAvatar(
                gender: 'Female',
                assetPath: 'assets/female.png',
                isSelected: selectedGender == 'Female',
                onTap: () => _selectGender('Female'),
              ),
              _GenderAvatar(
                gender: 'Male',
                assetPath: 'assets/male.png',
                isSelected: selectedGender == 'Male',
                onTap: () => _selectGender('Male'),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),

          ElevatedButton(
            onPressed: () => _selectGender('Other'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Color(0xFFE9E9E9)),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Text(
                "Other",
                style: TextStyle(
                  color: selectedGender == 'Other'
                      ? Colors.deepPurple
                      : const Color(0xFF4E4866),
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),

          Container(
            margin:  EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F4F8),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['Female', 'Male', 'Other'].map((gender) {
                final isSelected = selectedGender == gender;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => _selectGender(gender),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF522ED2)
                            : const Color(0xFFF1F4F8),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        gender,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF979797),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _GenderAvatar extends StatelessWidget {
  final String gender;
  final String assetPath;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderAvatar({
    required this.gender,
    required this.assetPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  assetPath,
                  width: 100,
                  height: 170,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                gender,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          if (isSelected)
            const Positioned(
              top: 4,
              right: 4,
              child: Icon(
                Icons.radio_button_checked,
                color: Color(0xFF522ED2),
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}
