import 'package:cart_app/db_helper.dart';
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
  DBHelper dbHelper = DBHelper();
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
        actions: [
          Center(
            child: Badge(
              label: Consumer<CartProvider>(
                builder: (context, provider, child) {
                  return Text(
                    provider.getCounter().toString(),
                    style: TextStyle(color: Colors.white),
                  );
                },
              ),
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
          Consumer<CartProvider>(builder: (context, provider, child) {
            return FutureBuilder(
                future: provider.getData(),
                builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Image(
                                            height: 100,
                                            width: 100,
                                            image: NetworkImage(snapshot
                                                .data![index].image
                                                .toString()),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      snapshot.data![index]
                                                          .productName
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    InkWell(
                                                        onTap: () {
                                                          dbHelper.delete(
                                                              snapshot
                                                                  .data![index]
                                                                  .id!);
                                                          provider
                                                              .removeCounter();
                                                          provider.removeTotalPrice(
                                                              double.parse(snapshot
                                                                  .data![index]
                                                                  .productPrice
                                                                  .toString()));
                                                        },
                                                        child:
                                                            Icon(Icons.delete))
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 05,
                                                ),
                                                Text(
                                                  snapshot.data![index].unitTag
                                                          .toString() +
                                                      " " +
                                                      r"$" +
                                                      snapshot.data![index]
                                                          .productPrice
                                                          .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child:
                                                        Consumer<CartProvider>(
                                                      builder: (context,
                                                          provider, child) {
                                                        return InkWell(
                                                          onTap: () {},
                                                          child: Container(
                                                              height: 35,
                                                              width: 100,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .green,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    InkWell(
                                                                        onTap:
                                                                            () {
                                                                          int quantity = snapshot
                                                                              .data![index]
                                                                              .quantity!;
                                                                          int price = snapshot
                                                                              .data![index]
                                                                              .initialPrice!;
                                                                          quantity--;
                                                                          int?
                                                                              newprice =
                                                                              price * quantity;
                                                                          if (quantity >
                                                                              0) {
                                                                            dbHelper.Update(Cart(id: snapshot.data![index].id!, productId: snapshot.data![index].id!.toString(), productName: snapshot.data![index].productName!, initialPrice: snapshot.data![index].initialPrice!, productPrice: newprice, quantity: quantity, unitTag: snapshot.data![index].unitTag!, image: snapshot.data![index].image!)).then(
                                                                                (value) {
                                                                              newprice = 0;
                                                                              quantity = 0;
                                                                              provider.removeTotalPrice(double.parse(snapshot.data![index].initialPrice.toString()));
                                                                            }).onError((error,
                                                                                stackTrace) {
                                                                              print(error.toString());
                                                                            });
                                                                          }
                                                                        },
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              Colors.white,
                                                                        )),
                                                                    Text(
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .quantity
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                    InkWell(
                                                                        onTap:
                                                                            () {
                                                                          int quantity = snapshot
                                                                              .data![index]
                                                                              .quantity!;
                                                                          int price = snapshot
                                                                              .data![index]
                                                                              .initialPrice!;
                                                                          quantity++;
                                                                          int?
                                                                              newprice =
                                                                              price * quantity;
                                                                          dbHelper.Update(Cart(id: snapshot.data![index].id!, productId: snapshot.data![index].id!.toString(), productName: snapshot.data![index].productName!, initialPrice: snapshot.data![index].initialPrice!, productPrice: newprice, quantity: quantity, unitTag: snapshot.data![index].unitTag!, image: snapshot.data![index].image!)).then(
                                                                              (value) {
                                                                            newprice =
                                                                                0;
                                                                            quantity =
                                                                                0;
                                                                            provider.addTotalPrice(double.parse(snapshot.data![index].initialPrice.toString()));
                                                                          }).onError((error,
                                                                              stackTrace) {
                                                                            print(error.toString());
                                                                          });
                                                                        },
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .add,
                                                                          color:
                                                                              Colors.white,
                                                                        )),
                                                                  ],
                                                                ),
                                                              )),
                                                        );
                                                      },
                                                    ))
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
                });
          }),
          Consumer<CartProvider>(builder: (context, provider, child) {
            return Visibility(
              visible: provider.getTotalPrice().toStringAsFixed(2) == "0.00"
                  ? false
                  : true,
              child: Column(
                children: [
                  ReusableWidget(
                      title: 'Sub Total',
                      value: r'$' + provider.getTotalPrice().toStringAsFixed(2))
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
