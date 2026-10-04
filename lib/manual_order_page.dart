import 'package:flutter/material.dart';

/// Professional Manual Order screen for K - Store Admin.
///
/// This page intentionally uses only the public models already present in the
/// K - Store Admin system:
///   ProductAdmin
///   CustomerAdmin
///   OrderAdmin
///
/// It does not depend on private widgets from the main admin file, so it can
/// safely be imported as a separate Dart file.
///
/// The returned ManualOrderResult contains the OrderAdmin plus the extra
/// manual-order information. The current OrderAdmin model only stores:
/// id, customer, amount, status and payment. The extra fields are kept in the
/// result so they can be connected to the permanent order-detail model later.

class ManualOrderItem {
  ManualOrderItem({
    required this.product,
    required this.quantity,
    required this.unitPrice,
  });

  final ProductAdmin product;
  int quantity;
  double unitPrice;

  double get total => quantity * unitPrice;
}

class ManualOrderResult {
  ManualOrderResult({
    required this.order,
    required this.items,
    required this.customerName,
    required this.mobile,
    required this.email,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    required this.landmark,
    required this.orderSource,
    required this.paymentMethod,
    required this.shippingMethod,
    required this.shippingCharge,
    required this.discount,
    required this.coupon,
    required this.notes,
  });

  final OrderAdmin order;
  final List<ManualOrderItem> items;

  final String customerName;
  final String mobile;
  final String email;

  final String address;
  final String city;
  final String state;
  final String pincode;
  final String landmark;

  final String orderSource;
  final String paymentMethod;
  final String shippingMethod;

  final double shippingCharge;
  final double discount;
  final String coupon;
  final String notes;
}

class ManualOrderPage extends StatefulWidget {
  const ManualOrderPage({
    super.key,
    required this.products,
    required this.customers,
    required this.nextOrderNumber,
  });

  final List<ProductAdmin> products;
  final List<CustomerAdmin> customers;

  /// Returns the next order number, e.g. KIRZ000001.
  final String Function() nextOrderNumber;

  @override
  State<ManualOrderPage> createState() => _ManualOrderPageState();
}

class _ManualOrderPageState extends State<ManualOrderPage> {
  final _formKey = GlobalKey<FormState>();

  final _customerName = TextEditingController();
  final _mobile = TextEditingController();
  final _email = TextEditingController();
  final _address = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _pincode = TextEditingController();
  final _landmark = TextEditingController();
  final _coupon = TextEditingController();
  final _discount = TextEditingController(text: '0');
  final _shipping = TextEditingController(text: '0');
  final _notes = TextEditingController();

  final List<ManualOrderItem> _items = [];

  String _orderSource = 'Admin';
  String _paymentMethod = 'COD';
  String _paymentStatus = 'Pending';
  String _shippingMethod = 'Standard Delivery';

  String _productSearch = '';
  String _orderNumber = '';

  @override
  void initState() {
    super.initState();
    _orderNumber = widget.nextOrderNumber();
  }

