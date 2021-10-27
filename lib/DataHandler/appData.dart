import 'package:flutter/cupertino.dart';
import 'package:riderapp/Models/address.dart';

class AppData extends ChangeNotifier{


 late Address pickUpLocation=Address(placeFormattedAddress: '', placeName: '', placeId: '', latitude:0.0, longitude: 0.0);
 late Address dropOffLocation;


void updatePickUpLocationAddress(Address pickUpAddress)
{
  pickUpLocation=pickUpAddress;
  notifyListeners();

}

 void updateDropOffLocationAddress(Address dropOffLocation)
 {
   dropOffLocation = dropOffLocation;
   notifyListeners();

 }

}