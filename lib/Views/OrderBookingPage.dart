import 'dart:convert';

import 'package:flutter/material.dart';

import '../Databases/DBHelper.dart';
import '../Models/ShopModel.dart';
import 'package:http/http.dart' as http;

class OrderBookingPage extends StatefulWidget {
 //final int shopId;

  OrderBookingPage();

  @override
  _OrderBookingPageState createState() => _OrderBookingPageState();
}

class _OrderBookingPageState extends State<OrderBookingPage> {
  TextEditingController _textField1Controller = TextEditingController();
  TextEditingController _textField2Controller = TextEditingController();
  TextEditingController _textField3Controller = TextEditingController();
  TextEditingController _textField4Controller = TextEditingController();

  String? selectedDropdownValue1;
  String? selectedDropdownValue2;
  String? selectedDropdownValue3;
  String? selectedDropdownValue4;
  String? selectedDropdownValue5;
  String? selectedDropdownValue6;

  TextEditingController _rate1Controller = TextEditingController();
  TextEditingController _amount1Controller = TextEditingController();
  TextEditingController _rate2Controller = TextEditingController();
  TextEditingController _amount2Controller = TextEditingController();
  TextEditingController _rate3Controller = TextEditingController();
  TextEditingController _amount3Controller = TextEditingController();
  TextEditingController _rate4Controller = TextEditingController();
  TextEditingController _amount4Controller = TextEditingController();
  TextEditingController _rate5Controller = TextEditingController();
  TextEditingController _amount5Controller = TextEditingController();
  TextEditingController _rate6Controller = TextEditingController();
  TextEditingController _amount6Controller = TextEditingController();

  ShopModel? shopData; // Store the retrieved shop data here

  // @override
  // void initState() {
  //   super.initState();
  //   // Retrieve the shop data when the page is initialized
  //   retrieveShopData();
  // }
  //
  // // Function to retrieve shop data
  // Future<void> retrieveShopData() async {
  //   DBHelper dbHelper = DBHelper();
  //   shopData = await dbHelper.getShopData(widget.shopId);
  //
  //   // Check if shopData is not null before updating the TextFormFields
  //   if (shopData != null) {
  //     // Update your TextFormFields with the retrieved shop data
  //     _textField1Controller.text = shopData!.shopName!;
  //     _textField2Controller.text = shopData!.ownerName!;
  //     _textField3Controller.text = shopData!.phoneNo!;
  //     //_textField4Controller.text = shopData.brand;
  //     // You can continue updating other form fields as needed
  //
  //     // Refresh the state to reflect the changes
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Booking'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'DATE',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 150, // Adjust the width
                    child: TextFormField(

                      decoration: InputDecoration(
                        labelText: 'Field 1',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      textAlign: TextAlign.right,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            buildTextFormField('Shop Name', 'Field 1', _textField1Controller),
            SizedBox(height: 20),
            buildTextFormField('Owner Name', 'Field 2', _textField2Controller),
            SizedBox(height: 20),
            buildTextFormField('Phone#', 'Field 3', _textField3Controller),
            SizedBox(height: 20),
            buildTextFormField('Brand', 'Field 4', _textField4Controller),
            SizedBox(height: 20),
            // First row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Item',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedDropdownValue1,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDropdownValue1 = newValue;
                            });
                          },
                          items: ['Option 1', 'Option 2', 'Option 3', 'Option 4']
                              .map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Qty',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rate',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _rate1Controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _amount1Controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Second row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedDropdownValue2,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDropdownValue2 = newValue;
                            });
                          },
                          items: ['Option A', 'Option B', 'Option C', 'Option D']
                              .map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 10),
                      TextFormField(

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 10),
                      TextFormField(

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Add Rate and Amount fields
              ],
            ),
            // Third row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedDropdownValue3,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDropdownValue3 = newValue;
                            });
                          },
                          items: ['Option X', 'Option Y', 'Option Z', 'Option W']
                              .map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                ),   SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 10),
                      TextFormField(

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 10),
                      TextFormField(

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Add Rate and Amount fields
              ],
            ),
            // Fourth row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedDropdownValue4,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDropdownValue4 = newValue;
                            });
                          },
                          items: ['Option P', 'Option Q', 'Option R', 'Option S']
                              .map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 10),
                      TextFormField(

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 10),
                      TextFormField(

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Add Rate and Amount fields
              ],
            ),

            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  // context,
                  //MaterialPageRoute(builder: (context) => tenthPage()),
                  //);
                },
                child: Text('Confirm'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFormField(
      String labelText,
      String hintText,
      TextEditingController controller,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ],
    );
  }
}
