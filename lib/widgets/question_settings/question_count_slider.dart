import 'package:flutter/material.dart';

class QuestionCountSlider extends StatelessWidget {
  const QuestionCountSlider(
      {super.key,
      required this.questionCount,
      required this.onChanged,
      required this.max});
  final double questionCount;
  final Function(double) onChanged;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '문제 수: ${questionCount.round()}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        if (max > 1) ...[
          SizedBox(
            // Stack을 위한 고정 높이 컨테이너
            height: 40, // 슬라이더에 충분한 높이 제공
            child: Stack(
              children: [
                Positioned(
                  left: -15,
                  right: -15,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 9.0,
                      thumbColor: Theme.of(context).colorScheme.secondary,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 9.0,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 20.0,
                      ),
                      activeTrackColor: Theme.of(context).colorScheme.secondary,
                      inactiveTrackColor: Colors.grey[300],
                      valueIndicatorShape:
                          const PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: Colors.black,
                      valueIndicatorTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    child: Slider(
                      value: questionCount.toDouble(),
                      min: 1,
                      max: max.toDouble(),
                      divisions: max - 1,
                      label: questionCount.round().toString(),
                      onChanged: onChanged,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$max',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
