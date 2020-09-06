import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/models/nutrition_plan.dart';
import 'package:myfitnesstrainer/screens/common/navigation.dart';
import 'package:myfitnesstrainer/screens/common/nutrition_details.dart';

class NutritionCard extends StatelessWidget {
  NutritionCard(this._nutritionPlan);
  final NutritionPlan _nutritionPlan;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, left: 18),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(NavigationFromLeft(NutritionDetailsPage(_nutritionPlan)));
        },
        child: Center(
          child: Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.9), BlendMode.dstATop),
                    image: AssetImage('assets/meyve_tabagi.jpg'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_nutritionPlan.name.toUpperCase(),
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  //wordSpacing: 5,
                                  letterSpacing: 1.5)),
                        ),
                      ),
                      Flexible(flex: 2, child: SizedBox()),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        /*                 Text(

                        ),*/
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
