class Order {
  String foodId;
  String foodImage;
  String id;
  String orderStatus;
  int ordered;
  String userId;

  Order({this.foodId, this.id, this.orderStatus, this.ordered, this.userId});

  Order.fromJson(Map<String, dynamic> json) {
    foodId = json['food_id'];
    id = json['id'];
    orderStatus = json['order_status'];
    orderStatus = json['order_image'];
    ordered = json['ordered'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food_id'] = this.foodId;
    data['id'] = this.id;
    data['order_status'] = this.orderStatus;
    data['ordered'] = this.ordered;
    data['order_image'] = this.foodImage;
    data['user_id'] = this.userId;
    return data;
  }
}
