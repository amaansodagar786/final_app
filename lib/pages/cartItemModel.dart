class CartItemModel {
  final String name;
  final String description;
  final String price;

  CartItemModel({
    required this.name,
    required this.description,
    required this.price, required key,
  });

  String? get key => null;
}
