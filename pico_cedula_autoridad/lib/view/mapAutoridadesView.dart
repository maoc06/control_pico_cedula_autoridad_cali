import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pico_cedula_autoridad/controller/mapAutoridadesController.dart';
import 'package:pico_cedula_autoridad/model/mapAutoridadesModel.dart';

class MapAurtoridades extends StatefulWidget {

  MapAurtoridades({Key key}): super(key: key);

  final MapInfrantores state = MapInfrantores();

  @override
  MapInfrantores createState() => state;
}

class MapInfrantores extends StateMVC<MapAurtoridades> {

  MapInfrantores(): super(MapAutoridadesController()){
    _con = controller;
  }
  MapAutoridadesController _con;

  @override
  void initState() {
    super.initState();

    setMarkers = MapAutoridadesModel();
    setMarkers.setMarkersOnInfractorLocation(this);
    // setMa

    // setMarkers.setPolygons();
  }
  
  void _onMapCreated(GoogleMapController controller) {
     _con.getGoogleController().complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        title: Text('Mapa de Infrantores'),
        backgroundColor: Colors.pink[400],
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              _con.handleClick(value, this.context);
            },
            itemBuilder: (BuildContext context) {
              return {'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
        leading: new Container(),
      ),
      body: Stack(children: <Widget>[
        GoogleMap(
          // markers: _markers,
          onMapCreated: _onMapCreated,
          
          initialCameraPosition: CameraPosition(
            target: _con.getCenter(),
            zoom: 11.0,
          ),
         
          markers: _con.getMarkers(),
          polygons: _con.getPolygons(),
        ),     
      ]),
    ));
  }
}