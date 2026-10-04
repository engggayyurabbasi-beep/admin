import 'package:flutter/material.dart';

/// K - Store POS / Billing module.
/// This module is intentionally self-contained and uses local in-memory state.
/// It is designed to be mounted from the Admin Panel's POS placeholder.
class PosModule extends StatefulWidget {
  const PosModule({super.key, required this.data});

  final dynamic data;

  @override
  State<PosModule> createState() => _PosModuleState();
}

class _PosModuleState extends State<PosModule> {
  int _tab = 0;
  final List<_PosProduct> _products = [
    _PosProduct('P001', 'Soha Hair Oil', 'Hair Care', 210, 120),
    _PosProduct('P002', 'Kirpilez Tablets', 'Herbal', 270, 80),
    _PosProduct('P003', 'Slim Trimz Powder', 'Wellness', 270, 60),
    _PosProduct('P004', 'Hanicyst Syrup', 'Herbal', 599, 45),
    _PosProduct('P005', 'Tahleel-E-Warm Syrup', 'Unani', 599, 55),
    _PosProduct('P006', 'Majoan Vajikaran Gold', 'Unani', 3200, 20),
  ];
  final List<_PosCartItem> _cart = [];
  final List<_PosSale> _sales = [];
  final List<_PosSale> _held = [];
  final List<_PosReturn> _returns = [];

