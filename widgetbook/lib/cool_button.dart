import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the widget from your app

@widgetbook.UseCase(name: 'Default', type: CoolButton)
Widget buildContainerUseCase(BuildContext context) {
  return const CoolButton();
}

class CoolButton extends StatelessWidget {
  const CoolButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30,
        width: double.infinity,
        child: TextButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amberAccent),
          child: const Text('PRESS'),
        ),
      ),
    );
  }
}
