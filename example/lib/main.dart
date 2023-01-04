import 'package:flutter/material.dart';
import 'package:seven_star_utils/seven_star_utils.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    SevenStarUtils.setAppContext(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seven Star Utils'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SevenStarQtyChanger(
              initialValue: 1,
              onChanged: (qty) {},
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const ActionResultDialog(
                        dialogType: DialogType.warning,
                      );
                    });
              },
              child: const Text('Dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
