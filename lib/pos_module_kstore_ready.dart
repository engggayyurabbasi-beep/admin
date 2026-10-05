import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// K - Store POS / Billing module.
/// This module is intentionally self-contained and uses local in-memory state.
/// It is designed to be mounted from the Admin Panel's POS placeholder.
class PosModule extends StatefulWidget {
  const PosModule({
    super.key,
    required this.data,
    required this.onOrderCreated,
    required this.onCustomerCreated,
  });

  final dynamic data;
  final void Function(String customer, double amount, String payment)
      onOrderCreated;
  final void Function(String name, String mobile) onCustomerCreated;

  @override
  State<PosModule> createState() => _PosModuleState();
}

class _PosModuleState extends State<PosModule> {
  int _tab = 0;
  final List<_PosProduct> _products = [];
  final List<_PosCartItem> _cart = [];
  final List<_PosSale> _sales = [];
  final List<_PosSaleDraft> _held = [];
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
  String _customerAddress = '';
  String _customerCity = '';
  String _customerState = '';
  String _customerPincode = '';
  String _printerType = 'Thermal Printer';
  String _paperSize = '4 × 6 inch';
  String _printerName = 'System Printer';


  @override
  void initState() {
    super.initState();
    _syncProductsFromAdmin();
  }

  void _syncProductsFromAdmin() {
    try {
      final source = widget.data.products as Iterable;
      _products
        ..clear()
        ..addAll(
          source.map(
            (p) => _PosProduct(
              p.id.toString(),
              p.name.toString(),
              p.category.toString(),
              (p.price as num).toDouble(),
              (p.stock as num).toInt(),
            ),
          ),
        );
    } catch (_) {}
  }

