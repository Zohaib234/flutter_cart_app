import 'package:cart_app/cart_model.dart';
import 'package:cart_app/cart_provider.dart';
import 'package:cart_app/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<String> productName = [
    'Mango',
    'Orange',
    'Grapes',
    'Banana',
    'Chery',
    'Peach',
    'Mixed Fruit Basket'
  ];
  List<String> productUnit = ['KG', 'Dozen', 'KG', 'Dozen', 'KG', 'KG', 'KG'];
  List<int> productPrice = [10, 20, 30, 40, 50, 60, 70];
  List<String> productImage = [
    'https://media.istockphoto.com/id/168370138/photo/mango.jpg?s=612x612&w=0&k=20&c=ENq2BrUV8dNH2rth_ZYBBtS9RWDwCbI25SfulxirmnQ=',
    'https://media.istockphoto.com/id/182463420/photo/tangerine-duo-with-leafs.jpg?s=612x612&w=0&k=20&c=d3JZRAqgqZ5RWyN4ryFteCnmFNbeD9e3TNJkS2IC0vU=',
    'https://media.istockphoto.com/id/489520104/photo/green-grape-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=9kg_3pMeBKYnHHjx2JECF61QwzxTikLaQ2w-6A5tOO0=',
    'https://media.istockphoto.com/id/509533014/photo/raw-organic-bunch-of-bananas.jpg?s=612x612&w=0&k=20&c=eZg53yOtUf-H2vXQovAyAP2FbhWIgfO0KLEX_nYoXxQ=',
    'https://static8.depositphotos.com/1333205/900/v/600/depositphotos_9003632-stock-illustration-cherry.jpg',
    'https://img.freepik.com/premium-photo/peach-isolated-white-background_88281-1751.jpg',
    'https://5.imimg.com/data5/KD/EB/MY-3657284/3kg-fruit-basket-500x500.png'
  ];

  DBHelper? dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Product List",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        actions:  [
          Center(
            child: Badge(
              label: Consumer<CartProvider>(builder: (context,provider,child){
                return Text(
                  provider.getCounter().toString(),
                  style: TextStyle(color: Colors.white),
                );
              },),
              child: Icon(Icons.local_grocery_store),
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: productName.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Image(
                                  height: 100,
                                  width: 100,
                                  image: NetworkImage(
                                      productImage[index].toString()),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productName[index].toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 05,
                                      ),
                                      Text(
                                        productUnit[index].toString() +
                                            " " +
                                            r"$" +
                                            productPrice[index].toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Consumer<CartProvider>(builder: (context,provider,child){
                                          return InkWell(
                                            onTap: (){
                                                   dbHelper!.insert(
                                                     Cart(
                                                         id: index,
                                                         productId: index.toString(),
                                                         productName: productName[index].toString(),
                                                         initialPrice: productPrice[index],
                                                         productPrice: productPrice[index],
                                                         quantity: 1,
                                                         unitTag: productUnit[index].toString(),
                                                         image: productImage[index].toString())
                                                   ).then((value){
                                                        print("product is added to cart");
                                                        provider.addCounter();
                                                        provider.addTotalPrice(double.parse(productPrice[index].toString()));
                                                   }).onError((error, stackTrace){
                                                       print(error.toString());
                                                   });
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                  BorderRadius.circular(5)),
                                              child: const Center(
                                                child: Text(
                                                  "Add to cart",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          );
                                        },)
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
