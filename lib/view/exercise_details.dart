import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../viewmodel/home_viewmodel.dart';

class ExerciseDetailsScreen extends StatefulWidget {
  final String? id;
  const ExerciseDetailsScreen({super.key,this.id});

  @override
  State<ExerciseDetailsScreen> createState() => _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState extends State<ExerciseDetailsScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();

  @override
  void initState(){
    homeViewViewModel.fetchExerciseDetails(widget.id!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise Detail"),
      ),
      body: SafeArea(
        child: ChangeNotifierProvider<HomeViewViewModel>(
          create: (BuildContext context)=> homeViewViewModel,
          child: Consumer<HomeViewViewModel>(builder: (context,value,_){
            if (kDebugMode) {
              print(value);
            }
            switch (value.exerciseDetail.status!){
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Center(child: Text(value.exerciseDetail.message.toString()));
              case Status.COMPLETED:
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(value.exerciseDetail.data?.gifUrl??""),
                      const SizedBox(height: 16,),
                      Text("Exercise Name "+value.exerciseDetail.data!.name!),
                      const SizedBox(height: 16,),
                      Text("BodyPart "+value.exerciseDetail.data!.bodyPart!),
                      const SizedBox(height: 16,),
                      Text("Target "+value.exerciseDetail.data!.target!),
                      const SizedBox(height: 16,),
                      Text("Equipment "+value.exerciseDetail.data!.equipment!),
                    ],
                  ),
                );
            }
          }),
        ),
      ),
    );
  }
}
