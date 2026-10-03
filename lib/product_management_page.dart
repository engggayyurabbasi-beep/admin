import 'package:flutter/material.dart';
import 'add_product_page.dart';

/// Local Product model.
/// This is intentionally kept simple so it can later be connected to Firebase/API.
class AdminProduct {
  AdminProduct({
    required this.id,
    required this.name,
    required this.brand,
    required this.sku,
    required this.price,
    required this.mrp,
    required this.cost,
    required this.stock,
    required this.category,
    required this.subCategory,
    required this.stockStatus,
    required this.shortDescription,
    required this.description,
    this.imageUrl = '',
    this.active = true,
  });

  final String id;
  String name;
  String brand;
  String sku;
  double price;
  double mrp;
  double cost;
  int stock;
  String category;
  String subCategory;
  String stockStatus;
  String shortDescription;
  String description;
  String imageUrl;
  bool active;

  factory AdminProduct.fromMap(Map<String, dynamic> map) {
    double number(dynamic value) {
      if (value is num) return value.toDouble();
      return double.tryParse('$value') ?? 0;
    }

    int integer(dynamic value) {
      if (value is num) return value.toInt();
      return int.tryParse('$value') ?? 0;
    }

    return AdminProduct(
      id: '${map['id'] ?? DateTime.now().microsecondsSinceEpoch}',
      name: '${map['name'] ?? ''}',
      brand: '${map['brand'] ?? ''}',
      sku: '${map['sku'] ?? ''}',
      price: number(map['price']),
      mrp: number(map['mrp']),
      cost: number(map['cost']),
      stock: integer(map['stock']),
      category: '${map['category'] ?? ''}',
      subCategory: '${map['subCategory'] ?? ''}',
      stockStatus: '${map['stockStatus'] ?? 'In Stock'}',
      shortDescription: '${map['shortDescription'] ?? ''}',
      description: '${map['description'] ?? ''}',
      imageUrl: '${map['imageUrl'] ?? ''}',
      active: map['active'] is bool ? map['active'] as bool : true,
    );
  }
}

/// Temporary in-memory store.
/// Later this class can be replaced with Firebase/REST persistence without
/// changing the Product Management UI.
class ProductStore {
  ProductStore._();

  static final ProductStore instance = ProductStore._();

  final List<AdminProduct> products = <AdminProduct>[];

  void add(AdminProduct product) {
    products.add(product);
  }

  void update(AdminProduct product) {
    final index = products.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      products[index] = product;
    }
  }

  void delete(String id) {
    products.removeWhere((item) => item.id == id);
  }
}

class ProductManagementPage extends StatefulWidget {
  const ProductManagementPage({super.key});

  @override
  State<ProductManagementPage> createState() => _ProductManagementPageState();
}

