import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'weatherDataNotifier.dart';
import 'resultMainText.dart';
import 'resultOtherText.dart';
import 'resultTempText.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  int _selectedIndex = 0;

  // ページの一覧
  final _pages = const [
    ResultMainText(),
    ResultTempText(),
    ResultOtherText(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => WeatherDataNotifier(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: _pages,
        ),
        floatingActionButton: Consumer<WeatherDataNotifier>(
          builder: (context, weather, _) => FloatingActionButton(
            onPressed: () { weather.updateWeather(); },
          )
        )
      )
    );
  }
}
