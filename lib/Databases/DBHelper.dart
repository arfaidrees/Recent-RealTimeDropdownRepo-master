import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_booking_shop/Models/Products.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'dart:async';

import '../Models/ShopModel.dart';
import '../Models/UserModel.dart';
class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    else{
      _db=await openDatabase(join(await getDatabasesPath(),'shop.db'));
    }
    _db = await initDatabase();
    return _db!;
  }


  Future<Database> initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'shop.db');
    var db = await openDatabase(path, version: 2, onCreate: _onCreate , onUpgrade: _onUpgrade,);
    return db;
  }
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE shop(id INTEGER PRIMARY KEY AUTOINCREMENT, shopName TEXT, city TEXT, shopAddress TEXT, ownerName TEXT, ownerCNIC TEXT, phoneNo TEXT, alternativePhoneNo TEXT)");
    await db.execute(
        "CREATE TABLE logins(userId TEXT PRIMARY KEY ,userPassword TEXT)"
    );
    await db.execute(
        "CREATE TABLE products(product_code TEXT, product_name TEXT, uom TEXT ,price TEXT)"
    );
    await db.execute(
        "CREATE TABLE owner(owner_name TEXT, owner_contact TEXT)"
    );
    await db.execute(
        "CREATE TABLE shops(id INTEGER PRIMARY KEY AUTOINCREMENT,shop_name TEXT)"
    );
    await db.execute(
        "INSERT INTO logins (userId,userPassword) VALUES ('admin@gmail.com','admin')"
    );

  }
  Future<bool>login(Users user) async{
    final Database db = await initDatabase();
    var results=await db.rawQuery("select * from logins where userId = '${user.userId}' AND userPassword = '${user.userPassword}'");
    if(results.isNotEmpty){
      return true;
    }
    else{
      return false;
    }
  }

  Future<Object> getrow() async {
    final Database db = await initDatabase();
    try {
      var results = await db.rawQuery("SELECT * FROM shops");
      if (results.isNotEmpty) {
        return results;
      } else {
        print("No rows found in the 'shops' table.");
        return false;
      }
    } catch (e) {
      print("Error retrieving product: $e");
      return false;
    }
  }
  Future<bool> enterproducts(Products product) async {
    final Database db = await initDatabase();
    try {
      await db.rawQuery("INSERT INTO products (product_code, product_name, uom,price) VALUES ('${product.product_code.toString()}','${product.product_name.toString()}','${product.uom.toString()}','${product.price.toString()}') ");
      return true;
    } catch (e) {
      print("Error inserting product: $e");
      return false;
    }
  }
  Future<bool> entershopdata(String nameshop) async {
    final Database db = await initDatabase();
    try {
      await db.rawInsert("INSERT INTO shops (shop_name) VALUES ('${nameshop}')");
      return true;
    } catch (e) {
      print("Error inserting product: $e");
      return false;
    }
  }
  Future<bool> enterownerdata(ShopModel shopModel) async {
    final Database db = await initDatabase();
    try {
      await db.rawQuery("INSERT INTO  owner(owner_name,owner_contact  VALUES ('${shopModel.owner_name.toString()}','${shopModel.owner_contact.toString()}'}') ");
      return true;
    } catch (e) {
      print("Error inserting product: $e");
      return false;
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // print('Database upgrade: from $oldVersion to $newVersion');
    // if (oldVersion < 2) {
    //   print('Adding columns: city and alternativePhoneNo');
    //   // Add the "city" column in version 2.
    //   await db.execute('ALTER TABLE shop ADD COLUMN city TEXT');
    //   // Add the "alternativePhoneNo" column in version 2.
    //   await db.execute('ALTER TABLE shop ADD COLUMN alternativePhoneNo TEXT');
    // }
    print("DROPING...................");
    await db.execute('DROP TABLE IF EXISTS shop');
    await db.execute('DROP TABLE IF EXISTS logins');
    await db.execute('DROP TABLE IF EXISTS products');
    await db.execute('DROP TABLE IF EXISTS shops');
    await db.execute('DROP TABLE IF EXISTS owner');


    // Recreate tables (similar to the _onCreate function)
    await _onCreate(db, newVersion);
  }

  Future<ShopModel?> getShopData(int shopId) async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient!.query(
      'shop',
      where: 'id = ?',
      whereArgs: [shopId],
    );

    if (maps.isNotEmpty) {
      return ShopModel.fromMap(maps.first);
    } else {
      return null;
    }
  }



// Define a function to perform a migration if necessary.

  // Create a shop
  Future<int> createShop(ShopModel shop) async {
    final dbClient = await db;
    return dbClient!.insert('shop', shop.toMap());
  }

  // Read all shops
  Future<List<ShopModel>> getShops() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient!.query('shops');
    return List.generate(maps.length, (index) {
      return ShopModel.fromMap(maps[index]);
    });
  }


  // Update a shop
  Future<int> updateShop(ShopModel shop) async {
    final dbClient = await db;
    return dbClient!.update('shop', shop.toMap(),
        where: 'id = ?', whereArgs: [shop.id]);
  }

  // Delete a shop
  Future<int> deleteShop(int id) async {
    final dbClient = await db;
    return dbClient!.delete('shop', where: 'id = ?', whereArgs:[id]);
    }
}