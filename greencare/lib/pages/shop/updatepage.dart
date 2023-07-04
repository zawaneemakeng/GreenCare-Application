import 'package:flutter/material.dart';
import 'package:greencare/sqldb/sqlitedb.dart';

import '../../model/prodect.dart';

class UpdatePage extends StatefulWidget {
  final Product editProduct;
  const UpdatePage({super.key, required this.editProduct});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  var pdNameCtrlUpdate = TextEditingController();
  var pdPriceCtrlUpdate = TextEditingController();
  var pdQuantityCtrlUpdate = TextEditingController();
  Product editProduct = Product(status: false);
  SQLiteDatabase dbHelper = SQLiteDatabase();

  //ประกาศตัวเเปร
  late int selectID;
  late double editTotal;
  late bool editStatus;

  @override
  void initState() {
    super.initState();
    selectID = widget.editProduct.id!;
    pdNameCtrlUpdate =
        TextEditingController(text: widget.editProduct.name); //ดึงมาจากหย้าเเรก
    pdPriceCtrlUpdate =
        TextEditingController(text: widget.editProduct.price.toString());
    pdQuantityCtrlUpdate =
        TextEditingController(text: widget.editProduct.quantity.toString());
    editTotal = widget.editProduct.total!;
    editStatus = widget.editProduct.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [buildEditForm()]),
      ),
    );
  }

  Widget buildEditForm() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(labelText: 'ชื่อสินค้า'),
          controller: pdNameCtrlUpdate,
        ),
        TextField(
          decoration: InputDecoration(labelText: 'ราคาต่อหน่วย'),
          controller: pdPriceCtrlUpdate,
          keyboardType: TextInputType.number,
        ),
        TextField(
          decoration: InputDecoration(labelText: 'จำนวน'),
          controller: pdQuantityCtrlUpdate,
          keyboardType: TextInputType.number,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('มีสินค้าในสต๊อกหรือไม่'),
            Checkbox(
                value: editStatus,
                onChanged: (value) {
                  setState(() {
                    editStatus = value!;
                  });
                })
          ],
        ),
        ElevatedButton(
            onPressed: () {
              if (pdNameCtrlUpdate.text.isNotEmpty &&
                  pdPriceCtrlUpdate.text.isNotEmpty &&
                  pdQuantityCtrlUpdate.text.isNotEmpty) {
                setState(() {
                  editData(context);
                });
              }
              print(editStatus);
            },
            child: Text('บันทึก'))
      ],
    );
  }

  void editData(BuildContext context) {
    // context โยน เพื่อรีเฟรชค่าใหม่
    editProduct.name = pdNameCtrlUpdate.text;
    editProduct.price = double.parse(pdPriceCtrlUpdate.text);
    editProduct.quantity = int.parse(pdQuantityCtrlUpdate.text);
    editProduct.total = editProduct.quantity! * editProduct.price!;

    editProduct = Product(
        id: selectID, //id ที่เลือกมา
        name: editProduct.name,
        price: editProduct.price,
        quantity: editProduct.quantity,
        total: editProduct.total,
        status: editProduct.status);
    dbHelper.updateProduct(editProduct);
    Navigator.pop(context, true);
  }
}
