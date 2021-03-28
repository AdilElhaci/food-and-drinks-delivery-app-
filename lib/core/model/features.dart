class FoodFeatures {
  String id;
  int price;
  int number;

  int getNumber() => this.number;

  void setNumber(int num) {
    this.number = num;
  }

  int getPrice() => this.price;

  void setPrice(int price) {
    this.number = price;
  }

  void setId(String id) {
    this.id = id;
  }

  String getId() => this.id;
}
