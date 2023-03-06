import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VeneerVolume extends StatefulWidget {
  const VeneerVolume({Key? key}) : super(key: key);

  @override
  State<VeneerVolume> createState() => _VeneerVolumeState();
}

class _VeneerVolumeState extends State<VeneerVolume> {
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
    double innerThickness = thick / 1000;
    double volume;

    volume = (innerThickness * innerWidth * length * noOfPieces);

    value.addAll([volume, innerThickness, innerWidth, length, noOfPieces]);
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50))),
        title: const Text(
          "Veneer Volume Calculator",
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
                          'Volume (m3):  $volume',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),

                          // ),
                        ),
                        trailing: const Icon(
                          Icons.check_circle,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                      CupertinoIcons
                                          .rectangle_compress_vertical,
                                      size: 17),
                                  Text('Thickness(m):  $thickness'),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                              Row(children: [
                                const Icon(
                                    CupertinoIcons.rectangle_expand_vertical,
                                    size: 17),
                                Text('Width (m):  $width'),
                              ]),
                              Row(
                                children: [
                                  const Icon(
                                      CupertinoIcons
                                          .arrow_left_right_square_fill,
                                      size: 17),
                                  Text('Length (m):  $length'),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(CupertinoIcons.square_stack_3d_up,
                                      size: 17, color: Colors.green),
                                  Text('N0. Sheet:  $noOfPieces'),
                                ],
                              )
                            ],
                          ),
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
                                "NO. of Sheet",
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
                                  thickness = funcResults[1].toStringAsFixed(2);
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
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        //insert_chart
        child: const Icon(Icons.bookmarks),
        backgroundColor: Colors.orange,
        splashColor: Colors.lightGreenAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        color: Colors.orange,
        shape: CircularNotchedRectangle(), //shape of notch
        notchMargin:
            5, //notche margin between floating button and bottom appbar
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
