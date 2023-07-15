import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_model.dart';
import 'cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          " My Products",
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
          Consumer<CartProvider>(builder: (context,provider,child){
            return FutureBuilder(
                future: provider.getData(),
                builder: (context, AsyncSnapshot<List<Cart>> snapshot){
                  if(snapshot.hasData){
                    return  Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
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
                                                snapshot.data![index].image.toString()),
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
                                                  snapshot.data![index].productName.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 05,
                                                ),
                                                Text(
                                                  snapshot.data![index].unitTag.toString()+
                                                      " " +
                                                      r"$" +
                                                      snapshot.data![index].productPrice.toString(),
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
                            }));
                  }
                  return Text("no data is available");
                }

            );
          })
        ],
      ),
    );
  }
}
