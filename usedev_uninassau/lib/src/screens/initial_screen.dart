import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/product_model.dart';

import '../services/auth_service.dart';
import '../services/product_service.dart';
import '../services/cart_service.dart';

import '../widgets/hero_section_widget.dart';
import '../widgets/product_card_widget.dart';
import '../widgets/subscription_section_widget.dart';

import 'cart_screen.dart';
import 'login_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final ProductService productService = ProductService();

  late Future<List<ProductModel>> futureProducts;

  @override
  void initState() {
    super.initState();

    futureProducts = productService.getProducts();
  }

  Future<void> logout() async {
    await AuthService.instance.logout();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void addToCart(ProductModel product) {
    CartService.instance.addToCart(product);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} adicionado ao carrinho'),

        duration: const Duration(seconds: 2),
      ),
    );
  }

  void openCart() {
    Navigator.push(
      context,

      MaterialPageRoute(builder: (_) => const CartScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu, size: 40),

        title: Image.asset('assets/logo_usedev.png', height: 40),

        centerTitle: true,

        actions: [
          const Icon(Icons.person_outline, size: 40),

          const SizedBox(width: 10),

          IconButton(
            onPressed: openCart,

            icon: const Icon(Icons.shopping_cart_outlined, size: 40),
          ),

          const SizedBox(width: 10),

          IconButton(
            onPressed: logout,

            icon: const Icon(Icons.logout, size: 32),
          ),

          const SizedBox(width: 15),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            const SizedBox(height: 20),

            const HeroSectionWidget(),

            const SizedBox(height: 30),

            Text(
              'Promos Especiais',

              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: 28,

                fontWeight: FontWeight.bold,

                fontFamily: GoogleFonts.orbitron().fontFamily,
              ),
            ),

            const SizedBox(height: 20),

            FutureBuilder<List<ProductModel>>(
              future: futureProducts,

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),

                      child: Text('Erro ao carregar produtos'),
                    ),
                  );
                }

                final products = snapshot.data ?? [];

                return ListView.builder(
                  shrinkWrap: true,

                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: products.length,

                  itemBuilder: (context, index) {
                    final product = products[index];

                    return ProductCardWidget(
                      nome: product.title,

                      url: product.image,

                      preco: product.price.toStringAsFixed(2),

                      onAddCart: () => addToCart(product),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 30),

            const SubscriptionSectionWidget(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
