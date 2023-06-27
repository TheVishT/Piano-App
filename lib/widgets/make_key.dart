import 'package:flutter/material.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:tonic/tonic.dart';

Widget makeKey(int midi, bool accidental, bool showNote, double keyWidth) {
  const borderradius = BorderRadius.only(
      bottomLeft: Radius.circular(9.0), bottomRight: Radius.circular(9.0));
  final pitchName = Pitch.fromMidiNumber(midi).toString();
  final pianoKey = Stack(
    children: [
      Material(
          borderRadius: borderradius,
          color: accidental ? Colors.black : Colors.white,
          child: InkWell(
            enableFeedback: false,
            borderRadius: borderradius,
            highlightColor: Colors.grey,
            onTap: () {},
            onTapDown: (_) => FlutterMidi().playMidiNote(midi: midi),
          )),
      Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 20.0,
          child: showNote
              ? Text(
                  pitchName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: accidental ? Colors.white : Colors.black),
                )
              : Container()),
    ],
  );
  if (accidental) {
    return Container(
      width: keyWidth,
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      padding: EdgeInsets.symmetric(horizontal: keyWidth * 0.09),
      child: Material(
        elevation: 7.0,
        borderRadius: borderradius,
        shadowColor: const Color.fromARGB(128, 32, 141, 230),
        child: pianoKey,
      ),
    );
  }
  return Container(
    width: keyWidth,
    margin: const EdgeInsets.symmetric(horizontal: 2.0),
    child: pianoKey,
  );
}
