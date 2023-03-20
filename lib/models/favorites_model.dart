class FavoritesModel {
  String? path;
  bool? isLiked;

  FavoritesModel({this.path, this.isLiked});

  toMap({FavoritesModel? favorites}) {
    return {
      'path': favorites?.path,
      'isLiked': favorites?.isLiked,
    };
  }

  factory FavoritesModel.fromMap(favorites) {
    return FavoritesModel(
        path: favorites['path'], isLiked: favorites['isLiked']);
  }
}
