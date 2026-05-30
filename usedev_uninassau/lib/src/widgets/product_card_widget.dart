import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCardWidget extends StatelessWidget {

  const ProductCardWidget({
    required this.nome,
    required this.url,
    required this.preco,
    required this.onAddCart,
    super.key,
  });

  final String nome;
  final String url;
  final String preco;

  final VoidCallback onAddCart;

  @override
  Widget build(BuildContext context) {

    return Card(

      margin: const EdgeInsets.all(20),

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20),
      ),

      elevation: 5,

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.stretch,

        children: [

          ClipRRect(

            borderRadius:
                const BorderRadius.vertical(
              top: Radius.circular(20),
            ),

            child: Image.network(

              url,

              height: 220,

              width: double.infinity,

              fit: BoxFit.cover,
            ),
          ),

          Padding(

            padding:
                const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),

            child: Text(

              nome,

              maxLines: 2,

              overflow:
                  TextOverflow.ellipsis,

              style: TextStyle(

                fontSize: 22,

                fontWeight:
                    FontWeight.bold,

                fontFamily:
                    GoogleFonts.orbitron()
                        .fontFamily,
              ),
            ),
          ),

          Padding(

            padding:
                const EdgeInsets.symmetric(
              horizontal: 15,
            ),

            child: Text(

              'R\$ $preco',

              style: TextStyle(

                fontSize: 28,

                fontWeight:
                    FontWeight.w600,

                fontFamily:
                    GoogleFonts.poppins()
                        .fontFamily,
              ),
            ),
          ),

          const SizedBox(height: 15),

          Padding(

            padding:
                const EdgeInsets.symmetric(
              horizontal: 15,
            ),

            child: SizedBox(

              height: 50,

              child: ElevatedButton.icon(

                onPressed: onAddCart,

                icon: const Icon(
                  Icons.shopping_cart,
                ),

                label: const Text(
                  'Adicionar ao Carrinho',
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}