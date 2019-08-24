import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_map/constant.dart';
import 'package:google_map/tempvariables.dart';
import 'package:http/http.dart' as http;

class ParkingDetails extends StatefulWidget {
  ParkingDetailsState createState() => new ParkingDetailsState();
}

class ParkingDetailsState extends State<ParkingDetails> {
  Future<Map> getParkingDetails() async {
    http.Response response = await http
        .get(ParkingConstant.baseURL + "park-slot" + "/" +"1");

    Map<String, dynamic> decodedDetailData = json.decode(response.body);
    Map<String, dynamic> resData = decodedDetailData['data'];
    print(resData);
    return resData;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getParkingDetails(),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: content(
                      snapshot.data['location'],
                      snapshot.data['name'],
                      snapshot.data['total_slots'],
                      snapshot.data['free_slots'],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget content(
    String location,
    String name,
    int total_slots,
    int free_slots,
  ) {
    return Column(
      children: <Widget>[
        Container(
          child: Card(
            elevation: 0.0,
            child: ListTile(
              title: Text(
                location,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18.0),
              ),
              trailing: Text(
                "free_slots" + "$free_slots",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0,
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Text(
            name,
            textAlign: TextAlign.center,
          ),
        ),
        ButtonBar(
          children: <Widget>[
            new FlatButton(
              child: new Text('Book now',
                  style: new TextStyle(color: Colors.white)),
              onPressed: () {},
              color: Colors.blue,
            ),
            new FlatButton(
              child:
                  new Text('Cancel', style: new TextStyle(color: Colors.white)),
              onPressed: () {},
              color: Colors.blue,
            ),
          ],
        )
      ],
    );
  }
}
