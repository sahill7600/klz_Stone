class Gallery {
  final String? image;

  Gallery({this.image});

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(image: json['image']);
  }
}
