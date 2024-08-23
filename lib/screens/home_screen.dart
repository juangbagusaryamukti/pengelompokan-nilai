import 'package:flutter/material.dart';
import '../widgets/score_input.dart';
import '../widgets/average_score_input.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeModeChanged;
  final ThemeMode themeMode;

  HomeScreen({required this.onThemeModeChanged, required this.themeMode});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  String _result = '';
  String _averageResult = '';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _updateResult(String result) {
    setState(() {
      _result = result;
    });
  }

  void _updateAverageResult(String result) {
    setState(() {
      _averageResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengelompokan Nilai Siswa', style: Theme.of(context).appBarTheme.titleTextStyle),
        actions: [
          IconButton(
            icon: Icon(
              widget.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: widget.onThemeModeChanged,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Hitung Langsung'),
            Tab(text: 'Hitung Rata-rata'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Masukkan Nilai Siswa:',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ScoreInput(onResult: _updateResult),
                SizedBox(height: 20),
                if (_result.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: Text(
                      _result,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.blueAccent),
                    ),
                  ),
              ],
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Hitung Rata-rata dari Beberapa Nilai:',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                AverageScoreInput(onAverageResult: _updateAverageResult),
                SizedBox(height: 20),
                if (_averageResult.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.greenAccent),
                    ),
                    child: Text(
                      _averageResult,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.greenAccent),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}