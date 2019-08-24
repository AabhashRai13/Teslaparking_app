import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_map/details.dart';
import 'package:google_map/tempvariables.dart';
import 'package:latlong/latlong.dart';
import 'package:geocoder/geocoder.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var points = <LatLng>[
    new LatLng(27.6588, 85.3247),
    new LatLng(27.6595, 80.3247),
    new LatLng(37.6308, 92.3247),
    new LatLng(42.6508, 89.3247),
    new LatLng(27.6588, 85.3247),
  ];

  List<Marker> allMarkers = [];
  setMarkers() {
    
    return allMarkers;
  }

  addToList() async {
    final query = "Sathdobato, Lalitpur";
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    setState(() {
     allMarkers.add(
      new Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(first.coordinates.latitude, first.coordinates.longitude),
        builder: (ctx) => Container(
          child: IconButton(
            icon: Icon(Icons.location_on),
            iconSize: 45.0,
            color: Colors.red,
            onPressed:(){TempVariables.id="1";
            Navigator.push(context, MaterialPageRoute(builder: (_) => Details()));
} ,
          ),
        ),
      ),
    );
    
    });
     final queryy = "Hattiban, Lalitpur";
    var addressess = await Geocoder.local.findAddressesFromQuery(queryy);
    var firsts = addressess.first;
    setState(() {
     allMarkers.add(
      new Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(firsts.coordinates.latitude, firsts.coordinates.longitude),
        builder: (ctx) => Container(
          child: IconButton(
            icon: Icon(Icons.location_on),
            iconSize: 45.0,
            color: Colors.red,
            onPressed: () {
           TempVariables.id="2";
            Navigator.push(context, MaterialPageRoute(builder: (_) => Details()));
            },
          ),
        ),
      ),
    );
    
    });
  }

  Future addMarker() async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new SimpleDialog(
            title: new Text(
              'add marker',
              style: new TextStyle(fontSize: 17.0),
            ),
            children: <Widget>[
              new SimpleDialogOption(
                child: new Text("add", style: new TextStyle(color: Colors.blue)),
                onPressed: () {
                  addToList();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Map"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: addMarker,)
        ],
      ),
      body: new FlutterMap(
        options: new MapOptions(
          center: new LatLng(27.6588, 85.3247),
          zoom: 13.0,
        ),
        layers: [
          new TileLayerOptions(
            urlTemplate: "https://api.tiles.mapbox.com/v4/"
                "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
            additionalOptions: {
              'accessToken':
                  'sk.eyJ1IjoiYWFiaGFzaDEzIiwiYSI6ImNqem14cmg3ajE3bjEzYnBtODFjMXJxNGwifQ.KE_66x5Vlyr9ds4XMV7MJg',
              'id': 'mapbox.streets',
            },
          ),
          new MarkerLayerOptions(markers: setMarkers()),
          // new PolylineLayerOptions(
          //   polylines: [
          //     new Polyline(
          //       points: points,
          //       strokeWidth: 5.0,
          //       color: Colors.red
          //     )
          //   ]
          // )
        ],
      ),
    );
  }
}
