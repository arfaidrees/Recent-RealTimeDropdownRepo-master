class Products{
  String? product_code, product_name, uom, price;

  Products({
    required this.product_code,
    required this.product_name,
    required this.uom,
    required this.price
  });


  factory
  Products.fromMap(Map<dynamic,dynamic>json){
    return Products(
        product_code: json['product_code'],
        product_name: json['product_name'],
        uom: json['uom'],
        price: json['price']
    );
  }
  Map<String,dynamic>toMap(){
    return{
      'product_code':product_code,
      'product_name':product_name,
      'uom':uom,
      'price':price
    };
  }

}