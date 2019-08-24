import 'package:flutter/material.dart';
import 'package:google_map/constant.dart';
import 'package:google_map/freeslot.dart';
import 'package:google_map/tempvariables.dart';
import 'dart:async';
import "package:http/http.dart" as http;
import 'dart:convert';

class Details extends StatefulWidget {
  

  @override
  _DeatilsState createState() => _DeatilsState();
}

class _DeatilsState extends State<Details> {
  Future<List<User>> getUsers() async {
    var data =
        await http.get(ParkingConstant.baseURL + "park-slot" + "/" + TempVariables.id);

    var jsonData = json.decode(data.body);

    List<User> users = [];
    for (var u in jsonData) {
      User user =
          User(u["location"], u["name"], u["total_slot"], u["free_slots"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parking Details"),
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
                            title: Text(snapshot.data[index].location),
                          ),
                        ),
                      ),
                      Container(
                          child: ListTile(
                        title: Text(snapshot.data[index].name),
                      )),
                      Container(
                          child: ListTile(
                        title: Text(snapshot.data[index].totalslot),
                      )),
                      Container(
                          child: ListTile(
                        title: Text(snapshot.data[index].freeslot),
                      )),
                      Container(
                        child: FlatButton(
                          child: new Text('Book Parking',
                              style: new TextStyle(color: Colors.white)),
                          onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => FreeSlot()));
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
}

class User {
  final String location;
  final String name;
  final String totalslot;
  final String freeslot;

  User(this.location, this.name, this.totalslot, this.freeslot);
}

abstract class Repository {
  Future<User> getUsers(int index);
}

abstract class Cache<T> {
  Future<T> get(int index);

  put(int index, T object);
}
