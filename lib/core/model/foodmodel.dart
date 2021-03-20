class FoodModel {
  String category;
  String content;
  String id;
  String imgUrl;
  String name;
  int price;
  String restaurantName;

  FoodModel(
      {this.category,
      this.content,
      this.id,
      this.imgUrl,
      this.name,
      this.price,
      this.restaurantName});

  FoodModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    content = json['content'];
    id = json['id'];
    imgUrl = json['img_url'];
    name = json['name'];
    price = json['price'];
    restaurantName = json['restaurant_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['content'] = this.content;
    data['id'] = this.id;
    data['img_url'] = this.imgUrl;
    data['name'] = this.name;
    data['price'] = this.price;
    data['restaurant_name'] = this.restaurantName;
    return data;
  }
}
