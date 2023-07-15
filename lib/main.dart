import 'package:cart_app/cart_provider.dart';
import 'package:cart_app/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>CartProvider(),
    child:Builder(builder: (BuildContext context){
      return MaterialApp(
        title: 'CartApp',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ProductListScreen(),
        debugShowCheckedModeBanner: false,
      );
    }),

    );
  }
}

