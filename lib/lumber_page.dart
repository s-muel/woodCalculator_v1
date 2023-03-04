import 'package:flutter/material.dart';

class LumberVolume extends StatefulWidget {
  const LumberVolume({Key? key}) : super(key: key);

  @override
  State<LumberVolume> createState() => _LumberVolumeState();
}

class _LumberVolumeState extends State<LumberVolume> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50))),
        title: const Text(
          "Lumber Volume Calculator",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          "Coming Soon",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
