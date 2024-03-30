import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentStep = 0;

  _stepState(int step) {
    if (_currentStep > step) {
      return StepState.complete;
    } else {
      return StepState.editing;
    }
  }

  get _steps => [
        Step(
          title: const Text('Address'),
          content: const _AddressForm(),
          state: _stepState(0),
          isActive: _currentStep == 0,
        ),
        Step(
          title: const Text('Card Details'),
          content: const _CardForm(),
          state: _stepState(1),
          isActive: _currentStep == 1,
        ),
        Step(
          title: const Text('Overview'),
          content: const _Overview(),
          state: _stepState(2),
        )
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stepper demo"),
      ),
      body: Stepper(
        controlsBuilder: (context, controls) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              children: [
                Flexible(
                  child: ElevatedButton(
                    onPressed: controls.onStepContinue,
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.blueAccent),
                    ),
                    child: const Text(
                      "NEXT",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                if (_currentStep != 0)
                  TextButton(
                    onPressed: controls.onStepCancel,
                    child: const Text(
                      'BACK',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
              ],
            ),
          );
        },
        type: StepperType.vertical,
        connectorThickness: 3,
        connectorColor: const MaterialStatePropertyAll(Colors.blue),
        onStepTapped: (step) => setState(() => _currentStep = step),
        onStepContinue: () => setState(() {
          if (_currentStep < _steps.length - 1) {
            _currentStep += 1;
          } else {
            _currentStep = 0;
          }
        }),
        onStepCancel: () => setState(() {
          if (_currentStep > 0) {
            _currentStep -= 1;
          } else {
            _currentStep = 0;
          }
        }),
        currentStep: _currentStep,
        steps: _steps,
      ),
    );
  }
}

class _AddressForm extends StatelessWidget {
  const _AddressForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(labelText: 'Street'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'City'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Postcode'),
        ),
      ],
    );
  }
}

class _CardForm extends StatelessWidget {
  const _CardForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(labelText: 'Card number'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Expiry date'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'CVV'),
        ),
      ],
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Center(child: Text('Thank you for your order!')),
      ],
    );
  }
}
