import 'package:flutter/foundation.dart';
import 'package:medkart/model/excersise_details_model.dart';
import 'package:medkart/model/exercise_model.dart';

import '../data/network/baseapiservice.dart';
import '../data/network/networkapiservice.dart';
import '../res/app_url.dart';

class ExerciseRepository {
  BaseApiServices _apiServices = NetworkApiService();

  List<dynamic> list = [];
  Future<List<dynamic>> fetchExerciseList() async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse(AppUrl.baseUrl + AppUrl.exerciseEndPoint, header: {
        'X-RapidAPI-Key': '68173fb9c8mshe86be2ddacbd0c3p15855djsn042bcb396fec',
        'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
      });
      if (kDebugMode) {
        print(response);
      }
      list = response;
      return list;
        // response = ExerciseModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }
  Future<ExerciseDetailsModel> getExerciseDetails(String id) async {
    try{
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.exerciseDetailEndPoint+id,
          header: {
            'X-RapidAPI-Key': '68173fb9c8mshe86be2ddacbd0c3p15855djsn042bcb396fec',
            'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
          });
      if (kDebugMode) {
        print(response);
      }
      return response = ExerciseDetailsModel.fromJson(response);
    }catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }
}
