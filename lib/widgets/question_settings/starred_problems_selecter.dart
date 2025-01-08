import 'package:flutter/material.dart';

enum StarredProblemsSelectorMode {
  select,
  unselect,
  all,
}

class StarredProblemsSelector extends StatelessWidget {
  const StarredProblemsSelector({
    super.key,
    required this.selectedMode,
    required this.onModeChanged,
  });

  final StarredProblemsSelectorMode selectedMode;
  final void Function(StarredProblemsSelectorMode) onModeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '별표 문제',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<StarredProblemsSelectorMode>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment<StarredProblemsSelectorMode>(
                value: StarredProblemsSelectorMode.all,
                label: Text('전체'),
              ),
              ButtonSegment<StarredProblemsSelectorMode>(
                value: StarredProblemsSelectorMode.select,
                label: Text('별표만'),
              ),
              ButtonSegment<StarredProblemsSelectorMode>(
                value: StarredProblemsSelectorMode.unselect,
                label: Text('제외'),
              ),
            ],
            selected: {selectedMode},
            onSelectionChanged:
                (Set<StarredProblemsSelectorMode> newSelection) {
              onModeChanged(newSelection.first);
            },
            style: ButtonStyle(
              textStyle: WidgetStateProperty.all(TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              )),
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Theme.of(context).colorScheme.secondary;
                  }
                  return const Color.fromARGB(255, 224, 222, 222);
                },
              ),
              foregroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.white;
                  }
                  return Colors.black;
                },
              ),
              side: WidgetStateProperty.all(BorderSide.none),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
