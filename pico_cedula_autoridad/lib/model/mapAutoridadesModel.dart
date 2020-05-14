import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../bloc_settings.dart';
import '../zipCodesCali.dart';

class MapAutoridadesModel extends BloCSetting {
  static Completer<GoogleMapController> _controller;

  static final Set<Marker> _markers = {};

  static Set<Polygon> _polygons = HashSet<Polygon>();

  static const LatLng center = LatLng(3.4372201, -76.5224991);

  BitmapDescriptor pinLocation;

  Future<void> setMarkersOnInfractorLocation(state) async {
    _controller = Completer();
    _polygons = HashSet<Polygon>();
    setInitSectors();

    QuerySnapshot querySnapshot =
        await Firestore.instance.collection('historyOffenders').getDocuments();
    for (int i = 0; i < querySnapshot.documents.length; i++) {
      var zipCode = querySnapshot.documents[i];
      Future<DocumentSnapshot> users = Firestore.instance
          .collection('historyOffenders')
          .document(zipCode.documentID)
          .get();
      users.then((DocumentSnapshot zipCodeCount) async {
        if (zipCodeCount.exists) {
          var coordinatesMark = getCoordinates(zipCode.documentID);          

          BitmapDescriptor bitmapDescriptor = await createCustomMarkerBitmap(zipCodeCount['cantidad'].toString());
          _markers.add(
            Marker(
              markerId: MarkerId(zipCode.documentID),
              position: LatLng(coordinatesMark[0], coordinatesMark[1]),
              icon: bitmapDescriptor
            )
          );
          

          setSectors(zipCode.documentID, zipCodeCount['cantidad']);
          rebuildWidgets(setStates: () {}, states: [state]);
        }
      });
    }
  }

  static  getCoordinates(zipCode) {
    var zipCoordinates = ZipCodesCali.zipCodesCoordinatesCali;
    zipCode = int.parse(zipCode);
    return zipCoordinates[zipCode];
  }

  static handleClick(String value, BuildContext ctx) {
    switch (value) {
      case 'Logout':
        Navigator.pop(ctx);
        break;
    }
  }

  static get getGoogleController => _controller;
  static get getMarkers => _markers;
  static get getCenter => center;
  static get getPolygons => _polygons;

  static Color setColorSector(cantidad) {
    if (cantidad == 0) {
      return Color.fromRGBO(66, 255, 0, 0.4);
    } else if (cantidad >= 1 && cantidad < 5) {
      return Color.fromRGBO(138, 255, 51, 0.3);
    } else if (cantidad >= 5 && cantidad < 10) {
      return Color.fromRGBO(255, 252, 51, 0.3);
    } else if (cantidad >= 10 && cantidad < 20) {
      return Color.fromRGBO(255, 175, 51, 0.3);
    }
    else if(cantidad >= 20 && cantidad < 30) {
      return Color.fromRGBO(255, 51, 51, 0.3);
    }
    return Color.fromRGBO(255, 0, 0, 0.4);
  }

  static setInitSectors() {
    _polygons.add(Polygon(
      polygonId: PolygonId('760001'),
      points: ZipCodesCali.get760001(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));
    _polygons.add(Polygon(
      polygonId: PolygonId('760002'),
      points: ZipCodesCali.get760002(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));
    _polygons.add(Polygon(
      polygonId: PolygonId('760003'),
      points: ZipCodesCali.get760003(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));
    _polygons.add(Polygon(
      polygonId: PolygonId('760004'),
      points: ZipCodesCali.get760004(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));
    _polygons.add(Polygon(
      polygonId: PolygonId('760005'),
      points: ZipCodesCali.get760005(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760006'),
      points: ZipCodesCali.get760006(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));
    _polygons.add(Polygon(
      polygonId: PolygonId('760010'),
      points: ZipCodesCali.get760010(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760011'),
      points: ZipCodesCali.get760011(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760012'),
      points: ZipCodesCali.get760012(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760010'),
      points: ZipCodesCali.get760010(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760013'),
      points: ZipCodesCali.get760013(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760014'),
      points: ZipCodesCali.get760014(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760015'),
      points: ZipCodesCali.get760015(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760016'),
      points: ZipCodesCali.get760016(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760020'),
      points: ZipCodesCali.get760020(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760022'),
      points: ZipCodesCali.get760022(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760023'),
      points: ZipCodesCali.get760023(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760024'),
      points: ZipCodesCali.get760024(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760025'),
      points: ZipCodesCali.get760025(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760026'),
      points: ZipCodesCali.get760026(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760030'),
      points: ZipCodesCali.get760030(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760031'),
      points: ZipCodesCali.get760031(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760032'),
      points: ZipCodesCali.get760032(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760033'),
      points: ZipCodesCali.get760033(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760034'),
      points: ZipCodesCali.get760034(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760035'),
      points: ZipCodesCali.get760035(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760036'),
      points: ZipCodesCali.get760036(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760040'),
      points: ZipCodesCali.get760040(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760041'),
      points: ZipCodesCali.get760041(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760042'),
      points: ZipCodesCali.get760042(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760043'),
      points: ZipCodesCali.get760043(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760044'),
      points: ZipCodesCali.get760044(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760045'),
      points: ZipCodesCali.get760045(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760046'),
      points: ZipCodesCali.get760046(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));

    _polygons.add(Polygon(
      polygonId: PolygonId('760050'),
      points: ZipCodesCali.get760050(),
      fillColor: setColorSector(0),
      strokeWidth: 1,
    ));
  }

  static setSectors(zipCode, cantidad) {
    zipCode = zipCode.toString();

    if (zipCode == '760001') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760001(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760002') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760002(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760003') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760003(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760004') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760004(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760005') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760005(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760006') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760006(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760010') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760010(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760011') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760011(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760012') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760012(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760013') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760013(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760014') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760014(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760015') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760015(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760016') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760016(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760020') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760020(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760022') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760022(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760023') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760023(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760024') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760024(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760025') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760025(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760026') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760026(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760030') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760030(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760031') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760031(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760032') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760032(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760033') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760033(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760034') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760034(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760035') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760035(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760036') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760036(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760040') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760040(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760041') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760041(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760042') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760042(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760043') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760043(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760044') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760044(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760045') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760045(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760046') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760046(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    } else if (zipCode == '760050') {
      _polygons.removeWhere((p) => p.polygonId.value == zipCode);
      _polygons.add(Polygon(
        polygonId: PolygonId(zipCode),
        points: ZipCodesCali.get760050(),
        fillColor: setColorSector(cantidad),
        strokeWidth: 1,
      ));
    }
  }

  Future<BitmapDescriptor> createCustomMarkerBitmap(String title) async {
    TextSpan span = new TextSpan(
      style: new TextStyle(
        color: Colors.black,
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
      ),
      text: title,
    );

    TextPainter tp = new TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    PictureRecorder recorder = new PictureRecorder();
    Canvas c = new Canvas(recorder);

    tp.layout();
    tp.paint(c, new Offset(20.0, 10.0));

    /* Do your painting of the custom icon here, including drawing text, shapes, etc. */

    Picture p = recorder.endRecording();
    ByteData pngBytes =
        await (await p.toImage(tp.width.toInt() + 40, tp.height.toInt() + 20))
            .toByteData(format: ImageByteFormat.png);

    Uint8List data = Uint8List.view(pngBytes.buffer);

    return BitmapDescriptor.fromBytes(data);
  }
}

MapAutoridadesModel setMarkers;