class _ProductManagementPageState extends State<ProductManagementPage> {
  final TextEditingController _searchController = TextEditingController();
  String _statusFilter = 'All';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_refresh);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refresh)
      ..dispose();
    super.dispose();
  }

  void _refresh() => setState(() {});

  List<AdminProduct> get _filteredProducts {
    final query = _searchController.text.trim().toLowerCase();

    return ProductStore.instance.products.where((product) {
      final matchesQuery = query.isEmpty ||
          product.name.toLowerCase().contains(query) ||
          product.sku.toLowerCase().contains(query) ||
          product.category.toLowerCase().contains(query) ||
          product.brand.toLowerCase().contains(query);

      final matchesStatus =
          _statusFilter == 'All' || product.stockStatus == _statusFilter;

      return matchesQuery && matchesStatus;
    }).toList();
  }

  Future<void> _addProduct() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const AddProductPage()),
    );

    if (!mounted || result == null) return;

    final product = AdminProduct.fromMap(result);
    ProductStore.instance.add(product);
    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Product added to Product List.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _deleteProduct(AdminProduct product) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Delete "${product.name}" from the local Product List?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    ProductStore.instance.delete(product.id);
    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Product deleted.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _editProduct(AdminProduct product) async {
    final priceController =
        TextEditingController(text: product.price.toStringAsFixed(2));
    final stockController =
        TextEditingController(text: product.stock.toString());

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Quick Edit Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: priceController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Selling Price',
                prefixText: '₹ ',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: stockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Stock Quantity',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    final price = double.tryParse(priceController.text.trim());
    final stock = int.tryParse(stockController.text.trim());

    priceController.dispose();
    stockController.dispose();

    if (result != true || price == null || stock == null) return;

    product.price = price;
    product.stock = stock;
    product.stockStatus = _stockStatusFor(stock);
    ProductStore.instance.update(product);
    setState(() {});
  }

  String _stockStatusFor(int stock) {
    if (stock <= 0) return 'Out of Stock';
    if (stock <= 10) return 'Low Stock';
    return 'In Stock';
  }

  void _showDetails(AdminProduct product) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.inventory_2_outlined),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(sheetContext),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const Divider(height: 28),
                _detail('Brand', product.brand),
                _detail('SKU', product.sku),
                _detail('Category', product.category),
                _detail('Sub-category', product.subCategory),
                _detail('Selling Price', '₹${product.price.toStringAsFixed(2)}'),
                _detail('MRP', '₹${product.mrp.toStringAsFixed(2)}'),
                _detail('Cost', '₹${product.cost.toStringAsFixed(2)}'),
                _detail('Stock', '${product.stock}'),
                _detail('Stock Status', product.stockStatus),
                _detail('Short Description', product.shortDescription),
                if (product.description.isNotEmpty)
                  _detail('Description', product.description),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value.isEmpty ? '—' : value,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'In Stock':
        return const Color(0xFF16A05D);
      case 'Low Stock':
        return const Color(0xFFFF9800);
      case 'Out of Stock':
        return const Color(0xFFE53935);
      default:
        return const Color(0xFF607D8B);
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = _filteredProducts;
    final total = ProductStore.instance.products.length;
    final inStock = ProductStore.instance.products
        .where((product) => product.stockStatus == 'In Stock')
        .length;
    final lowStock = ProductStore.instance.products
        .where((product) => product.stockStatus == 'Low Stock')
        .length;
    final outOfStock = ProductStore.instance.products
        .where((product) => product.stockStatus == 'Out of Stock')
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: () => setState(() {}),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addProduct,
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => setState(() {}),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
          children: [
            _summaryCards(total, inStock, lowStock, outOfStock),
            const SizedBox(height: 14),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search product, SKU, brand or category',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: _searchController.clear,
                        icon: const Icon(Icons.clear),
                      ),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 42,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _filterChip('All'),
                  _filterChip('In Stock'),
                  _filterChip('Low Stock'),
                  _filterChip('Out of Stock'),
                  _filterChip('Coming Soon'),
                ],
              ),
            ),
            const SizedBox(height: 14),
            if (products.isEmpty)
              _emptyState()
            else
              ...products.map(_productCard),
          ],
        ),
      ),
    );
  }

  Widget _summaryCards(int total, int inStock, int lowStock, int outOfStock) {
    return Row(
      children: [
        Expanded(child: _summary('Products', '$total', Icons.inventory_2)),
        const SizedBox(width: 8),
        Expanded(child: _summary('In Stock', '$inStock', Icons.check_circle)),
        const SizedBox(width: 8),
        Expanded(child: _summary('Low', '$lowStock', Icons.warning_amber)),
        const SizedBox(width: 8),
        Expanded(child: _summary('Out', '$outOfStock', Icons.remove_circle)),
      ],
    );
  }

  Widget _summary(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          Icon(icon, size: 21),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String value) {
    final selected = _statusFilter == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(value),
        selected: selected,
        onSelected: (_) => setState(() => _statusFilter = value),
      ),
    );
  }

  Widget _productCard(AdminProduct product) {
    final statusColor = _statusColor(product.stockStatus);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.black12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showDetails(product),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F3F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: product.imageUrl.isEmpty
                    ? const Icon(Icons.image_outlined, size: 28)
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image_outlined),
                        ),
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name.isEmpty ? 'Unnamed Product' : product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    if (product.brand.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        product.brand,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                    const SizedBox(height: 5),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        Text(
                          '₹${product.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                        if (product.mrp > product.price)
                          Text(
                            '₹${product.mrp.toStringAsFixed(0)}',
                            style: const TextStyle(
                              color: Colors.black45,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12,
                            ),
                          ),
                        _statusBadge(product.stockStatus, statusColor),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'SKU: ${product.sku.isEmpty ? '—' : product.sku} • Stock: ${product.stock}',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    _editProduct(product);
                  } else if (value == 'delete') {
                    _deleteProduct(product);
                  } else if (value == 'details') {
                    _showDetails(product);
                  }
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: 'details',
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.visibility_outlined),
                      title: Text('View Details'),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'edit',
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.edit_outlined),
                      title: Text('Quick Edit'),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.delete_outline),
                      title: Text('Delete'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusBadge(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withAlpha(22),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 50, 24, 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          const Icon(Icons.inventory_2_outlined, size: 54, color: Colors.black38),
          const SizedBox(height: 12),
          const Text(
            'No products found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'Add your first product to start managing your catalogue.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: _addProduct,
            icon: const Icon(Icons.add),
            label: const Text('Add Product'),
          ),
        ],
      ),
    );
  }
}
