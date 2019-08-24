import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_map/APIPostRequest.dart';
import 'package:google_map/constant.dart';
import 'package:google_map/tempvariables.dart';
import 'dart:async';
import "package:http/http.dart" as http;
import 'dart:convert';

class FreeSlot extends StatefulWidget {
  

  @override
  _DeatilsState createState() => _DeatilsState();
}

class _DeatilsState extends State<FreeSlot> {
  Future<List<User>> getUsers() async {
    var data =
        await http.get(ParkingConstant.baseURL + "free-slot");

    var jsonData = json.decode(data.body);

    List<User> users = [];
    for (var u in jsonData) {
      User user =
          User(u["id"], u["slot_no"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("available slots"),
      ),
      body: Container(
        child: FutureBuilder(
          future: getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(child: Text("Loading.......")),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      Container(
                        child: Card(
                          elevation: 0.0,
                          child: ListTile(
                            title: Text(snapshot.data[index].slotno),
                            
                          ),
                        ),
                      ),
                   
                    Container(
                        child: FlatButton(
                          child: new Text('Book Parking',
                              style: new TextStyle(color: Colors.white)),
                          onPressed: () {
                            TempSlotnumber.slot="2";
                               bookparking();
                          },
                          color: Colors.blue,
                        ),
                      )
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
  
  void bookparking() async {
    String url = ParkingConstant.baseURL + "book" + "/";
    //var a = 1;
    FormData data = new FormData.from({
      //"id": a,
      "free_slot": TempSlotnumber.slot,
     
    });

    Map<String, dynamic> bookSlot =
        await APIPostRequest().makePostReqUsingDio(url, data);
    Map<String, dynamic> eachService = bookSlot["data"];
    print(eachService);

    // String jsonMap = await APIPostRequest().apiRequest(url, map);
    // Map<String, dynamic> serviceDetail = json.decode(jsonMap);
    // Map<String, dynamic> eachService = serviceDetail['data'];
    // print(eachService);
  }
}

class User {
  final int id;
  final String slotno;


  User(this.id, this.slotno);
}

abstract class Repository {
  Future<User> getUsers(int index);
}

abstract class Cache<T> {
  Future<T> get(int index);

  put(int index, T object);
}
