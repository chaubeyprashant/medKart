

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medkart/utils/routes/routes_name.dart';
import 'package:medkart/view/exercise_details.dart';
import 'package:medkart/view/home_page.dart';

class Routes {

  static Route<dynamic>  generateRoute(RouteSettings settings){

    switch(settings.name){
      case RoutesName.exerciseDetails:
        return MaterialPageRoute(builder: (BuildContext context) => const ExerciseDetailsScreen());

      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const HomePage());

      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });

    }
  }
}