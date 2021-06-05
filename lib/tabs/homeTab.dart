import 'dart:async';
import 'package:driverapp/components/rounded_button.dart';
import 'package:driverapp/helpers/pushNotificationService.dart';
import 'package:driverapp/widgets/confirmSheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
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

  var geoLocator=Geolocator();
  var locationOptions=LocationOptions(accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 4);

  String availabilityTitle='Go Online';
  Color availabilityColor=Colors.deepOrange;

  bool isAvailable=false;

  void getCurrentPosition()async{
    //Position position=await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    Position position =await Geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.bestForNavigation );
    currentPosition=position;
    LatLng pos=LatLng(position.latitude, position.longitude);
    mapController.animateCamera(CameraUpdate.newLatLng(pos));
  }

  void getCurrentDriverInfo ()  async{
    currentFirebaseUser=await FirebaseAuth.instance.currentUser;
    PushNotificationService pushNotificationService=PushNotificationService();
    pushNotificationService.initialize();
    pushNotificationService.getToken();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentDriverInfo();
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
                  buttonColor: availabilityColor,
                  textColor: Colors.white,
                  title: availabilityTitle,
                  buttonWidth: 160,

                  onPressed: (){
                   //
                    
                    showModalBottomSheet(context: context, builder: (BuildContext context)=>ConfirmSheet(
                        title: (!isAvailable)?'Go Online': 'Go Offline',
                      subtitle: (!isAvailable)?'You are about to become available to receive trip requests': 'You will stop receiving new requests',
                      onPressed: (){
                          if(!isAvailable){
                            goOnline();
                            getLocationUpdates();
                            Navigator.pop(context);
                            setState(() {
                              availabilityColor=Colors.red;
                              availabilityTitle='Go Offline';

                              isAvailable=true;
                            });
                          }
                          else{
                              goOffline();
                              Navigator.pop(context);

                              setState(() {
                                availabilityColor=Colors.deepOrange;
                                availabilityTitle='Go Online';

                                isAvailable=false;
                              });
                          }
                      },


                    ),);

                  },
                ),
              ],
            ),
          )
      ],
    );
  }


  void goOnline(){
    Geofire.initialize('driversAvailable');
    Geofire.setLocation(currentFirebaseUser.uid, currentPosition.latitude, currentPosition.longitude);

    tripReqRef=FirebaseDatabase.instance.reference().child('drivers/${currentFirebaseUser.uid}/newtrip');
    tripReqRef.set('waiting');
    tripReqRef.onValue.listen((event) {

    });
  }

  void goOffline(){
    Geofire.removeLocation(currentFirebaseUser.uid);
    tripReqRef.onDisconnect();
    tripReqRef.remove();
    tripReqRef=null;
  }

  void getLocationUpdates(){

    homeTabPositionStream=Geolocator.getPositionStream().listen((Position position) {
        currentPosition=position;

        if(isAvailable){
          Geofire.setLocation(currentFirebaseUser.uid, position.latitude, position.longitude);
        }


        LatLng pos=LatLng(position.latitude, position.longitude);
        mapController.animateCamera(CameraUpdate.newLatLng(pos));
    });
  }
}
