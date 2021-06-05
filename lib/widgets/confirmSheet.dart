import 'package:driverapp/components/rounded_button.dart';
import 'package:flutter/material.dart';

class ConfirmSheet extends StatelessWidget {

  final String title;
  final String subtitle;
  final Function onPressed;

  ConfirmSheet({
   this.onPressed,
   this.subtitle,
   this.title
});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15.0,
            spreadRadius: 0.5,
            offset: Offset(
              0.7,
              0.7,
            )
          )
        ]

      ),
      height: 220,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Column(
          children: [
            SizedBox(height: 10,),

            Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22
            ),),

            SizedBox(height: 10,),

            Text(subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 17,
                color: Colors.black26
              ),),

            SizedBox(height: 16,),


            Row(
              children: [

                Expanded(
                  child: Container(
                    child: RoundedButton(
                      title: 'Back',
                      textColor: Colors.black,
                      buttonColor: Colors.grey,
                      onPressed: (){
                       Navigator.pop(context);
                      },
                    ),
                  ),
                ),

                SizedBox(width: 16,),

                
                Expanded(
                  child: Container(
                    child: RoundedButton(
                      title: 'Confirm',
                      textColor: Colors.white,
                      buttonColor: (title=='Go Online')?Colors.green:Colors.red,
                      onPressed:onPressed
                    ),
                    
                  ),
                )
                

              ],
            )



          ],
        ),
      ),



    );
  }
}
