
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pico_cedula_autoridad/model/mapAutoridadesModel.dart';

class MapAutoridadesController extends ControllerMVC {

  getGoogleController() => MapAutoridadesModel.getGoogleController;
  getMarkers() => MapAutoridadesModel.getMarkers;
  getCenter() => MapAutoridadesModel.getCenter;
  handleClick(_value, _ctx) => MapAutoridadesModel.handleClick(_value, _ctx);
  getPolygons() => MapAutoridadesModel.getPolygons;
}