  String _payment = 'Cash';
  String _search = '';
  String _customerName = 'Walk-in Customer';
  String _customerPhone = '';
  double _discount = 0;
  double _taxPercent = 0;
  double _cashReceived = 0;
  bool _cashRegisterOpen = true;
  double _openingCash = 5000;
  String _invoicePrefix = 'KS-POS';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Column(
          children: [
            _topBar(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, c) {
                  if (c.maxWidth < 900) return _mobileLayout();
                  return Row(
                    children: [
                      SizedBox(width: 210, child: _menu()),
                      Expanded(child: _page()),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topBar() {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              gradient: const LinearGradient(
                colors: [Color(0xFFE91E63), Color(0xFF7B1FA2)],
              ),
            ),
            child: const Icon(Icons.point_of_sale_rounded, color: Colors.white),
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('POS & Billing',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w800)),
                Text('Point of Sale • Billing • Cash Register',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 11)),
              ],
            ),
          ),
          _cashBadge(),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'New Sale',
            onPressed: _newSale,
            icon: const Icon(Icons.add_shopping_cart_rounded),
          ),
        ],
      ),
    );
  }

  Widget _cashBadge() {
    return InkWell(
      onTap: () => setState(() => _tab = 6),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
        decoration: BoxDecoration(
          color: _cashRegisterOpen
              ? const Color(0xFFE8F5E9)
              : const Color(0xFFFFEBEE),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.circle,
                size: 9,
                color: _cashRegisterOpen ? Colors.green : Colors.red),
            const SizedBox(width: 6),
            Text(_cashRegisterOpen ? 'Register Open' : 'Register Closed',
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  Widget _menu() {
    final items = [
      (Icons.point_of_sale_rounded, 'New Sale'),
      (Icons.receipt_long_rounded, 'Sales History'),
      (Icons.pause_circle_outline_rounded, 'Held Sales'),
      (Icons.keyboard_return_rounded, 'Returns / Refunds'),
      (Icons.people_alt_outlined, 'Customers'),
      (Icons.inventory_2_outlined, 'POS Products'),
      (Icons.account_balance_wallet_outlined, 'Cash Register'),
      (Icons.analytics_outlined, 'Reports'),
      (Icons.settings_outlined, 'POS Settings'),
    ];
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          for (int i = 0; i < items.length; i++)
            ListTile(
              dense: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11)),
              selected: _tab == i,
              selectedTileColor: const Color(0xFFFCE4EC),
              leading: Icon(items[i].$1,
                  size: 20,
                  color: _tab == i
                      ? const Color(0xFFC2185B)
                      : Colors.blueGrey),
              title: Text(items[i].$2,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          _tab == i ? FontWeight.w700 : FontWeight.w500)),
              onTap: () => setState(() => _tab = i),
            ),
        ],
      ),
    );
  }

  Widget _mobileLayout() {
    return Column(
      children: [
        SizedBox(
          height: 54,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            children: [
              for (final entry in [
                (0, 'Sale', Icons.point_of_sale),
                (1, 'History', Icons.receipt_long),
                (2, 'Held', Icons.pause_circle),
                (3, 'Returns', Icons.keyboard_return),
                (4, 'Customers', Icons.people),
                (5, 'Products', Icons.inventory_2),
                (6, 'Cash', Icons.account_balance_wallet),
                (7, 'Reports', Icons.analytics),
                (8, 'Settings', Icons.settings),
              ])
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: ChoiceChip(
                    selected: _tab == entry.$1,
                    label: Text(entry.$2),
                    avatar: Icon(entry.$3, size: 16),
                    onSelected: (_) => setState(() => _tab = entry.$1),
                  ),
                ),
            ],
          ),
        ),
        Expanded(child: _page()),
      ],
    );
  }

  Widget _page() {
    switch (_tab) {
      case 0:
        return _salePage();
      case 1:
        return _historyPage();
      case 2:
        return _heldPage();
      case 3:
        return _returnsPage();
      case 4:
        return _customersPage();
      case 5:
        return _productsPage();
      case 6:
        return _cashPage();
      case 7:
        return _reportsPage();
      default:
        return _settingsPage();
    }
  }

  Widget _salePage() {
    final available = _products.where((p) {
      final q = _search.toLowerCase().trim();
      return q.isEmpty ||
          p.name.toLowerCase().contains(q) ||
          p.sku.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q);
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _pageTitle('New Sale', 'Create a counter sale and collect payment'),
          const SizedBox(height: 14),
          if (!_cashRegisterOpen) _warning('Cash register is closed. Open it before starting a cash sale.'),
          _customerBar(),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, c) {
              if (c.maxWidth < 760) {
                return Column(
                  children: [
                    _productPicker(available),
                    const SizedBox(height: 12),
                    _cartCard(),
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _productPicker(available)),
                  const SizedBox(width: 12),
                  Expanded(child: _cartCard()),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _customerBar() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Wrap(
          spacing: 10,
          runSpacing: 9,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(Icons.person_outline, color: Color(0xFFC2185B)),
            SizedBox(
              width: 220,
              child: TextField(
                controller: TextEditingController(text: _customerName),
                decoration: const InputDecoration(
                  labelText: 'Customer',
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => _customerName = v,
              ),
            ),
            SizedBox(
              width: 180,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Mobile',
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                onChanged: (v) => _customerPhone = v,
              ),
            ),
            OutlinedButton.icon(
              onPressed: _selectCustomer,
              icon: const Icon(Icons.search),
              label: const Text('Select Customer'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productPicker(List<_PosProduct> products) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Products',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search product / SKU / category...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  tooltip: 'Barcode',
                  onPressed: _scanBarcode,
                  icon: const Icon(Icons.qr_code_scanner_rounded),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (v) => setState(() => _search = v),
            ),
            const SizedBox(height: 9),
            ...products.map(_productTile),
            if (products.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: Text('No matching products')),
              ),
          ],
        ),
      ),
    );
  }

  Widget _productTile(_PosProduct p) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 2),
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFF3E5F5),
        child: Text(p.name.substring(0, 1),
            style: const TextStyle(
                color: Color(0xFF7B1FA2), fontWeight: FontWeight.w800)),
      ),
      title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text('${p.sku} • Stock ${p.stock} • ${p.category}'),
      trailing: Text('₹${p.price.toStringAsFixed(0)}',
          style: const TextStyle(fontWeight: FontWeight.w800)),
      onTap: () => _addToCart(p),
    );
  }

  Widget _cartCard() {
    final subtotal = _subtotal;
    final discount = _discount.clamp(0, subtotal);
    final tax = (subtotal - discount) * _taxPercent / 100;
    final total = subtotal - discount + tax;
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text('Current Bill',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                ),
                Text('${_cart.length} item(s)',
                    style: const TextStyle(color: Colors.blueGrey)),
              ],
            ),
            const Divider(),
            if (_cart.isEmpty)
              const Padding(
                padding: EdgeInsets.all(30),
                child: Center(
                    child: Text('Cart is empty. Tap a product to add it.')),
              )
            else
              ..._cart.map(_cartTile),
            const Divider(),
            _amountRow('Subtotal', subtotal),
            _amountRow('Discount', -discount),
            _amountRow('Tax', tax),
            const Divider(),
            _amountRow('Grand Total', total, bold: true),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _cart.isEmpty ? null : _discountDialog,
                    icon: const Icon(Icons.discount_outlined),
                    label: const Text('Discount'),
                  ),
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _cart.isEmpty ? null : _taxDialog,
                    icon: const Icon(Icons.receipt_long_outlined),
                    label: const Text('Tax'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _payment,
              decoration: const InputDecoration(
                  labelText: 'Payment Method', border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(value: 'Cash', child: Text('Cash')),
                DropdownMenuItem(value: 'UPI', child: Text('UPI')),
                DropdownMenuItem(value: 'Card', child: Text('Card')),
                DropdownMenuItem(value: 'Credit', child: Text('Credit')),
              ],
              onChanged: (v) => setState(() => _payment = v ?? 'Cash'),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: _cart.isEmpty ? null : _holdSale,
                  icon: const Icon(Icons.pause),
                  label: const Text('Hold'),
                ),
                OutlinedButton.icon(
                  onPressed: _cart.isEmpty ? null : _clearCart,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Clear'),
                ),
                ElevatedButton.icon(
                  onPressed: _cart.isEmpty ? null : () => _checkout(total),
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Complete Sale'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartTile(_PosCartItem item) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(item.product.name,
          style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text('₹${item.product.price.toStringAsFixed(0)} each'),
      trailing: SizedBox(
        width: 145,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () => _changeQty(item, -1),
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Text('${item.qty}',
                style: const TextStyle(fontWeight: FontWeight.w800)),
            IconButton(
              onPressed: () => _changeQty(item, 1),
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
      ),
    );
  }

  Widget _amountRow(String title, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(title,
              style: TextStyle(fontWeight: bold ? FontWeight.w800 : FontWeight.w500))),
          Text('${value < 0 ? '-' : ''}₹${value.abs().toStringAsFixed(2)}',
              style: TextStyle(fontWeight: bold ? FontWeight.w900 : FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _historyPage() {
    return _simplePage(
      'Sales History',
      'Search, view, reprint and refund completed POS sales',
      _sales.isEmpty
          ? _empty('No POS sales yet', 'Completed counter sales will appear here.')
          : Column(children: _sales.reversed.map(_saleCard).toList()),
    );
  }

  Widget _saleCard(_PosSale s) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const CircleAvatar(
            backgroundColor: Color(0xFFFCE4EC),
            child: Icon(Icons.receipt_long, color: Color(0xFFC2185B))),
        title: Text(s.invoice,
            style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text('${s.customer} • ${s.payment} • ${s.date}'),
        trailing: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text('₹${s.total.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.w800)),
            IconButton(
              tooltip: 'Invoice',
              onPressed: () => _invoiceDialog(s),
              icon: const Icon(Icons.print_outlined),
            ),
          ],
        ),
      ),
    );
  }

  Widget _heldPage() {
    return _simplePage(
      'Held Sales',
      'Pause a bill and resume it later',
      _held.isEmpty
          ? _empty('No held sales', 'Bills placed on hold will appear here.')
          : Column(
              children: _held.map((h) {
                return Card(
                  elevation: 0,
                  child: ListTile(
                    leading: const Icon(Icons.pause_circle_outline),
                    title: Text(h.id,
                        style: const TextStyle(fontWeight: FontWeight.w800)),
                    subtitle: Text('${h.customer} • ${h.items.length} items'),
                    trailing: ElevatedButton(
                      onPressed: () => _resume(h),
                      child: const Text('Resume'),
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }

  Widget _returnsPage() {
    return _simplePage(
      'Returns & Refunds',
      'Process returned POS items and keep a return history',
      Column(
        children: [
          ElevatedButton.icon(
            onPressed: _newReturn,
            icon: const Icon(Icons.keyboard_return),
            label: const Text('New Return'),
          ),
          const SizedBox(height: 12),
          if (_returns.isEmpty)
            _empty('No returns yet', 'Processed returns will appear here.')
          else
            ..._returns.reversed.map((r) => Card(
                  elevation: 0,
                  child: ListTile(
                    leading: const Icon(Icons.assignment_return_outlined),
                    title: Text(r.id,
                        style: const TextStyle(fontWeight: FontWeight.w800)),
                    subtitle: Text('${r.customer} • ${r.reason}'),
                    trailing: Text('₹${r.amount.toStringAsFixed(2)}'),
                  ),
                )),
        ],
      ),
    );
  }

  Widget _customersPage() {
    return _simplePage(
      'POS Customers',
      'Select customers, keep contact details and view their purchase history',
      Column(
        children: [
          ElevatedButton.icon(
              onPressed: _addCustomer,
              icon: const Icon(Icons.person_add_alt_1),
              label: const Text('Add Customer')),
          const SizedBox(height: 12),
          _customerInfo('Walk-in Customer', 'No mobile', 'Counter customer'),
          _customerInfo('Rahul Sharma', '+91 98765 43210', '6 purchases'),
          _customerInfo('Neha Khan', '+91 99887 77665', '4 purchases'),
        ],
      ),
    );
  }

  Widget _customerInfo(String name, String phone, String info) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text('$phone • $info'),
        trailing: IconButton(
            onPressed: () => _toast('Customer selected'),
            icon: const Icon(Icons.chevron_right)),
      ),
    );
  }

  Widget _productsPage() {
    return _simplePage(
      'POS Products',
      'Products available at the counter with live local stock',
      Column(
        children: [
          for (final p in _products)
            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(Icons.inventory_2_outlined),
                title: Text(p.name,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                subtitle: Text('${p.sku} • ${p.category}'),
                trailing: Text('Stock ${p.stock}',
                    style: const TextStyle(fontWeight: FontWeight.w800)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _cashPage() {
    final cashSales = _sales
        .where((s) => s.payment == 'Cash')
        .fold<double>(0, (a, b) => a + b.total);
    return _simplePage(
      'Cash Register',
      'Open/close the till, record opening cash and reconcile sales',
      Column(
        children: [
          _summaryGrid([
            _metric('Opening Cash', _money(_openingCash), Icons.login),
            _metric('Cash Sales', _money(cashSales), Icons.payments),
            _metric('Expected Cash', _money(_openingCash + cashSales),
                Icons.account_balance_wallet),
          ]),
          const SizedBox(height: 14),
          Card(
            elevation: 0,
            child: ListTile(
              leading: Icon(_cashRegisterOpen ? Icons.lock_open : Icons.lock),
              title: Text(_cashRegisterOpen ? 'Register is OPEN' : 'Register is CLOSED',
                  style: const TextStyle(fontWeight: FontWeight.w800)),
              subtitle: const Text('Use closing to reconcile the cash drawer.'),
              trailing: ElevatedButton(
                onPressed: _cashRegisterOpen ? _closeRegister : _openRegister,
                child: Text(_cashRegisterOpen ? 'Close Register' : 'Open Register'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reportsPage() {
    final total = _sales.fold<double>(0, (a, b) => a + b.total);
    final cash = _sales.where((s) => s.payment == 'Cash').fold<double>(0, (a, b) => a + b.total);
    final upi = _sales.where((s) => s.payment == 'UPI').fold<double>(0, (a, b) => a + b.total);
    return _simplePage(
      'POS Reports',
      'Sales, payment and register analytics',
      Column(
        children: [
          _summaryGrid([
            _metric('Bills', '${_sales.length}', Icons.receipt_long),
            _metric('Sales', _money(total), Icons.trending_up),
            _metric('Cash', _money(cash), Icons.payments),
            _metric('UPI', _money(upi), Icons.qr_code),
          ]),
          const SizedBox(height: 14),
          _info('Export & Accounting',
              'Use sales history for invoice reprints, accounting exports and day-end reconciliation.'),
        ],
      ),
    );
  }

  Widget _settingsPage() {
    return _simplePage(
      'POS Settings',
      'Configure billing behaviour and counter preferences',
      Column(
        children: [
          _setting('Invoice Prefix', _invoicePrefix, () => _editPrefix()),
          _setting('Tax', 'Enable tax from the bill screen', () => _toast('Tax setting opened')),
          _setting('Barcode Scanner', 'Ready for barcode integration', () => _scanBarcode()),
          _setting('Customer Required', 'Optional for walk-in sales',
              () => _toast('Customer requirement setting opened')),
          _setting('Print Invoice', 'Print/share after completed sale',
              () => _toast('Invoice printing setting opened')),
        ],
      ),
    );
  }

  Widget _simplePage(String title, String subtitle, Widget child) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _pageTitle(title, subtitle),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _pageTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(color: Colors.blueGrey)),
      ],
    );
  }

  Widget _summaryGrid(List<Widget> children) {
    return GridView.count(
      crossAxisCount: MediaQuery.of(context).size.width > 900 ? 4 : 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.8,
      children: children,
    );
  }

  Widget _metric(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE7E8ED)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFFCE4EC),
            child: Icon(icon, color: const Color(0xFFC2185B), size: 19),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: Colors.blueGrey)),
                Text(value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _info(String title, String body) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: const Icon(Icons.info_outline, color: Color(0xFF7B1FA2)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text(body),
      ),
    );
  }

  Widget _setting(String title, String value, VoidCallback onTap) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: const Icon(Icons.tune_rounded),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(value),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget _warning(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(children: [
        const Icon(Icons.warning_amber_rounded, color: Color(0xFFEF6C00)),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ]),
    );
  }

  Widget _empty(String title, String subtitle) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.receipt_long_outlined,
                  size: 48, color: Colors.blueGrey),
              const SizedBox(height: 8),
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 3),
              Text(subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.blueGrey)),
            ],
          ),
        ),
      ),
    );
  }

  double get _subtotal =>
      _cart.fold<double>(0, (sum, item) => sum + item.product.price * item.qty);

  String _money(double value) => '₹${value.toStringAsFixed(2)}';

  void _addToCart(_PosProduct p) {
    if (p.stock <= 0) {
      _toast('Out of stock');
      return;
    }
    final existing = _cart.where((x) => x.product.sku == p.sku).firstOrNull;
    setState(() {
      if (existing == null) {
        _cart.add(_PosCartItem(p, 1));
      } else if (existing.qty < p.stock) {
        existing.qty++;
      }
    });
  }

  void _changeQty(_PosCartItem item, int delta) {
    setState(() {
      final next = item.qty + delta;
      if (next <= 0) {
        _cart.remove(item);
      } else if (next <= item.product.stock) {
        item.qty = next;
      }
    });
  }

  void _clearCart() {
    setState(() {
      _cart.clear();
      _discount = 0;
      _taxPercent = 0;
    });
  }

  void _newSale() {
    _clearCart();
    setState(() {
      _customerName = 'Walk-in Customer';
      _customerPhone = '';
      _payment = 'Cash';
      _tab = 0;
    });
  }

  void _holdSale() {
    final id = 'HOLD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    setState(() {
      _held.add(_PosSaleDraft(
        id,
        _customerName,
        _customerPhone,
        _payment,
        _cart.map((e) => _PosCartItem(e.product, e.qty)).toList(),
        _discount,
        _taxPercent,
      ));
      _clearCart();
    });
    _toast('Sale placed on hold');
  }

  void _resume(_PosSaleDraft h) {
    setState(() {
      _cart
        ..clear()
        ..addAll(h.items.map((e) => _PosCartItem(e.product, e.qty)));
      _customerName = h.customer;
      _customerPhone = h.phone;
      _payment = h.payment;
      _discount = h.discount;
      _taxPercent = h.tax;
      _held.remove(h);
      _tab = 0;
    });
  }

  void _checkout(double total) {
    if (_payment == 'Cash') {
      _cashReceived = total;
      _cashDialog(total);
      return;
    }
    _completeSale(total);
  }

  void _cashDialog(double total) {
    final controller = TextEditingController(text: total.toStringAsFixed(2));
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cash Payment'),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Cash received',
            prefixText: '₹ ',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final received = double.tryParse(controller.text) ?? 0;
              if (received < total) {
                _toast('Cash received is less than bill total');
                return;
              }
              _cashReceived = received;
              Navigator.pop(dialogContext);
              _completeSale(total);
            },
            child: const Text('Complete'),
          ),
        ],
      ),
    );
  }

  void _completeSale(double total) {
    final invoice = '$_invoicePrefix-${1000 + _sales.length + 1}';
    final sale = _PosSale(
      invoice,
      _customerName.trim().isEmpty ? 'Walk-in Customer' : _customerName.trim(),
      _payment,
      total,
      DateTime.now().toString().split('.').first,
      _cart.map((e) => _PosCartItem(e.product, e.qty)).toList(),
    );
    setState(() {
      for (final item in _cart) {
        item.product.stock -= item.qty;
      }
      _sales.add(sale);
      _cart.clear();
      _discount = 0;
      _taxPercent = 0;
      _cashReceived = 0;
    });
    _invoiceDialog(sale, completed: true);
  }

  void _invoiceDialog(_PosSale sale, {bool completed = false}) {
    final change = _cashReceived > sale.total ? _cashReceived - sale.total : 0;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(completed ? 'Sale Completed' : 'Invoice ${sale.invoice}'),
        content: SizedBox(
          width: 480,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('K - Store',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w900)),
                Text(sale.invoice),
                const Divider(),
                Text('Customer: ${sale.customer}'),
                Text('Payment: ${sale.payment}'),
                const SizedBox(height: 8),
                ...sale.items.map((i) => Row(
                      children: [
                        Expanded(child: Text('${i.product.name} × ${i.qty}')),
                        Text(_money(i.product.price * i.qty)),
                      ],
                    )),
                const Divider(),
                Text('Total: ${_money(sale.total)}',
                    style: const TextStyle(fontWeight: FontWeight.w900)),
                if (change > 0) Text('Change: ${_money(change)}'),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close')),
          OutlinedButton.icon(
            onPressed: () => _toast('Invoice print/share action ready'),
            icon: const Icon(Icons.print_outlined),
            label: const Text('Print / Share'),
          ),
        ],
      ),
    );
  }

  void _discountDialog() {
    final c = TextEditingController(text: _discount.toStringAsFixed(0));
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Apply Discount'),
        content: TextField(
          controller: c,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
              labelText: 'Discount amount', prefixText: '₹ '),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() => _discount = double.tryParse(c.text) ?? 0);
              Navigator.pop(context);
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _taxDialog() {
    final c = TextEditingController(text: _taxPercent.toStringAsFixed(0));
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Apply Tax'),
        content: TextField(
          controller: c,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Tax %'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() => _taxPercent = double.tryParse(c.text) ?? 0);
              Navigator.pop(context);
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _selectCustomer() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Walk-in Customer'),
              onTap: () {
                setState(() {
                  _customerName = 'Walk-in Customer';
                  _customerPhone = '';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Rahul Sharma'),
              subtitle: const Text('+91 98765 43210'),
              onTap: () {
                setState(() {
                  _customerName = 'Rahul Sharma';
                  _customerPhone = '+91 98765 43210';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Neha Khan'),
              subtitle: const Text('+91 99887 77665'),
              onTap: () {
                setState(() {
                  _customerName = 'Neha Khan';
                  _customerPhone = '+91 99887 77665';
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addCustomer() => _toast('Customer form opened');
  void _scanBarcode() => _toast('Barcode scanner integration point ready');

  void _newReturn() {
    final c = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('New Return'),
        content: TextField(
          controller: c,
          decoration: const InputDecoration(
              labelText: 'Invoice number', border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (c.text.trim().isEmpty) return;
              setState(() {
                _returns.add(_PosReturn(
                    'RET-${_returns.length + 1}',
                    _customerName,
                    'Return against ${c.text.trim()}',
                    0));
              });
              Navigator.pop(context);
              _toast('Return created');
            },
            child: const Text('Create Return'),
          ),
        ],
      ),
    );
  }

  void _openRegister() {
    setState(() {
      _cashRegisterOpen = true;
      _openingCash = 5000;
    });
    _toast('Cash register opened');
  }

  void _closeRegister() {
    final cashSales = _sales
        .where((s) => s.payment == 'Cash')
        .fold<double>(0, (a, b) => a + b.total);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Close Cash Register'),
        content: Text(
            'Expected cash: ${_money(_openingCash + cashSales)}\n\nConfirm day-end closing?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() => _cashRegisterOpen = false);
              Navigator.pop(context);
              _toast('Register closed');
            },
            child: const Text('Close Register'),
          ),
        ],
      ),
    );
  }

  void _editPrefix() {
    final c = TextEditingController(text: _invoicePrefix);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Invoice Prefix'),
        content: TextField(controller: c, decoration: const InputDecoration(labelText: 'Prefix')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() => _invoicePrefix = c.text.trim().isEmpty ? 'KS-POS' : c.text.trim());
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _toast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _PosProduct {
  _PosProduct(this.sku, this.name, this.category, this.price, this.stock);
  String sku;
  String name;
  String category;
  double price;
  int stock;
}

class _PosCartItem {
  _PosCartItem(this.product, this.qty);
  _PosProduct product;
  int qty;
}

class _PosSale {
  _PosSale(
      this.invoice, this.customer, this.payment, this.total, this.date, this.items);
  String invoice;
  String customer;
  String payment;
  double total;
  String date;
  List<_PosCartItem> items;
}

class _PosSaleDraft {
  _PosSaleDraft(this.id, this.customer, this.phone, this.payment, this.items,
      this.discount, this.tax);
  String id;
  String customer;
  String phone;
  String payment;
  List<_PosCartItem> items;
  double discount;
  double tax;
}

class _PosReturn {
  _PosReturn(this.id, this.customer, this.reason, this.amount);
  String id;
  String customer;
  String reason;
  double amount;
}
