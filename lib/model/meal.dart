

/*class Meal{
  final int? id;
  final double? popularity;
  final String? title;
  final String? homepage;
  final String? backPoster;
  final String? poster;
  final String? overview;
  final double? rating;


  Meal(this.id, this.popularity, this.rating, this.backPoster, this.poster, this.title, this.homepage, this.overview);

  Meal.fromJson(Map<String, dynamic> json) :
        id = json["id"],
        popularity = json["popularity"],
        title = json["title"],
        homepage = json["homepage"],
        backPoster = json["backdrop_path"],
        poster = json["poster_path"],
        overview = json["overview"],
        rating= json["vote_average"].toDouble();
}*/


class Meal{
  final int? ids;
  final String? id;
  final String? name;
  final String? desc;
  final String? homepage;
  final String? image;

  Meal(this.id, this.name, this.image, this.desc, this.homepage, this.ids);

  Meal.fromJson(Map<String, dynamic> json) :

        ids = json["ids"],
        id = json["idMeal"],
        name = json["strMeal"],
        homepage = json["homepage"],
        desc = json["strInstructions"],
        image = json["strMealThumb"];
}