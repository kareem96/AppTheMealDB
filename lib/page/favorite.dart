


import 'package:app_the_meal_db/db/meal_entity.dart';
import 'package:app_the_meal_db/services/bloc/data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  DataBloc? dataBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    dataBloc = BlocProvider.of<DataBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    dataBloc!.close();
  }

  final ScrollController _controllerOne = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: dataBloc!.getAllMeal(),
        builder: (context, AsyncSnapshot<List<MealFavorites>> snapshot) {
          if (snapshot.hasData) {
            print('value of MyDATABASE : ${snapshot.data!.length}');
            return Scrollbar(
              isAlwaysShown: true,
              showTrackOnHover: true,
              thickness: 1.0,
              controller: _controllerOne,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                        "Favorite Meals",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                        controller: _controllerOne,
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          MealFavorites favorites = snapshot.data![index];

                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ExpansionTile(
                              backgroundColor: Colors.grey[300],
                              key: Key(favorites.title.toString()),
                              leading: IconButton(
                                icon: const Icon(
                                  Icons.star,
                                  size: 28,
                                ),
                                onPressed: () => dataBloc?.removeMeal(favorites),
                              ),
                              title: Text(
                                "${favorites.title}",
                                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
                              ),
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("${favorites.id}"),
                                    IconButton(
                                      onPressed: () => {
                                        dataBloc?.removeMeal(favorites),
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                                content: Text("Berhasil di hapus dari Favorite"),
                                                duration: Duration(seconds: 1),
                                            ))
                                      },
                                      icon: const Icon(Icons.delete),
                                      iconSize: 28,
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ))
                ],
              ),
            );
          }
          return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueGrey,
              ));
        });
  }
}