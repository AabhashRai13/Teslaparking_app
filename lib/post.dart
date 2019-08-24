import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
 
class Post {
  final String name;
  final int vehiclenumber;
  final String username;
  final String password;
  final String licensenumber;
 
  Post({this.name, this.vehiclenumber, this.username, this.password, this.licensenumber});
 
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      name: json['name'],
      vehiclenumber: json['vehicle_number'],
      username: json['username'],
      password: json['password'],
      licensenumber: json['licnce_number']
    );
  }
 
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["username"] = username;
    map["password"] = password;
    map["vehicle_number"] = vehiclenumber;
    map["license_number"]= licensenumber;
 
    return map;
  }
}
 
Future<Post> createPost(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Post.fromJson(json.decode(response.body));
  });
}
 
class Upload extends StatelessWidget {
  final Future<Post> post;
 
  Upload({Key key, this.post}) : super(key: key);
  static final CREATE_POST_URL = 'https://44955065.ngrok.io/api/registration/';
  TextEditingController titleControler = new TextEditingController();
  TextEditingController bodyControler = new TextEditingController();
    TextEditingController passwordControler = new TextEditingController();

  TextEditingController licenseControler = new TextEditingController();

  TextEditingController vehilceControler = new TextEditingController();

 
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "WEB SERVICE",
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Create Post'),
          ),
          body: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new Column(
              children: <Widget>[
                new TextField(
                  controller: titleControler,
                  decoration: InputDecoration(
                      hintText: "title....", labelText: 'Post Title'),
                ),
                new TextField(
                  controller: bodyControler,
                  decoration: InputDecoration(
                      hintText: "body....", labelText: 'Post Body'),
                ),
                 new TextField(
                  controller: licenseControler,
                  decoration: InputDecoration(
                      hintText: "license", labelText: 'Post Body'),
                ),
                 new TextField(
                  controller: passwordControler,
                  decoration: InputDecoration(
                      hintText: "password", labelText: 'Post Body'),
                ),
                 new TextField(
                  controller: vehilceControler,
                  decoration: InputDecoration(
                      hintText: "vehicle number", labelText: 'Post Body'),
                ),
                new RaisedButton(
                  onPressed: () async {
                    Post newPost = new Post(
                         name: titleControler.text, username: bodyControler.text);
                    Post p = await createPost(CREATE_POST_URL,
                        body: newPost.toMap());
                    print(p.name);
                  },
                  child: const Text("Create"),
                )
              ],
            ),
          )),
    );
  }
}
 void main() => runApp(Upload());