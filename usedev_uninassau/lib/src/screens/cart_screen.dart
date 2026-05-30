import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/cart_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(

          'Meu Carrinho',

          style: TextStyle(
            fontFamily:
                GoogleFonts.orbitron()
                    .fontFamily,
          ),
        ),
      ),

      body: ListenableBuilder(

        listenable:
            CartService.instance,

        builder: (context, child) {

          final cart =
              CartService.instance;

          final items =
              cart.items;

          if (items.isEmpty) {

            return const Center(

              child: Text(
                'Carrinho vazio',
              ),
            );
          }

          return Column(

            children: [

              Expanded(

                child: ListView.builder(

                  itemCount:
                      items.length,

                  itemBuilder:
                      (context, index) {

                    final item =
                        items[index];

                    return Card(

                      margin:
                          const EdgeInsets.all(
                              15),

                      child: Padding(

                        padding:
                            const EdgeInsets.all(
                                15),

                        child: Row(

                          children: [

                            Image.network(

                              item.product.image,

                              width: 80,

                              height: 80,

                              fit: BoxFit.cover,
                            ),

                            const SizedBox(
                                width: 15),

                            Expanded(

                              child: Column(

                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [

                                  Text(

                                    item.product.title,

                                    maxLines: 2,

                                    overflow:
                                        TextOverflow
                                            .ellipsis,

                                    style:
                                        const TextStyle(

                                      fontWeight:
                                          FontWeight
                                              .bold,

                                      fontSize: 18,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 10),

                                  Text(

                                    'R\$ ${item.product.price.toStringAsFixed(2)}',
                                  ),

                                  const SizedBox(
                                      height: 10),

                                  Row(

                                    children: [

                                      IconButton(

                                        onPressed: () {

                                          cart.decrementQuantity(
                                            item.product.id,
                                          );
                                        },

                                        icon:
                                            const Icon(
                                          Icons.remove,
                                        ),
                                      ),

                                      Text(
                                        item.quantity
                                            .toString(),
                                      ),

                                      IconButton(

                                        onPressed: () {

                                          cart.incrementQuantity(
                                            item.product.id,
                                          );
                                        },

                                        icon:
                                            const Icon(
                                          Icons.add,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            IconButton(

                              onPressed: () {

                                cart.removeFromCart(
                                  item.product.id,
                                );
                              },

                              icon: const Icon(
                                Icons.delete,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Container(

                padding:
                    const EdgeInsets.all(20),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .stretch,

                  children: [

                    Text(

                      'Total: R\$ ${cart.totalPrice.toStringAsFixed(2)}',

                      style: TextStyle(

                        fontSize: 24,

                        fontWeight:
                            FontWeight.bold,

                        fontFamily:
                            GoogleFonts.poppins()
                                .fontFamily,
                      ),
                    ),

                    const SizedBox(
                        height: 20),

                    ElevatedButton(

                      onPressed: () {

                        ScaffoldMessenger.of(
                                context)
                            .showSnackBar(

                          const SnackBar(

                            content: Text(
                              'Compra finalizada!',
                            ),
                          ),
                        );
                      },

                      child: const Text(
                        'Finalizar Compra',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}