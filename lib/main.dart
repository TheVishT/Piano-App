import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:piano_flutter/widgets/make_key.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    FlutterMidi().unmute();
    rootBundle.load("assets/sounds/Piano.sf2").then((sf2) {
      FlutterMidi().prepare(sf2: sf2, name: "Piano.sf2");
    });
    super.initState();
  }

  double widthRatio = 0.0;
  double get keyWidth => 78 + (78 * widthRatio);
  bool showNote = true;
  bool scrolllock = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              const ListTile(title: Text("Change Width")),
              Slider(
                  activeColor: Colors.green[400],
                  inactiveColor: Colors.white,
                  min: 0.0,
                  max: 1.0,
                  value: widthRatio,
                  onChanged: (double value) =>
                      setState(() => widthRatio = value)),
              Divider(
                color: Colors.grey[400],
              ),
              ListTile(
                title: const Text("Show Note Labels"),
                trailing: Switch(
                  value: showNote,
                  activeColor: Colors.green[400],
                  onChanged: (bool value) => setState(() => showNote = value),
                ),
              ),
              Divider(
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: 7,
          scrollDirection: Axis.horizontal,
          controller: ScrollController(initialScrollOffset: 1475.0),
          itemBuilder: (BuildContext context, int index) {
            final int i = 24 + index * 12;
            return SafeArea(
              child: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      makeKey(i, false, showNote, keyWidth),
                      makeKey(i + 2, false, showNote, keyWidth),
                      makeKey(i + 4, false, showNote, keyWidth),
                      makeKey(i + 5, false, showNote, keyWidth),
                      makeKey(i + 7, false, showNote, keyWidth),
                      makeKey(i + 9, false, showNote, keyWidth),
                      makeKey(i + 11, false, showNote, keyWidth),
                    ],
                  ),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 100,
                    top: 0.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: keyWidth * 0.5),
                        makeKey(i + 1, true, showNote, keyWidth),
                        makeKey(i + 3, true, showNote, keyWidth),
                        SizedBox(width: keyWidth),
                        makeKey(i + 6, true, showNote, keyWidth),
                        makeKey(i + 8, true, showNote, keyWidth),
                        makeKey(i + 10, true, showNote, keyWidth),
                        SizedBox(width: keyWidth * 0.5),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
