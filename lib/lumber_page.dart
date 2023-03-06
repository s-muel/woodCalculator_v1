import 'package:flutter/material.dart';

class LumberVolume extends StatefulWidget {
  const LumberVolume({Key? key}) : super(key: key);

  @override
  State<LumberVolume> createState() => _LumberVolumeState();
}

class _LumberVolumeState extends State<LumberVolume> {
  // form Controllers
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController thicknessController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController noOfPiecesController = TextEditingController();

  // initial Variables for the card
  String volume = "";
  String thickness = "";
  String width = "";
  String length = "";
  String noOfPieces = "";

//function for volume
  List result(double thick, double width, double length, double noOfPieces) {
    List value = [];
    double innerWidth = width / 1000;
    double innerLength = length / 1000;
    double volume;

    volume = thick * innerWidth * innerLength * noOfPieces;

    value.addAll([volume, thick, innerWidth, innerLength, noOfPieces]);
    return value;
  }

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
      body: ListView(
        children: [
          Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 5,
                      shadowColor: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            'Volume (m):  $volume',
                            style: const TextStyle(fontWeight: FontWeight.bold),

                            // ),
                          ),
                          trailing: const Icon(
                            Icons.check_circle,
                          ),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.arrow_circle_up),
                                  Text('Thickness(m):$thickness'),
                                  const Icon(Icons.arrow_upward_rounded),
                                  Text('Width (m):$width'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.arrow_upward_rounded),
                                  Text('Length (m):$length'),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(Icons.arrow_upward_rounded),
                                  Text('N0. Pieces:$noOfPieces'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100.0,
                    ),

                    // begin of textField
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '* Required';
                                }
                                return null;
                              },
                              controller: thicknessController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                label: Text(
                                  "Thickness",
                                  style: TextStyle(fontSize: 12),
                                ),
                                border: OutlineInputBorder(),
                                hintText: 'mm',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '* Required';
                                }
                                return null;
                              },
                              controller: widthController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                label: Text(
                                  "Width",
                                  style: TextStyle(fontSize: 12),
                                ),
                                border: OutlineInputBorder(),
                                hintText: 'mm',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '* Required';
                                }
                                return null;
                              },
                              controller: lengthController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                label: Text(
                                  "Length",
                                  style: TextStyle(fontSize: 12),
                                ),
                                border: OutlineInputBorder(),
                                hintText: 'm',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '* Required';
                                }
                                return null;
                              },
                              controller: noOfPiecesController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                label: Text(
                                  "NO. of Pieces",
                                  style: TextStyle(fontSize: 12),
                                ),
                                border: OutlineInputBorder(),
                                hintText: '0',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                              ),
                              onPressed: () async {
                                // double noOf =
                                // String noOf = noOfPiecesController.text;
                                // print(noOf);
                                if (_formKey.currentState!.validate()) {
                                  List funcResults = result(
                                    double.parse(thicknessController.text),
                                    double.parse(widthController.text),
                                    double.parse(lengthController.text),
                                    double.parse(noOfPiecesController.text),
                                  );
                                  setState(() {
                                    volume = funcResults[0].toStringAsFixed(3);
                                    thickness =
                                        funcResults[1].toStringAsFixed(2);
                                    width = funcResults[2].toStringAsFixed(2);
                                    length = funcResults[3].toStringAsFixed(2);
                                    noOfPieces =
                                        funcResults[4].toStringAsFixed(2);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Processing Done')));
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                              ),
                              onPressed: () {
                                return setState(() {
                                  //clearing the form fields
                                  _formKey.currentState!.reset();
                                  thicknessController.clear();
                                  widthController.clear();
                                  lengthController.clear();
                                  noOfPiecesController.clear();

                                  // clearing the card results
                                  volume = "";
                                  thickness = "";
                                  width = "";
                                  length = "";
                                  noOfPieces = "";
                                });
                              },
                              child: const Text('Clear')),
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
