import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Hello Native'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('com.example.hello_native/channel');

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  bool isLoading = true;
  late LinkedHashMap dataStepper;

  @override
  void initState() {
    if (Platform.isAndroid) {
      _getChannelData();
    }
    super.initState();
  }

  void onStepTapped(int step) {
    setState(() => _currentStep = step);
  }

  void onStepContinue() {
    _currentStep < dataStepper.length - 1
        ? setState(() => _currentStep += 1)
        : null;
  }

  void onStepCancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  Future<void> _getChannelData() async {
    try {
      dataStepper = await platform.invokeMethod('stepper');
    } on PlatformException catch (e) {
      debugPrint('Error >>> ${e.message}');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : Stepper(
              type: stepperType,
              currentStep: _currentStep,
              onStepTapped: (step) => onStepTapped(step),
              onStepContinue: onStepContinue,
              onStepCancel: onStepCancel,
              steps: buildStepper,
            ),
    );
  }

  List<Step> get buildStepper {
    List<Step> result = [];
    int index = 0;

    dataStepper.forEach((key, value) {
      result.add(Step(
        title: Text(key ?? ''),
        content: Text(value ?? ''),
        subtitle: Text(index == dataStepper.length - 1 ? "Last Page" : ""),
        isActive: _currentStep >= index,
        state: _currentStep >= index ? StepState.complete : StepState.disabled,
      ));
      index += 1;
    });

    return result;
  }
}
