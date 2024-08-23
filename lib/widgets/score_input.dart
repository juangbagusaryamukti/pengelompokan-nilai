import 'package:flutter/material.dart';

class ScoreInput extends StatefulWidget {
  final Function(String) onResult;

  ScoreInput({required this.onResult});

  @override
  _ScoreInputState createState() => _ScoreInputState();
}

class _ScoreInputState extends State<ScoreInput> {
  final _controller = TextEditingController();

  void _calculateCategory() {
    final input = _controller.text;
    final score = int.tryParse(input);

    if (score == null || score < 0 || score > 100) {
      widget.onResult('Input tidak valid! Masukkan nilai antara 0 hingga 100.');
    } else {
      String result;
      if (score >= 85) {
        result = 'Kategori: A';
      } else if (score >= 70) {
        result = 'Kategori: B';
      } else if (score >= 55) {
        result = 'Kategori: C';
      } else {
        result = 'Kategori: D';
      }
      widget.onResult(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Masukkan Nilai (0-100)',
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _calculateCategory,
          child: Text('Hitung'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}