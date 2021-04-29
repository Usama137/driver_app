import 'package:connectivity/connectivity.dart';
import 'package:driverapp/components/constants.dart';
import 'package:driverapp/components/globalVariables.dart';
import 'package:driverapp/components/rounded_button.dart';
import 'package:driverapp/sizes_helpers.dart';
import 'package:driverapp/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class VehicleInfo extends StatefulWidget {
  static const String id = 'vehicleInfo_screen';
  @override
  _VehicleInfoState createState() => _VehicleInfoState();
}

class _VehicleInfoState extends State<VehicleInfo> {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String message) {
    final snackBar = SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ));
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var modelController = TextEditingController();

  var colorController = TextEditingController();

  var numberController = TextEditingController();





  void updateProfile(context){
    String id=currentFirebaseUser.uid;
    DatabaseReference driverRef=FirebaseDatabase.instance.reference().child('drivers/$id/vehicle_details');

    Map map={
      'car_model':modelController.text,
      'car_color':colorController.text,
      'car_number':numberController.text,
    };
    driverRef.set(map);
    Navigator.pushNamedAndRemoveUntil(context, Home.id, (route) => false);

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        //physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: displayHeight(context) * 0.15,
              ),
              Image(
                alignment: Alignment.center,
                height: 100,
                width: 100,
                image: AssetImage('images/OriginalonTransparentLogo.png'),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "SELECT TRANSPORTATION",
                style: TextStyle(
                    color: splashTextColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Enter vehicle details",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    //name
                    TextField(
                      controller: modelController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          labelText: 'Car model',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 10)),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    //email
                    TextField(
                      controller: colorController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Car color',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 10)),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    //phone
                    TextField(
                      controller: numberController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Vehicle number',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 10)),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    //password


                    RoundedButton(
                      buttonColor: splashTextColor,
                      textColor: Colors.white,
                      title: 'Proceed',
                      buttonWidth: displayWidth(context) * 0.80,
                      onPressed: () async {
                        var connectivityResult =
                        await Connectivity().checkConnectivity();
                        if (connectivityResult != ConnectivityResult.mobile &&
                            connectivityResult != ConnectivityResult.wifi) {
                          showSnackBar('No internet');
                          return;
                        }

                        if (modelController.text.length < 3) {
                          showSnackBar('Enter valid model');
                          return;
                        }
                        if (colorController.text.length < 3) {
                          showSnackBar('Enter valid color');
                          return;
                        }
                        if (numberController.text.length < 3) {
                          showSnackBar('Enter valid vehicle number');
                          return;
                        }


                        updateProfile(context);
                      },
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
