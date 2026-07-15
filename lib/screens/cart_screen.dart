import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/order_provider.dart';
import '../theme/app_theme.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text('Shopping Cart',
            style: Theme.of(context).textTheme.headlineSmall),
        elevation: 0,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          if (cartProvider.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 80,
                    color: AppTheme.textHint,
                  ),
                  const SizedBox(height: AppTheme.spacing16),
                  Text(
                    'Your cart is empty',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppTheme.spacing8),
                  Text(
                    'Add items to get started',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppTheme.spacing24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Continue Shopping'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(AppTheme.spacing16),
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartProvider.items[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: AppTheme.spacing12),
                      child: Padding(
                        padding: const EdgeInsets.all(AppTheme.spacing12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  AppTheme.radiusMedium),
                              child: Image.network(
                                cartItem.item.image,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: AppTheme.spacing12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItem.item.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium,
                                  ),
                                  const SizedBox(
                                      height: AppTheme.spacing4),
                                  Text(
                                    '₹${cartItem.item.price}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color:
                                              AppTheme.primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      iconSize: 20,
                                      onPressed: () {
                                        cartProvider.updateQuantity(
                                          cartItem.item.id,
                                          cartItem.quantity - 1,
                                        );
                                      },
                                    ),
                                    Text(
                                      cartItem.quantity.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      iconSize: 20,
                                      onPressed: () {
                                        cartProvider.updateQuantity(
                                          cartItem.item.id,
                                          cartItem.quantity + 1,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: AppTheme.errorColor,
                                  ),
                                  onPressed: () {
                                    cartProvider
                                        .removeItem(cartItem.item.id);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing16),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  border: Border(
                    top: BorderSide(
                      color: AppTheme.dividerColor,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    _buildPriceRow(
                      context,
                      'Subtotal',
                      '₹${cartProvider.subtotal.toStringAsFixed(2)}',
                    ),
                    const SizedBox(height: AppTheme.spacing8),
                    _buildPriceRow(
                      context,
                      'Tax (5%)',
                      '₹${cartProvider.tax.toStringAsFixed(2)}',
                    ),
                    const SizedBox(height: AppTheme.spacing8),
                    _buildPriceRow(
                      context,
                      'Delivery Fee',
                      '₹${cartProvider.deliveryFee.toStringAsFixed(2)}',
                    ),
                    const SizedBox(height: AppTheme.spacing12),
                    Divider(color: AppTheme.dividerColor),
                    const SizedBox(height: AppTheme.spacing12),
                    _buildPriceRow(
                      context,
                      'Total',
                      '₹${cartProvider.total.toStringAsFixed(2)}',
                      isBold: true,
                    ),
                    const SizedBox(height: AppTheme.spacing16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const CheckoutScreen(),
                            ),
                          );
                        },
                        child: const Text('Proceed to Checkout'),
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

  Widget _buildPriceRow(BuildContext context, String label, String price,
      {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isBold
              ? Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)
              : Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          price,
          style: isBold
              ? Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)
              : Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