  @override
  void dispose() {
    for (final c in [
      _customerName,
      _mobile,
      _email,
      _address,
      _city,
      _state,
      _pincode,
      _landmark,
      _coupon,
      _discount,
      _shipping,
      _notes,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  List<ProductAdmin> get _productResults {
    final q = _productSearch.trim().toLowerCase();
    if (q.isEmpty) return widget.products.take(8).toList();

    return widget.products
        .where(
          (p) =>
              '${p.id} ${p.name} ${p.category}'
                  .toLowerCase()
                  .contains(q),
        )
        .take(8)
        .toList();
  }

  double get _subtotal =>
      _items.fold<double>(0, (sum, item) => sum + item.total);

  double get _discountValue =>
      double.tryParse(_discount.text.trim()) ?? 0;

  double get _shippingValue =>
      double.tryParse(_shipping.text.trim()) ?? 0;

  double get _grandTotal =>
      (_subtotal - _discountValue).clamp(0, double.infinity) +
      _shippingValue;

  void _addProduct(ProductAdmin product) {
    final existing = _items.where((item) => item.product.id == product.id);
    if (existing.isNotEmpty) {
      setState(() => existing.first.quantity++);
    } else {
      setState(() {
        _items.add(
          ManualOrderItem(
            product: product,
            quantity: 1,
            unitPrice: product.price,
          ),
        );
      });
    }
    _productSearch = '';
  }

  void _removeItem(ManualOrderItem item) {
    setState(() => _items.remove(item));
  }

  void _changeQuantity(ManualOrderItem item, int value) {
    setState(() {
      item.quantity = (item.quantity + value).clamp(1, 999);
    });
  }

  void _selectCustomer(CustomerAdmin customer) {
    setState(() {
      _customerName.text = customer.name;
      _email.text = customer.email;
    });
  }

  Future<void> _pickCustomer() async {
    if (widget.customers.isEmpty) {
      _showMessage('No saved customers found. Enter customer details manually.');
      return;
    }

    final selected = await showModalBottomSheet<CustomerAdmin>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              const Text(
                'Select Customer',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              ...widget.customers.map(
                (customer) => Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person_outline_rounded),
                    ),
                    title: Text(
                      customer.name,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(customer.email),
                    trailing: customer.enabled
                        ? const Icon(Icons.check_circle_outline_rounded)
                        : const Icon(Icons.block_outlined),
                    enabled: customer.enabled,
                    onTap: customer.enabled
                        ? () => Navigator.pop(context, customer)
                        : null,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (selected != null) {
      _selectCustomer(selected);
    }
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _createOrder() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_items.isEmpty) {
      _showMessage('Please add at least one product.');
      return;
    }

    final payment =
        _paymentStatus == 'Paid' ? 'Paid' : _paymentMethod;

    final order = OrderAdmin(
      _orderNumber,
      _customerName.text.trim(),
      _grandTotal,
      'Pending',
      payment,
    );

    final result = ManualOrderResult(
      order: order,
      items: List<ManualOrderItem>.from(_items),
      customerName: _customerName.text.trim(),
      mobile: _mobile.text.trim(),
      email: _email.text.trim(),
      address: _address.text.trim(),
      city: _city.text.trim(),
      state: _state.text.trim(),
      pincode: _pincode.text.trim(),
      landmark: _landmark.text.trim(),
      orderSource: _orderSource,
      paymentMethod: _paymentMethod,
      shippingMethod: _shippingMethod,
      shippingCharge: _shippingValue,
      discount: _discountValue,
      coupon: _coupon.text.trim(),
      notes: _notes.text.trim(),
    );

    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F9),
      appBar: AppBar(
        title: const Text(
          'Create Manual Order',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(.10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _orderNumber,
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
          children: [
            _section(
              icon: Icons.receipt_long_rounded,
              title: 'Order Information',
              subtitle: 'Order number is generated automatically.',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _infoTile('Order Number', _orderNumber),
                  _dropdown(
                    label: 'Order Source',
                    value: _orderSource,
                    items: const [
                      'Admin',
                      'Website',
                      'WhatsApp',
                      'Phone',
                      'Other',
                    ],
                    onChanged: (v) => setState(() => _orderSource = v!),
                  ),
                ],
              ),
            ),
            _section(
              icon: Icons.person_rounded,
              title: 'Customer',
              subtitle: 'Choose an existing customer or enter a new one.',
              trailing: OutlinedButton.icon(
                onPressed: _pickCustomer,
                icon: const Icon(Icons.people_alt_outlined),
                label: const Text('Select Customer'),
              ),
              child: _formGrid([
                _field(
                  _customerName,
                  'Customer Name *',
                  icon: Icons.person_outline_rounded,
                  validator: _required,
                ),
                _field(
                  _mobile,
                  'Mobile Number *',
                  icon: Icons.phone_outlined,
                  keyboard: TextInputType.phone,
                  validator: _required,
                ),
                _field(
                  _email,
                  'Email',
                  icon: Icons.email_outlined,
                  keyboard: TextInputType.emailAddress,
                ),
              ]),
            ),
            _section(
              icon: Icons.shopping_bag_rounded,
              title: 'Products',
              subtitle: 'Search and add one or more products.',
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search_rounded),
                      hintText: 'Search product, SKU or category',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (v) => setState(() => _productSearch = v),
                  ),
                  if (_productSearch.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    ..._productResults.map(
                      (product) => ListTile(
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        leading: const CircleAvatar(
                          child: Icon(Icons.inventory_2_outlined),
                        ),
                        title: Text(
                          product.name,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          '${product.id} • ${product.category} • Stock ${product.stock}',
                        ),
                        trailing: Text(
                          '₹${product.price.toStringAsFixed(0)}',
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        onTap: () => _addProduct(product),
                      ),
                    ),
                  ],
                  if (_items.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        children: const [
                          Icon(Icons.add_shopping_cart_rounded, size: 38),
                          SizedBox(height: 8),
                          Text(
                            'No products added yet',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 4),
                          Text('Search above to add products.'),
                        ],
                      ),
                    )
                  else
                    ..._items.map(
                      (item) => Card(
                        margin: const EdgeInsets.only(top: 10),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                child: Icon(Icons.shopping_bag_outlined),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      '₹${item.unitPrice.toStringAsFixed(0)} × ${item.quantity}',
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () => _changeQuantity(item, -1),
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              Text(
                                '${item.quantity}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              IconButton(
                                onPressed: () => _changeQuantity(item, 1),
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                              IconButton(
                                onPressed: () => _removeItem(item),
                                icon: const Icon(Icons.delete_outline_rounded),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            _section(
              icon: Icons.location_on_rounded,
              title: 'Delivery Address',
              subtitle: 'Enter the complete shipping address.',
              child: _formGrid([
                _field(
                  _address,
                  'Full Address *',
                  icon: Icons.home_outlined,
                  maxLines: 2,
                  validator: _required,
                  fullWidth: true,
                ),
                _field(_landmark, 'Landmark', icon: Icons.place_outlined),
                _field(
                  _city,
                  'City *',
                  icon: Icons.location_city_outlined,
                  validator: _required,
                ),
                _field(
                  _state,
                  'State *',
                  icon: Icons.map_outlined,
                  validator: _required,
                ),
                _field(
                  _pincode,
                  'Pincode *',
                  icon: Icons.pin_drop_outlined,
                  keyboard: TextInputType.number,
                  validator: _required,
                ),
              ]),
            ),
            _section(
              icon: Icons.payments_rounded,
              title: 'Payment',
              subtitle: 'Select payment method and current payment status.',
              child: _formGrid([
                _dropdown(
                  label: 'Payment Method',
                  value: _paymentMethod,
                  items: const [
                    'COD',
                    'UPI',
                    'Razorpay',
                    'Cash',
                    'Bank Transfer',
                  ],
                  onChanged: (v) =>
                      setState(() => _paymentMethod = v!),
                ),
                _dropdown(
                  label: 'Payment Status',
                  value: _paymentStatus,
                  items: const ['Pending', 'Paid'],
                  onChanged: (v) =>
                      setState(() => _paymentStatus = v!),
                ),
              ]),
            ),
            _section(
              icon: Icons.local_shipping_rounded,
              title: 'Shipping & Charges',
              subtitle: 'Configure delivery method and order pricing.',
              child: _formGrid([
                _dropdown(
                  label: 'Shipping Method',
                  value: _shippingMethod,
                  items: const [
                    'Standard Delivery',
                    'Express Delivery',
                    'Self Pickup',
                  ],
                  onChanged: (v) =>
                      setState(() => _shippingMethod = v!),
                ),
                _field(
                  _shipping,
                  'Shipping Charge',
                  icon: Icons.local_shipping_outlined,
                  keyboard: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                _field(
                  _discount,
                  'Discount',
                  icon: Icons.discount_outlined,
                  keyboard: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                _field(
                  _coupon,
                  'Coupon Code',
                  icon: Icons.local_offer_outlined,
                ),
              ]),
            ),
            _section(
              icon: Icons.calculate_rounded,
              title: 'Order Summary',
              child: Column(
                children: [
                  _summaryRow('Subtotal', _subtotal),
                  _summaryRow('Discount', -_discountValue),
                  _summaryRow('Shipping', _shippingValue),
                  const Divider(height: 24),
                  _summaryRow(
                    'Grand Total',
                    _grandTotal,
                    bold: true,
                  ),
                ],
              ),
            ),
            _section(
              icon: Icons.notes_rounded,
              title: 'Internal Notes',
              subtitle: 'Notes visible to Admin/Staff only.',
              child: TextField(
                controller: _notes,
                maxLines: 4,
                decoration: _decoration('Order notes'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                ),
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: FilledButton.icon(
                onPressed: _createOrder,
                icon: const Icon(Icons.check_circle_outline_rounded),
                label: const Text(
                  'Create Order',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    required Widget child,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE8E4E7)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 19,
                  child: Icon(icon, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: Color(0xFF777277),
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
                if (trailing != null) trailing,
              ],
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }

  Widget _formGrid(List<Widget> children) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 680;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: children.map((child) {
            final full =
                child is _ManualFieldMarker && child.fullWidth;
            return SizedBox(
              width: full
                  ? constraints.maxWidth
                  : wide
                      ? (constraints.maxWidth - 12) / 2
                      : constraints.maxWidth,
              child: child,
            );
          }).toList(),
        );
      },
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    IconData? icon,
    TextInputType? keyboard,
    int maxLines = 1,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
    bool fullWidth = false,
  }) {
    return _ManualFieldMarker(
      fullWidth: fullWidth,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        maxLines: maxLines,
        validator: validator,
        onChanged: onChanged,
        decoration: _decoration(label, icon: icon),
      ),
    );
  }

  InputDecoration _decoration(String label, {IconData? icon}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: icon == null ? null : Icon(icon),
      filled: true,
      fillColor: const Color(0xFFFAFAFB),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: Color(0xFFE1DCE0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: Color(0xFFE1DCE0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 1.5,
        ),
      ),
    );
  }

  Widget _dropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return SizedBox(
      width: 320,
      child: DropdownButtonFormField<String>(
        value: value,
        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ),
            )
            .toList(),
        onChanged: onChanged,
        decoration: _decoration(label),
      ),
    );
  }

  Widget _summaryRow(
    String label,
    double value, {
    bool bold = false,
  }) {
    final negative = value < 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
          ),
          Text(
            '${negative ? '-' : ''}₹${value.abs().toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: bold ? 18 : 14,
              fontWeight: bold ? FontWeight.w900 : FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    return null;
  }
}

class _ManualFieldMarker extends StatelessWidget {
  const _ManualFieldMarker({
    required this.child,
    this.fullWidth = false,
  });

  final Widget child;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) => child;
}
