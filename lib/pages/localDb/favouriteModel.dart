class FavouriteModel {
  int? product_id;
  String? product_name;
  String? product_image;
  String? size;
  String? thickness;
  String? finish;
  int? category_id;
  String? category_name;

  FavouriteModel(
      {required this.product_id,
      required this.product_name,
      this.product_image,
      this.size,
      this.thickness,
      this.finish,
      this.category_id,
      this.category_name});

  Map<String, dynamic> toMap() {
    return {
      'product_id': product_id,
      'product_name': product_name,
      'product_image': product_image,
      'size': size,
      'thickness': thickness,
      'finish': finish,
      'category_id': category_id,
      'category_name': category_name
    };
  }
}
