
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:riderapp/Assistants/requestAssistant.dart';
import 'package:riderapp/DataHandler/appData.dart';
import 'package:riderapp/Models/address.dart';
import 'package:riderapp/Models/directDetails.dart';
import 'package:riderapp/configMaps.dart';

class AssistantMethods
{
  static Future<String> searchCoordinateAddress(Position position,context) async
  {
    String placeAddress="";
    String url="https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapkey";

    var response = await RequestAssistant.getRequest(Uri.parse(url));

    if (response!="failed"){
      placeAddress= response["results"][0]["formatted_address"];

      Address userPickupAddress= new Address(placeFormattedAddress:"", placeName:"", placeId:"", latitude: 0, longitude:0);
      userPickupAddress.longitude=position.longitude;
      userPickupAddress.latitude=position.latitude;
      userPickupAddress.placeName=placeAddress;


      Provider.of<AppData>(context,listen: false).updatePickUpLocationAddress(userPickupAddress);

    }
    return placeAddress;

  }

  static Future<DirectionDetails?> obtainDirectionDetails(LatLng initialPosition,LatLng finalPosition) async
  {
    String directionUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapkey";

    var res = await RequestAssistant.getRequest(Uri.parse(directionUrl));
    if (res=="failed")
      {
        return null;
      }
    
    DirectionDetails directionDetails =DirectionDetails(distanceValue: "", durationValue: "", distanceText: "", durationText: "", encodedPoints: "");
    directionDetails.encodedPoints= res["routes"][0]["overview_polyline"]["points"];
    directionDetails.distanceText= res["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.distanceValue= res["routes"][0]["legs"][0]["distance"]["value"];
    directionDetails.durationText= res["routes"][0]["legs"][0]["duration"]["text"];
    directionDetails.durationValue= res["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetails;


  }
}