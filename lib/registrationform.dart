import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_map/APIPostRequest.dart';
import 'package:google_map/constant.dart';
import 'package:google_map/homepage.dart';

class RegistrationForm extends StatefulWidget {
  RegistrationForm({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RegistrationFromState();
}

class RegistrationFromState extends State<RegistrationForm>
    with SingleTickerProviderStateMixin {
  int state = 0;
  double width = double.infinity;
  GlobalKey globalKey = GlobalKey();

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  bool isInsured = false;
  DateTime purchaseDate, insuranceEffectiveFromDate, insuranceEffectiveToDate;
  String name, password, licenseNumber, username, vechicleNumber;

  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final licenseController = TextEditingController();
  final vehiclenumberController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: new EdgeInsets.all(10.0),
          child: Form(
            child: formUI(),
            key: _key,
            autovalidate: _validate,
          ),
        ),
      ),
    );
  }

  Widget formUI() {
    return new Column(
      children: <Widget>[
        ListTile(
          title: Text(
            "Name",
            style: titleStyle(),
          ),
          subtitle: new TextFormField(
            controller: nameController,
            decoration: new InputDecoration(hintText: 'Name'),
            maxLength: 32,
            validator: validateName,
            onSaved: (String val) {
              name = val;
            },
          ),
        ),
        ListTile(
          title: Text(
            "Username",
            style: titleStyle(),
          ),
          subtitle: new TextFormField(
              controller: usernameController,
              decoration: new InputDecoration(hintText: 'username'),
              maxLength: 32,
              validator: validateUserName,
              onSaved: (String val) {
                username = val;
              }),
        ),
        ListTile(
          title: Text(
            "Password",
            style: titleStyle(),
          ),
          subtitle: new TextFormField(
              controller: passwordController,
              decoration: new InputDecoration(hintText: 'Password'),
              maxLength: 10,
              validator: validatePassword,
              onSaved: (String val) {
                password = val;
              }),
        ),
        ListTile(
          title: Text(
            "License number",
            style: titleStyle(),
          ),
          subtitle: new TextFormField(
              controller: licenseController,
              decoration: new InputDecoration(hintText: 'License number'),
              maxLength: 10,
              validator: validateLicenseNumber,
              onSaved: (String val) {
                licenseNumber = val;
              }),
          //onsaved is missing here
        ),
        Divider(),
        ListTile(
          title: Text(
            "Vehicle number",
            style: titleStyle(),
          ),
          subtitle: new TextFormField(
              controller: vehiclenumberController,
              decoration: new InputDecoration(hintText: 'Vechilce number'),
              maxLength: 32,
              validator: validateVechilceNumber,
              onSaved: (String val) {
                vechicleNumber = val;
              }),
        ),
        Divider(),
        new RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          padding: EdgeInsets.all(0.0),
          color: Color.fromRGBO(42, 85, 150, 1.0),
          onPressed: () {
            _sendToServer();
          },
          child: Text(
            'Submit',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        new RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          padding: EdgeInsets.all(0.0),
          color: Color.fromRGBO(42, 85, 150, 1.0),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new HomePage(),
              ),
            );
          },
          child: Text(
            'Go',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  String validateName(String value) {
    if (value.length == 0) {
      return "Name is Required";
    } else {
      return null;
    }
  }

  String validateUserName(String value) {
    if (value.length == 0) {
      return "Username is Required";
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.length == 0) {
      return "Password is Required";
    } else
      return null;
  }

  String validateLicenseNumber(String value) {
    if (value.length == 0) {
      return "License number is required";
    } else
      return null;
  }

  String validateVechilceNumber(String value) {
    if (value.length == 0) {
      return "Enter your vechilce number";
    } else
      return null;
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      // No any error in validation
      registerUser();

      _key.currentState.save();
      registerUser();
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }

//   _submit() async {
// var url =
//         "https://f4216ebc.ngrok.io/api/registration/";

//     try {
//       var dio = new Dio();
//       var response = await dio.post(
//         url,
//         queryParameters: {

//     "name": "Aabhash rai",
//     "username": "sazds",
//     "password": "adfas",
//     "vehicle_number": "55655",
//     "licence_number": "65464"
//         },
//         options: Options(
//           followRedirects: false,
//         validateStatus: (status) { return status < 500; }
//         ),
//       );

//       print(response.toString());
//     } on DioError catch (error) {
//       if (error.response.statusCode == 302) {
//         print("nani kore ? : " + error.toString());
//       }
//     }

  void registerUser() async {
    String url = ParkingConstant.baseURL + "registration" + "/";
    //var a = 1;
    FormData data = new FormData.from({
      //"id": a,
      "name": name,
      "username": username,
      "password": password,
      "licence_number": licenseNumber,
      "vehicle_number": vechicleNumber,
    });

    Map<String, dynamic> addRegister =
        await APIPostRequest().makePostReqUsingDio(url, data);
    Map<String, dynamic> eachService = addRegister["data"];
    print(eachService);

    // String jsonMap = await APIPostRequest().apiRequest(url, map);
    // Map<String, dynamic> serviceDetail = json.decode(jsonMap);
    // Map<String, dynamic> eachService = serviceDetail['data'];
    // print(eachService);
  }

  TextStyle titleStyle() {
    return TextStyle(
      fontSize: 20.0,
      color: Colors.indigo,
      decorationThickness: 2.0,
    );
  }
}

