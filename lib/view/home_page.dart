import 'package:flutter/material.dart';
import 'package:medkart/view/exercise_details.dart';
import 'package:provider/provider.dart';
import '../data/response/status.dart';
import '../viewmodel/home_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();
  String searchQuery = "";
  String selectedBodyPart = "";
  String selectedTargetMuscle = "";
  String selectedEquipment = "";
  int loadedItemsCount = 0;
  int itemsPerPage = 0;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    homeViewViewModel.fetchExerciseListApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise List"),
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
        create: (BuildContext context) => homeViewViewModel,
        child: Consumer<HomeViewViewModel>(builder: (context, value, _) {
          final exerciseList = value.exerciseList.data ?? [];

          // Apply filters here to get the filteredExercises list
          // List<dynamic> filteredExercises = [...exerciseList];
          // if (selectedBodyPart.isNotEmpty) {
          //   filteredExercises = filteredExercises
          //       .where((exercise) =>
          //           exercise['bodyPart'].toString().toLowerCase() ==
          //           selectedBodyPart.toLowerCase())
          //       .toList();
          // }
          final filteredExercises = value.exerciseList.data?.where((exercise) {
            final exerciseName = exercise['name'].toString().toLowerCase();
            final exerciseBodyPart =
                exercise['bodyPart'].toString().toLowerCase();
            final exerciseTargetMuscle = exercise['target']
                .toString()
                .toLowerCase(); // Use exerciseTargetMuscle to store the target field
            final exerciseEquipment = exercise['equipment']
                .toString()
                .toLowerCase(); // Use exerciseEquipment to store the equipment field

            return exerciseName.contains(searchQuery.toLowerCase()) &&
                (selectedBodyPart.isEmpty ||
                    exerciseBodyPart == selectedBodyPart.toLowerCase()) &&
                (selectedTargetMuscle.isEmpty ||
                    exerciseTargetMuscle ==
                        selectedTargetMuscle.toLowerCase()) &&
                (selectedEquipment.isEmpty ||
                    exerciseEquipment == selectedEquipment.toLowerCase());
          }).toList();
          switch (value.exerciseList.status!) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(child: Text(value.exerciseList.message.toString()));
            case Status.COMPLETED:
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value; // Update the search query
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: "Search exercises...",
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedBodyPart,
                      onChanged: (newValue) {
                        setState(() {
                          selectedBodyPart = newValue!;
                        });
                      },
                      icon: null,
                      items: [
                        const DropdownMenuItem(
                            value: "", child: Text("All Body Parts")),
                        ...exerciseList
                            .map((exercise) => exercise['bodyPart'].toString())
                            .toSet()
                            .map((bodyPart) => DropdownMenuItem(
                                value: bodyPart, child: Text(bodyPart))),
                      ],
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedTargetMuscle,
                      onChanged: (newValue) {
                        setState(() {
                          selectedTargetMuscle = newValue!;
                        });
                      },
                      icon: null,
                      items: [
                        const DropdownMenuItem(
                            value: "", child: Text("Target")),
                        ...exerciseList
                            .map((exercise) => exercise['target'].toString())
                            .toSet()
                            .map((bodyPart) => DropdownMenuItem(
                                value: bodyPart, child: Text(bodyPart))),
                      ],
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedEquipment,
                      onChanged: (newValue) {
                        setState(() {
                          selectedEquipment = newValue!;
                        });
                      },
                      icon: null,
                      items: [
                        const DropdownMenuItem(
                            value: "", child: Text("Equipment")),
                        ...exerciseList
                            .map((exercise) => exercise['equipment'].toString())
                            .toSet()
                            .map((bodyPart) => DropdownMenuItem(
                                value: bodyPart, child: Text(bodyPart))),
                      ],
                    ),
                    Expanded(
                      child: ListView.separated(
                        controller: _scrollController,
                        itemCount: filteredExercises?.length??0 + 1,
                        itemBuilder: (context, index) {
                          if (index < filteredExercises!.length) {
                            // Display exercise item
                          } else {
                            if (filteredExercises.length <
                                exerciseList.length) {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            } else {
                              return const SizedBox(); // No more pages to load
                            }
                          }
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ExerciseDetailsScreen(
                                            id: value.exerciseList.data![index]
                                                ['id'],
                                          )));
                            },
                            child: ListTile(
                              leading: Image.network(
                                filteredExercises[index]['gifUrl'],
                                height: 100,
                                width: 100,
                              ),
                              title: Text(filteredExercises[index]['name']),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(filteredExercises[index]['bodyPart']),
                                  Text(filteredExercises[index]['target']),
                                  Text(filteredExercises[index]['equipment']),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 16,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
          }
        }),
      ),
    );
  }
}
