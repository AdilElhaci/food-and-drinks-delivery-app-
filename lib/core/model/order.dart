class Order {
  String foodId;
  String foodImage;
  String id;
  String orderStatus;
  int ordered;
  int price;
  String userId;
  String returantName;

  Order({this.foodId, this.id, this.orderStatus, this.ordered, this.userId});

  Order.fromJson(Map<String, dynamic> json) {
    foodId = json['food_id'];

    orderStatus = json['order_status'];
    foodImage = json['order_image'];
    ordered = json['ordered'];
    price = json['price'];
    userId = json['user_id'];
    returantName = json['returant_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food_id'] = this.foodId;

    data['order_status'] = this.orderStatus;
    data['price'] = this.ordered;
    data['ordered'] = this.price;
    data['order_image'] = this.foodImage;
    data['user_id'] = this.userId;
    data['returant_name'] = this.returantName;
    return data;
  }
}
