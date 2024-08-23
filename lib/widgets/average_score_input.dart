import 'package:flutter/material.dart';

class AverageScoreInput extends StatefulWidget {
  final Function(String) onAverageResult;

  AverageScoreInput({required this.onAverageResult});

  @override
  _AverageScoreInputState createState() => _AverageScoreInputState();
}

class _AverageScoreInputState extends State<AverageScoreInput> {
  final _controllers = List.generate(5, (index) => TextEditingController());

  void _calculateAverageCategory() {
    List<int> scores = [];
    for (var controller in _controllers) {
      final score = int.tryParse(controller.text);
      if (score != null && score >= 0 && score <= 100) {
        scores.add(score);
      }
    }

    if (scores.isEmpty) {
      widget.onAverageResult('Masukkan nilai yang valid.');
      return;
    }

    final averageScore = scores.reduce((a, b) => a + b) / scores.length;
    String averageResult;

    if (averageScore >= 85) {
      averageResult = 'Kategori Rata-rata: A';
    } else if (averageScore >= 70) {
      averageResult = 'Kategori Rata-rata: B';
    } else if (averageScore >= 55) {
      averageResult = 'Kategori Rata-rata: C';
    } else {
      averageResult = 'Kategori Rata-rata: D';
    }

    widget.onAverageResult(averageResult);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Masukkan 5 Nilai:'),
        SizedBox(height: 10),
        ..._controllers.map((controller) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nilai (0-100)',
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
        )),
        ElevatedButton(
          onPressed: _calculateAverageCategory,
          child: Text('Hitung Rata-rata'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}