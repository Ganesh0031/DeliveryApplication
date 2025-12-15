class CategoriesListResponse {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  CategoriesListResponse({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  CategoriesListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];


    var p = json['price'];
    price = p is int ? p.toDouble() : p;

    description = json['description'];
    category = json['category'];
    image = json['image'];

    rating = json['rating'] != null
        ? Rating.fromJson(json['rating'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['category'] = category;
    data['image'] = image;

    if (rating != null) {
      data['rating'] = rating!.toJson();
    }

    return data;
  }
}class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {

    var r = json['rate'];
    rate = r is int ? r.toDouble() : r;

    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['rate'] = rate;
    data['count'] = count;
    return data;
  }
}

