import 'package:forest1/main.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:passcode_screen/passcode_screen.dart';

class PassCodePage extends StatefulWidget {
  const PassCodePage({Key? key}) : super(key: key);

  @override
  _PassCodePageState createState() => _PassCodePageState();
}

class _PassCodePageState extends State<PassCodePage> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  bool isAuthenticated = false;

  void homepage(bool checker) {
    if (checker == true) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
        title: const Text('All in One Forestery App'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isAuthenticated
                  ? 'You are authenticated'
                  : 'You are not authenticated',
            ),
            Visibility(
              visible: !isAuthenticated,
              child: ElevatedButton(
                onPressed: isAuthenticated ? null : _showLockScreen,
                child: Text('Enter App Passcode'),
              ),
            ),
            Visibility(
              visible: isAuthenticated,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text("Enter"),
                onPressed: () {
                  homepage(isAuthenticated);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MyHomePage(
                            title: "",
                          )));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showLockScreen() {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) => PasscodeScreen(
          title: const Text(
            'Enter App Passcode',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          circleUIConfig: const CircleUIConfig(
            borderColor: Colors.white,
            fillColor: Colors.white,
            circleSize: 30,
          ),
          keyboardUIConfig: const KeyboardUIConfig(
            digitBorderWidth: 2,
            primaryColor: Colors.white,
          ),
          passwordEnteredCallback: _onPasscodeEntered,
          cancelButton: const Text(
            'Cancel',
            style: TextStyle(fontSize: 16, color: Colors.white),
            semanticsLabel: 'Cancel',
          ),
          deleteButton: const Text(
            'Delete',
            style: TextStyle(fontSize: 16, color: Colors.white),
            semanticsLabel: 'Delete',
          ),
          shouldTriggerVerification: _verificationNotifier.stream,
          backgroundColor: Colors.black.withOpacity(0.8),
          cancelCallback: _onPasscodeCancelled,
          digits: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
        ),
      ),
    );
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = '002023' == enteredPasscode;
    _verificationNotifier.add(isValid);
    if (isValid) {
      setState(() {
        this.isAuthenticated = true;
      });
      //Navigator.of(context).pop(); // pop the passcode screen
      // push the home page
    }
  }

  _onPasscodeCancelled() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Welcome to the home page!'),
      ),
    );
  }
}
