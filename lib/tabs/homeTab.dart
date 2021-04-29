import 'dart:async';
import 'package:driverapp/components/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:driverapp/components/globalVariables.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  GoogleMapController mapController;
  Completer<GoogleMapController> _controller=Completer();

  Position currentPosition;

  void getCurrentPosition()async{
    Position position=await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition=position;
    LatLng pos=LatLng(position.latitude, position.longitude);
    mapController.animateCamera(CameraUpdate.newLatLng(pos));
  }




  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
          GoogleMap(
            padding: EdgeInsets.only(top: 145),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: googlePlex,
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
              mapController=controller;
              getCurrentPosition();
            },


          ),
          Container(
            height: 135,
            width: double.infinity,
            color: Colors.black,
          ),


          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedButton(
                  buttonColor: Colors.deepOrange,
                  textColor: Colors.white,
                  title: "Go Online",
                  buttonWidth: 160,

                  onPressed: (){

                  },
                ),
              ],
            ),
          )
      ],
    );
  }
}
