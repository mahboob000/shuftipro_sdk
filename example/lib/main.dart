import 'package:flutter/material.dart';
import 'package:shuftipro_sdk/shuftipro_sdk.dart';
import 'dart:convert';

String clientId =
    ""; // enter client id here
String secretKey = ""; // enter secret key here

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
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'OpenSans'),
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
  var authObject = {
    "auth_type": "basic_auth",
    "client_id": clientId,
    "secret_key": secretKey,
  };
  Map<String, Object> createdPayload = {
    "country": "",
    "language": "EN",
    "email": "",
    "callback_url": "http://www.example.com",
    "redirect_url": "https://www.mydummy.package_sample.com/",
    "show_consent": 1,
    "show_privacy_policy": 1,
    "verification_mode": "image_only",
    "face": {
      "proof": "",
    },
    "document": {
      "supported_types": [
        "passport",
        "id_card",
        "driving_license",
        "credit_or_debit_card",
      ],
      "name": {
        "first_name": "",
        "last_name": "",
        "middle_name": "",
      },
      "dob": "",
      "document_number": "",
      "expiry_date": "",
      "issue_date": "",
      "gender": "",
      "backside_proof_required": "0",
    },
  };
  Map<String, Object> configObj = {
    "open_webview": false,
    "asyncRequest": false,
    "captureEnabled": false,
    "dark_mode": false,
    "show_requirement_page": true,
    "font_color": "#263B54",
    "button_text_color": "#FFFFFF",
    "button_background_color": "#1F5AF6"
  };

  /*
   * This function sends call to the Shuftipro's flutter plugin
   * and receives the response in a variable
   */

  Future<void> initPlatformState() async {
    String response = "";
    try {
      response = await ShuftiproSdk.sendRequest(
          authObject: authObject,
          createdPayload: createdPayload,
          configObject: configObj);
      var object = jsonDecode(response);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(object.toString()),
      ));

      print(object.toString());
      print(object["event"].toString());
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
  }

  /*
   * Click listener to start the SDK flow
   */

  void continueFun() {
    var v = DateTime.now();
    var reference = "package_sample_Flutter_$v";
    createdPayload["reference"] = reference;
    initPlatformState();
  }

  /*
   * UI of demo application
   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(10.0),
            child: OutlinedButton(
              onPressed: continueFun,
              style:
                  OutlinedButton.styleFrom(backgroundColor: Colors.blueAccent),
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  "Continue",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