  @override
  void didUpdateWidget(covariant PosModule oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.data, widget.data)) {
      _syncProductsFromAdmin();
    }
  }

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
            OutlinedButton.icon(
              onPressed: _addCustomer,
              icon: const Icon(Icons.person_add_alt_1),
              label: const Text('Add Customer'),
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
    final discount = _discount.clamp(0, subtotal).toDouble();
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
    final customers = <dynamic>[];

    try {
      final source = widget.data.customers as Iterable;
      customers.addAll(source);
    } catch (_) {}

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
          _customerInfo(
              'Walk-in Customer', 'No mobile', 'Counter customer'),
          for (final customer in customers)
            _customerInfo(
              customer.name.toString(),
              customer.mobile.toString().isNotEmpty
                  ? customer.mobile.toString()
                  : customer.email.toString(),
              'Customer',
            ),
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
              () => _printerSettingsDialog()),
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
    _syncProductsFromAdmin();
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
    final customer = _customerName.trim().isEmpty
        ? 'Walk-in Customer'
        : _customerName.trim();

    final sale = _PosSale(
      invoice,
      customer,
      _customerPhone.trim(),
      _customerAddress.trim(),
      _customerCity.trim(),
      _customerState.trim(),
      _customerPincode.trim(),
      _payment,
      total,
      DateTime.now().toString().split('.').first,
      _cart.map((e) => _PosCartItem(e.product, e.qty)).toList(),
    );

    setState(() {
      for (final item in _cart) {
        item.product.stock -= item.qty;

        try {
          final source = widget.data.products as Iterable;
          for (final adminProduct in source) {
            if (adminProduct.id.toString() == item.product.sku) {
              final current = (adminProduct.stock as num).toInt();
              final next = current - item.qty;
              adminProduct.stock = next < 0 ? 0 : next;
              break;
            }
          }
        } catch (_) {}
      }

      _sales.add(sale);

      _cart.clear();
      _discount = 0;
      _taxPercent = 0;
      _cashReceived = 0;
    });

    _syncProductsFromAdmin();
    widget.onOrderCreated(customer, total, _payment);
    _invoiceDialog(sale, completed: true);
  }

  void _invoiceDialog(_PosSale sale, {bool completed = false}) {
    final change = _cashReceived > sale.total ? _cashReceived - sale.total : 0.0;
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
            onPressed: () => _invoicePrintOptions(sale),
            icon: const Icon(Icons.print_outlined),
            label: const Text('Print / Share'),
          ),
        ],
      ),
    );
  }

  void _invoicePrintOptions(_PosSale sale) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.print_outlined),
              title: const Text('Print Invoice'),
              subtitle: Text('$_paperSize • $_printerType'),
              onTap: () {
                Navigator.pop(sheetContext);
                _printInvoice(sale);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share_outlined),
              title: const Text('Share Invoice PDF'),
              onTap: () {
                Navigator.pop(sheetContext);
                _shareInvoicePdf(sale);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Printer & Invoice Settings'),
              onTap: () {
                Navigator.pop(sheetContext);
                _printerSettingsDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  PdfPageFormat _selectedPageFormat() {
    switch (_paperSize) {
      case 'A4':
        return PdfPageFormat.a4;
      case 'A5':
        return PdfPageFormat.a5;
      case 'Thermal 58mm':
        return const PdfPageFormat(164, 600);
      case 'Thermal 80mm':
        return const PdfPageFormat(226, 600);
      default:
        return const PdfPageFormat(288, 432);
    }
  }

  Future<Uint8List> _invoicePdf(_PosSale sale) async {
    final doc = pw.Document();

    final address = [
      _customerAddress,
      _customerCity,
      _customerState,
      _customerPincode,
    ].where((e) => e.trim().isNotEmpty).join(', ');

    doc.addPage(
      pw.Page(
        pageFormat: _selectedPageFormat(),
        margin: const pw.EdgeInsets.all(16),
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'K - Store',
              style: pw.TextStyle(
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text('Invoice: ${sale.invoice}'),
            pw.Text('Date: ${sale.date}'),
            pw.SizedBox(height: 8),
            pw.Text('Customer: ${sale.customer}'),
            if (_customerPhone.isNotEmpty)
              pw.Text('Mobile: ${sale.phone}'),
            if (address.isNotEmpty)
              pw.Text('Address: ${sale.address}'),
            pw.SizedBox(height: 8),
            pw.Table.fromTextArray(
              headers: const ['Item', 'Qty', 'Amount'],
              data: [
                for (final item in sale.items)
                  [
                    item.product.name,
                    '${item.qty}',
                    '₹${(item.product.price * item.qty).toStringAsFixed(2)}',
                  ],
              ],
            ),
            pw.SizedBox(height: 8),
            pw.Divider(),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                'TOTAL: ₹${sale.total.toStringAsFixed(2)}',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Text('Payment: ${sale.payment}'),
            pw.SizedBox(height: 12),
            pw.Center(
              child: pw.Text('Thank you for shopping with K - Store'),
            ),
          ],
        ),
      ),
    );

    return doc.save();
  }

  Future<void> _printInvoice(_PosSale sale) async {
    try {
      final bytes = await _invoicePdf(sale);

      await Printing.layoutPdf(
        name: sale.invoice,
        onLayout: (_) async => bytes,
      );
    } catch (e) {
      _toast('Print failed: $e');
    }
  }

  Future<void> _shareInvoicePdf(_PosSale sale) async {
    try {
      final bytes = await _invoicePdf(sale);

      await Printing.sharePdf(
        bytes: bytes,
        filename: '${sale.invoice}.pdf',
      );
    } catch (e) {
      _toast('Share failed: $e');
    }
  }

  Future<void> _printTestPage() async {
    try {
      await Printing.layoutPdf(
        name: 'K-Store Printer Test',
        onLayout: (_) async {
          final doc = pw.Document();

          doc.addPage(
            pw.Page(
              pageFormat: _selectedPageFormat(),
              margin: const pw.EdgeInsets.all(16),
              build: (_) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'K - Store',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Text('PRINTER TEST PRINT'),
                  pw.Text('Type: $_printerType'),
                  pw.Text('Paper: $_paperSize'),
                  pw.Text('Printer: $_printerName'),
                  pw.SizedBox(height: 12),
                  pw.Text('Test successful.'),
                ],
              ),
            ),
          );

          return doc.save();
        },
      );
    } catch (e) {
      _toast('Test print failed: $e');
    }
  }

  void _printerSettingsDialog() {
    final printer = TextEditingController(text: _printerName);

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Printer & Invoice Settings'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _printerType,
                  decoration: const InputDecoration(
                    labelText: 'Printer Type',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Thermal Printer',
                      child: Text('Thermal Printer'),
                    ),
                    DropdownMenuItem(
                      value: 'Laser Printer',
                      child: Text('Laser Printer'),
                    ),
                    DropdownMenuItem(
                      value: 'Inkjet Printer',
                      child: Text('Inkjet Printer'),
                    ),
                  ],
                  onChanged: (v) {
                    setDialogState(
                      () => _printerType = v ?? _printerType,
                    );
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _paperSize,
                  decoration: const InputDecoration(
                    labelText: 'Invoice / Paper Size',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: '4 × 6 inch',
                      child: Text('4 × 6 inch'),
                    ),
                    DropdownMenuItem(
                      value: 'A4',
                      child: Text('A4'),
                    ),
                    DropdownMenuItem(
                      value: 'A5',
                      child: Text('A5'),
                    ),
                    DropdownMenuItem(
                      value: 'Thermal 58mm',
                      child: Text('Thermal 58mm'),
                    ),
                    DropdownMenuItem(
                      value: 'Thermal 80mm',
                      child: Text('Thermal 80mm'),
                    ),
                  ],
                  onChanged: (v) {
                    setDialogState(
                      () => _paperSize = v ?? _paperSize,
                    );
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: printer,
                  decoration: const InputDecoration(
                    labelText: 'Printer Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _printTestPage();
              },
              child: const Text('Test Print'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _printerName = printer.text.trim().isEmpty
                      ? 'System Printer'
                      : printer.text.trim();
                });

                Navigator.pop(dialogContext);
                _toast('Printer settings saved');
              },
              child: const Text('Save'),
            ),
          ],
        ),
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
    final customers = <dynamic>[];

    try {
      final source = widget.data.customers as Iterable;
      customers.addAll(source);
    } catch (_) {}

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
            for (final customer in customers)
              ListTile(
                title: Text(customer.name.toString()),
                subtitle: Text(
                  customer.mobile.toString().isNotEmpty
                      ? customer.mobile.toString()
                      : customer.email.toString(),
                ),
                onTap: () {
                  setState(() {
                    _customerName = customer.name.toString();
                    _customerPhone = customer.mobile.toString().isNotEmpty
                        ? customer.mobile.toString()
                        : customer.email.toString();
                  });
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _addCustomer() {
    final name = TextEditingController();
    final mobile = TextEditingController();
    final address = TextEditingController();
    final city = TextEditingController();
    final state = TextEditingController();
    final pincode = TextEditingController();

    showDialog(
      context: context,
      builder: (dialog) => AlertDialog(
        title: const Text('Add Customer'),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: name,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Customer Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: mobile,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: address,
                  decoration: const InputDecoration(
                    labelText: 'Address (Optional)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: city,
                        decoration: const InputDecoration(
                          labelText: 'City',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: state,
                        decoration: const InputDecoration(
                          labelText: 'State',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: pincode,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Pincode',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 6),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Address is optional. Bill can be completed without an address.',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialog),
            child: const Text('Cancel'),
          ),
          FilledButton.icon(
            icon: const Icon(Icons.save_rounded),
            label: const Text('Save Customer'),
            onPressed: () {
              final customerName = name.text.trim();
              final customerMobile = mobile.text.trim();

              if (customerName.isEmpty) {
                _toast('Customer name is required');
                return;
              }

              widget.onCustomerCreated(
                customerName,
                customerMobile,
              );

              setState(() {
                _customerName = customerName;
                _customerPhone = customerMobile;
                _customerAddress = address.text.trim();
                _customerCity = city.text.trim();
                _customerState = state.text.trim();
                _customerPincode = pincode.text.trim();
              });

              Navigator.pop(dialog);
              _toast('Customer added successfully');
            },
          ),
        ],
      ),
    );
  }

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
    this.invoice,
    this.customer,
    this.phone,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.payment,
    this.total,
    this.date,
    this.items,
  );

  String invoice;
  String customer;
  String phone;
  String address;
  String city;
  String state;
  String pincode;
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
