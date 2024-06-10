class ListModel {
  final int? id;
  final String? product_id;
  final String? item_name;
  final String? file_name;
  final String? web_name;
  final String? kind;
  final String? type;
  final String? category;
  final String? thickness;
  final String? uom;
  final String? hide_on_website;
  final String? orgin;
  final String? base_color;
  final String? price1;
  final String? price2;
  final String? price3;
  final String? inventory_page_link;

  ListModel(
      {this.id,
      this.product_id,
      this.item_name,
      this.file_name,
      this.web_name,
      this.kind,
      this.type,
      this.category,
      this.thickness,
      this.uom,
      this.hide_on_website,
      this.orgin,
      this.base_color,
      this.price1,
      this.price2,
      this.price3,
      this.inventory_page_link});

  factory ListModel.fromJson(Map<String, dynamic> json) {
    return ListModel(
        id: json['id'],
        product_id: json['product_id'],
        item_name: json['item_name'],
        file_name: json['file_name'],
        web_name: json['web_name'],
        kind: json['kind'],
        type: json['type'],
        category: json['category'],
        thickness: json['thickness'],
        uom: json['uom'],
        hide_on_website: json['hide_on_website'],
        orgin: json['orgin'],
        base_color: json['base_color'],
        price1: json['price1'],
        price2: json['price2'],
        price3: json['price3'],
        inventory_page_link: json['inventory_page_link']);
  }
}
