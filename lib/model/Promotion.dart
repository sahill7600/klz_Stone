class Promotion {
  final int? promotion_id;
  final String? promotion_label;
  final String? price;
  final String? promotion_image;
  final String? category;

  Promotion(
      {this.promotion_id,
      this.promotion_label,
      this.price,
      this.promotion_image,
      this.category});

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
        promotion_id: json['promotion_id'],
        promotion_label: json['promotion_label'],
        price: json['price'],
        promotion_image: json['promotion_image'],
        category: json['category']);
  }
}
