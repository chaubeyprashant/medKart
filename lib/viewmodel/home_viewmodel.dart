import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:medkart/model/exercise_model.dart';
import 'package:medkart/repository/exercise_repository.dart';

import '../data/response/api_response.dart';
import '../model/excersise_details_model.dart';

class HomeViewViewModel with ChangeNotifier {
  final _myRepo = ExerciseRepository();

  ApiResponse<List<dynamic>> exerciseList = ApiResponse.loading();
  ApiResponse<ExerciseDetailsModel> exerciseDetail = ApiResponse.loading();

  setExerciseList(ApiResponse<List<dynamic>> response) {
    exerciseList = response;
    notifyListeners();
  }
  setExerciseDetails(ApiResponse<ExerciseDetailsModel> response){
    exerciseDetail = response;
    if (kDebugMode) {
      print(exerciseDetail);
    }
    notifyListeners();
  }

  Future<void> fetchExerciseListApi() async {
    setExerciseList(ApiResponse.loading());

    _myRepo.fetchExerciseList().then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      setExerciseList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      setExerciseList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchExerciseDetails(String id) async {
    setExerciseDetails(ApiResponse.loading());

    _myRepo.getExerciseDetails(id).then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      setExerciseDetails(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      setExerciseDetails(ApiResponse.error(error.toString()));
    });
  }

}
