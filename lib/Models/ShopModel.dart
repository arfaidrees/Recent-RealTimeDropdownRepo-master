class ShopModel{

  int? id;
  String? shopName;
  String? city;
  String? shopAddress;
  String? owner_name;
  String? ownerCNIC;
  String? owner_contact;
  String? alternativePhoneNo;

  ShopModel({this.id,this.shopName,this.city,this.shopAddress,this.owner_name,this.ownerCNIC,this.owner_contact,this.alternativePhoneNo});

  factory ShopModel.fromMap(Map<dynamic,dynamic> json){
    return ShopModel(
        id: json['id'],
        shopName: json['shopName'],
        city: json['city'],
        shopAddress: json['shopAddress'],
        owner_name:json['owner_name'],
        ownerCNIC: json['ownerCNIC'],
        owner_contact: json['owner_contact'],
        alternativePhoneNo: json['alternativePhoneNo']
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'shopName':shopName,
      'city': city,
      'shopAddress':shopAddress,
      'owner_name':owner_name,
      'ownerCNIC':ownerCNIC,
      'owner_contact':owner_contact,
      'alternativePhoneNo': alternativePhoneNo
    };
  }
}

