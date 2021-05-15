import 'package:flutter/material.dart';

import 'event_creation/personal.dart';

class ProjectCreation extends StatefulWidget {
  @override
  _ProjectCreation createState() => new _ProjectCreation();
}

class _ProjectCreation extends State<ProjectCreation> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Create new project',
      home: new Scaffold(
        appBar: new AppBar(
            title: new Text('Create new event'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ), ),
        body: new Stepper(
          type: StepperType.horizontal,
          currentStep: _currentStep,
          onStepTapped: (int step) => setState(() => _currentStep = step),
          onStepCancel: _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
          onStepContinue: _currentStep < 2 ? () => setState(() => _currentStep += 1) : null,
          controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: onStepCancel,
                  child: ElevatedButton(
                    child: Text(
                      "BACK",
                      style: TextStyle(color: Colors.white),),
                    style: ButtonStyle(
                      backgroundColor: _currentStep < 1 ?
                      MaterialStateColor.resolveWith((states) => Colors.grey) :
                      MaterialStateColor.resolveWith((states) => Colors.amber)
                    )
                  ),
                ),
                TextButton(
                  onPressed: onStepContinue,
                child: ElevatedButton(
                  child: Text(
                      _currentStep < 2 ? "NEXT" : "SAVE",
                      style: TextStyle(color: Colors.white)),
                    style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue)
                      )
                    ),
                  ),
              ],
            );
          },
          steps: <Step>[
            new Step(
            title: new Text('Information'),
            content: Personal(),
            isActive: _currentStep >= 0,
            state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
            ),
            new Step(
              title: new Text('Tasks'),
              content: new Text('This is the second step.'),
              isActive: _currentStep >= 0,
              state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
            ),
            new Step(
              title: new Text('People'),
              content: new Text('This is the third step.'),
              isActive: _currentStep >= 0,
              state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
            ),
          ],
        ),
      ),
    );
  }

}