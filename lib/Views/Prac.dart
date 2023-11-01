import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import '../Databases/DBHelper.dart';
import '../Models/Products.dart';
import '../Models/ShopModel.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class User {
  var a, b, c, d;
  User(this.a, this.b, this.c, this.d);
}

class owner_data {
  var a, b;
  owner_data(this.a, this.b);
}

class _SignUpScreenState extends State<SignUpScreen> {
  var data;
  List<String> dropdownValues = [];

  @override
  void initState() {
    super.initState();

    // Call your data functions here in the initState
    getshopdata();
  }

  final db = DBHelper();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  getdata() async {
    var response = await http.get(Uri.parse(
        'https://g04d40198f41624-i0czh1rzrnvg0r4l.adb.me-dubai-1.oraclecloudapps.com/ords/courage/product/record'));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsondata = jsonResponse['items'];

      List<Products> users = [];
      int a = 0;
      if (response.statusCode == 200) {
        for (var i in jsondata) {
          a++;
          User user = User(
              i['product_code'].toString(), i['product_name'].toString(), i['uom'].toString(), i['price'].toString());
          Products us = Products(product_code: user.a, product_name: user.b, uom: user.c, price: user.d);
          users.add(us);
          var result = await db.enterproducts(Products(product_code: user.a,
              product_name: user.b,
              uom: user.c,
              price: user.d));
          if (result == true) {
            Fluttertoast.showToast(
                msg:"doneeeeeeeeeeeeeeeeeeeeee");
          } else {
            Fluttertoast.showToast(
                msg:"failllllllllllllllllllll");
          }
        }
      } else {
        Fluttertoast.showToast(msg: "FAIL", toastLength: Toast.LENGTH_LONG);
        data = "NOOOOOOOOOOOOO";
      }
    }
  }


  getshopdata() async {
    var response = await http.get(Uri.parse(
        'https://g04d40198f41624-i0czh1rzrnvg0r4l.adb.me-dubai-1.oraclecloudapps.com/ords/courage/AddAhop/record/'));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsondata = jsonResponse['items'];

      int a = 0;
      if (response.statusCode == 200) {
        for (var i in jsondata) {
          a++;
          String name = i['shop_name'].toString();
          var result = await db.entershopdata(name);
          if (result == true) {
            setState(() { // Trigger a rebuild of the widget tree
              dropdownValues.add(name);
              getshopdata();
            });
            Fluttertoast.showToast(
                msg:"doneshop");
          } else {
            Fluttertoast.showToast(
                msg:"failshop");
          }
        }
      } else {
        Fluttertoast.showToast(msg: "FAIL", toastLength: Toast.LENGTH_LONG);
        data = "NOOOOOOOOOOOOO";
      }
    }
  }
  getownerdata() async {
    var response = await http.get(Uri.parse(
        'https://g04d40198f41624-i0czh1rzrnvg0r4l.adb.me-dubai-1.oraclecloudapps.com/ords/courage/Shop/record/' ));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsondata = jsonResponse['items'];

      List<ShopModel> users = [];
      int a = 0;
      if (response.statusCode == 200) {
        for (var i in jsondata) {
          a++;
          owner_data user = owner_data(
              i['shopName'].toString(), i['phoneNo'].toString());
          ShopModel us = ShopModel(owner_name: user.a, owner_contact: user.b);
          users.add(us);
          var result = await db.enterownerdata(ShopModel(owner_name: user.a,
              owner_contact: user.b));
          if (result == true) {
            Fluttertoast.showToast(
                msg:"doneeeeeeeeeeeeeeeeeeeeee");
          } else {
            Fluttertoast.showToast(
                msg:"failllllllllllllllllllll");
          }
        }
      } else {
        Fluttertoast.showToast(msg: "FAIL", toastLength: Toast.LENGTH_LONG);
        data = "NOOOOOOOOOOOOO";
      }
    }
  }

  getrow() async{
    var productData = await db.getrow();
    if (productData != null) {
      setState(() { // Trigger a rebuild of the widget tree
        data = productData.toString();
      });
    } else {
      setState(() { // Trigger a rebuild of the widget tree
        data = "No product found.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Api'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              items: dropdownValues.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                //getshopdata();
                // getdata();
                 getrow();
                // Add your code for when an option is selected
              },
              hint: Text('Select a shop'),
            ),
            SizedBox(height: 20,),
            Container(
              height: 40,
              width: 400,
              child: ElevatedButton(
                onPressed: () {
                  getrow();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'product data from database',
                      style: TextStyle(fontSize: 18),
                    ),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
