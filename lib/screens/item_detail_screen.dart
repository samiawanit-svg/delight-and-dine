import 'package:flutter/material.dart';
import '../models/menu_item_model.dart';
import '../theme/app_theme.dart';
import '../providers/cart_provider.dart';
import 'package:provider/provider.dart';

class ItemDetailScreen extends StatefulWidget {
  final MenuItem item;

  const ItemDetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  int _quantity = 1;
  late TextEditingController _specialRequestsController;

  @override
  void initState() {
    super.initState();
    _specialRequestsController = TextEditingController();
  }

  @override
  void dispose() {
    _specialRequestsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Item Details'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(AppTheme.radiusXL),
                bottomRight: Radius.circular(AppTheme.radiusXL),
              ),
              child: Image.network(
                widget.item.image,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.item.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall,
                            ),
                            const SizedBox(height: AppTheme.spacing8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.amber,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${widget.item.rating}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '(${widget.item.reviews} reviews)',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (widget.item.isVegetarian)
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(
                                AppTheme.radiusMedium),
                          ),
                          child: const Text(
                            'VEG',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacing16),
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacing12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                          AppTheme.radiusMedium),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          '\u20b9${widget.item.price}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing16),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppTheme.spacing8),
                  Text(
                    widget.item.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppTheme.spacing16),
                  if (widget.item.ingredients.isNotEmpty) ...,
                  [
                    Text(
                      'Ingredients',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppTheme.spacing8),
                    Wrap(
                      spacing: AppTheme.spacing8,
                      children: widget.item.ingredients
                          .map((ingredient) => Chip(
                                label: Text(ingredient),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: AppTheme.spacing16),
                  ],
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacing12),
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(
                          AppTheme.radiusMedium),
                      border: Border.all(color: AppTheme.dividerColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.schedule_outlined),
                        const SizedBox(width: AppTheme.spacing8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Preparation Time',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall,
                              ),
                              Text(
                                '${widget.item.preparationTime} minutes',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing16),
                  Text(
                    'Special Requests',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppTheme.spacing8),
                  TextField(
                    controller: _specialRequestsController,
                    decoration: InputDecoration(
                      hintText: 'E.g., No onions, Extra spicy',
                      prefixIcon: const Icon(Icons.notes_outlined),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: AppTheme.spacing20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.dividerColor),
                            borderRadius: BorderRadius.circular(
                                AppTheme.radiusMedium),
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  if (_quantity > 1) {
                                    setState(() => _quantity--);
                                  }
                                },
                              ),
                              Text(
                                _quantity.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium,
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() => _quantity++);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacing12),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () {
                            final cartProvider =
                                context.read<CartProvider>();
                            cartProvider.addItem(widget.item,
                                quantity: _quantity);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${widget.item.name} added to cart',
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          child: const Text('Add to Cart'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
