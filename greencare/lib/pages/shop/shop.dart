import 'package:flutter/material.dart';
import 'package:greencare/updatepage.dart';

import '../model/prodect.dart';
import '../sqldb/sqlitedb.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  var pdNameCtrl = TextEditingController();
  var pdPriceCtrl = TextEditingController();
  var pdQuantityCtrl = TextEditingController();

  Product product = Product(status: false);
  SQLiteDatabase dbHelper = SQLiteDatabase();
  List<Product> pdList = [];

  _refreshList() async {
    List<Product> lists = await dbHelper.readProduct();
    setState(() {
      pdList = lists;
    });
  }

  @override
  void initState() {
    super.initState();
    product.status = false;
    _refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [buildForm(), buildListView()]),
      ),
    );
  }

  Widget buildForm() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(labelText: 'ชื่อสินค้า'),
          controller: pdNameCtrl,
        ),
        TextField(
          decoration: InputDecoration(labelText: 'ราคาต่อหน่วย'),
          controller: pdPriceCtrl,
          keyboardType: TextInputType.number,
        ),
        TextField(
          decoration: InputDecoration(labelText: 'จำนวน'),
          controller: pdQuantityCtrl,
          keyboardType: TextInputType.number,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('มีสินค้าในสต๊อกหรือไม่'),
            Checkbox(
                value: product.status,
                onChanged: (value) {
                  setState(() {
                    product.status = value!;
                  });
                })
          ],
        ),
        ElevatedButton(
            onPressed: () {
              if (pdNameCtrl.text.isNotEmpty &&
                  pdPriceCtrl.text.isNotEmpty &&
                  pdQuantityCtrl.text.isNotEmpty) {
                saveData();
              }
            },
            child: Text('บันทึก'))
      ],
    );
  }

  Widget buildListView() {
    return Expanded(
      child: Card(
          child: Scrollbar(
              child: ListView.builder(
                  itemCount: pdList.isEmpty ? 0 : pdList.length,
                  itemBuilder: (context, index) {
                    int pdId = pdList[index].id!;
                    String pdName = pdList[index].name!;
                    int pdQuan = pdList[index].quantity!;
                    double pdPrice = pdList[index].price!;
                    double pdTotal = pdList[index].total!;
                    bool pdstatus = pdList[index].status;
                    return Column(
                      children: [
                        ListTile(
                          title: Text('$pdId  $pdName'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Quantity $pdQuan'),
                              Text('price $pdPrice'),
                              Text('total $pdTotal'),
                              Text('Stock ${pdstatus ? "มี" : "ไม่มี"}')
                            ],
                          ),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      //bool เช็คว่าค่าอัพเดตยัง
                                      bool updateed = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => UpdatePage(
                                                editProduct: pdList[index]),
                                          ));
                                      if (updateed == true) {
                                        _refreshList();
                                      }
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      dbHelper.deleteProduct(pdId);
                                      _refreshList();
                                    },
                                    icon: Icon(Icons.delete, color: Colors.red))
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }))),
    );
  }

  //Method save to database
  saveData() async {
    product.name = pdNameCtrl.text;
    product.price = double.parse(pdPriceCtrl.text);
    product.quantity = int.parse(pdQuantityCtrl.text);
    product.total = product.quantity! * product.price!;

    product = Product(
        name: product.name,
        price: product.price,
        quantity: product.quantity,
        total: product.total,
        status: product.status);

    //เรีนกใช้database object in class database
    await dbHelper.createProduct(product);
    setState(() {
      pdNameCtrl.text = '';
      pdPriceCtrl.text = '';
      pdQuantityCtrl.text = '';
      product.status = false;
    });
    await _refreshList();
  }
}
