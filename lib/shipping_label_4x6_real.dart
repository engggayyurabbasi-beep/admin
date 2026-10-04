import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// K-Store 4 x 6 inch thermal shipping label.
///
/// Physical size: 4 x 6 inches, portrait.
/// PDF page size: 288 x 432 points (72 points per inch).
///
/// This widget is designed to work with the K-Store Admin app:
/// - Preview the exact 4x6 layout in the app.
/// - Generate a real 4x6 PDF.
/// - Print directly to a compatible thermal printer.
/// - Share/save the generated PDF through the platform print dialog.
/// - Supports Direct / Reseller / Vendor / Affiliate branding.
///
/// Add these dependencies to pubspec.yaml:
///   pdf: ^3.11.3
///   printing: ^5.14.2
///
/// Then run:
///   flutter pub get
class ShippingLabel4x6Data {
  ShippingLabel4x6Data({
    required this.orderId,
    required this.orderDate,
    required this.awb,
    required this.courier,
    required this.customerName,
    required this.address,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.phone,
    required this.payment,
    required this.weight,
    required this.items,
    required this.brand,
    this.website = '',
    this.gst = '',
    this.returnAddress = '',
    this.codAmount = 0,
    this.shippingCharge = 0,
    this.destination = '',
  });

  final String orderId;
  final String orderDate;
  final String awb;
  final String courier;

  final String customerName;
  final String address;
  final String city;
  final String state;
  final String pinCode;
  final String phone;

  final String payment;
  final String weight;

  final List<ShippingLabelItem> items;

  final ShippingLabelBranding brand;
  final String website;
  final String gst;
  final String returnAddress;

  final double codAmount;
  final double shippingCharge;
  final String destination;

  double get subtotal =>
      items.fold<double>(0, (sum, item) => sum + item.total);

  double get grandTotal => subtotal + shippingCharge;

  String get fullAddress =>
      '$address, $city, $state - $pinCode';
}

class ShippingLabelItem {
  ShippingLabelItem({
    required this.name,
    required this.qty,
    required this.price,
  });

  final String name;
  final int qty;
  final double price;

  double get total => qty * price;
}

class ShippingLabelBranding {
  ShippingLabelBranding({
    required this.businessName,
    required this.tagline,
    required this.address,
    required this.phone,
    required this.website,
    this.logoText = 'K',
    this.returnAddress = '',
    this.gst = '',
  });

  final String businessName;
  final String tagline;
  final String address;
  final String phone;
  final String website;
  final String logoText;
  final String returnAddress;
  final String gst;
}

/// Full-screen label preview with a Print button.
class ShippingLabel4x6Page extends StatelessWidget {
  const ShippingLabel4x6Page({
    super.key,
    required this.data,
  });

  final ShippingLabel4x6Data data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      appBar: AppBar(
        title: const Text('4 × 6 Shipping Label'),
        actions: [
          IconButton(
            tooltip: 'Print / Save PDF',
            icon: const Icon(Icons.print),
            onPressed: () async {
              await ShippingLabel4x6.printLabel(data);
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: AspectRatio(
              aspectRatio: 4 / 6,
              child: ShippingLabel4x6Preview(data: data),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: FilledButton.icon(
          onPressed: () => ShippingLabel4x6.printLabel(data),
          icon: const Icon(Icons.print),
          label: const Text('Print / Save 4 × 6 PDF'),
        ),
      ),
    );
  }
}

/// On-screen representation of the same label structure.
class ShippingLabel4x6Preview extends StatelessWidget {
  const ShippingLabel4x6Preview({
    super.key,
    required this.data,
  });

  final ShippingLabel4x6Data data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.white,
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.2),
        ),
        child: Column(
          children: [
            _PreviewHeader(data: data),
            _PreviewShipTo(data: data),
            _PreviewAwb(data: data),
            _PreviewOrderInfo(data: data),
            Expanded(
              child: _PreviewProducts(
                data: data,
                textTheme: textTheme,
              ),
            ),
            _PreviewBottom(data: data),
          ],
        ),
      ),
    );
  }
}

class _PreviewHeader extends StatelessWidget {
  const _PreviewHeader({required this.data});

  final ShippingLabel4x6Data data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      gradient: const LinearGradient(
                        colors: [Color(0xffd80078), Color(0xffff7a00)],
                      ),
                    ),
                    child: Text(
                      data.brand.logoText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 29,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      data.brand.businessName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(width: 1, color: Colors.black),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: _SmallTextBlock(
                title: 'From (Sold By)',
                lines: [
                  data.brand.businessName,
                  data.brand.address,
                  'Phone: ${data.brand.phone}',
                  if (data.website.isNotEmpty) data.website,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewShipTo extends StatelessWidget {
  const _PreviewShipTo({required this.data});

  final ShippingLabel4x6Data data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(9, 5, 9, 6),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(),
          bottom: BorderSide(),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
            color: Colors.black,
            child: const Text(
              'SHIP TO',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data.customerName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          Text(
            data.fullAddress,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 10.5, height: 1.15),
          ),
          Text(
            'Phone: ${data.phone}',
            style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _PreviewAwb extends StatelessWidget {
  const _PreviewAwb({required this.data});

  final ShippingLabel4x6Data data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 132,
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AWB No:',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      data.awb,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(child: CustomPaint(painter: _BarcodePainter(data.awb))),
                  const SizedBox(height: 2),
                  Center(
                    child: Text(
                      data.awb,
                      style: const TextStyle(fontSize: 8),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(width: 1, color: Colors.black),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Courier Partner:',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.courier,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  _PseudoQr(value: data.awb),
                  const SizedBox(height: 2),
                  const Center(
                    child: Text(
                      'Scan for Tracking',
                      style: TextStyle(fontSize: 7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewOrderInfo extends StatelessWidget {
  const _PreviewOrderInfo({required this.data});

  final ShippingLabel4x6Data data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(),
          bottom: BorderSide(),
        ),
      ),
      child: Row(
        children: [
          _InfoCell('Order No:', data.orderId),
          _InfoCell('Order Date:', data.orderDate),
          _InfoCell('Payment:', data.payment),
          _InfoCell('PIN:', data.pinCode),
          _InfoCell('Weight:', data.weight),
        ],
      ),
    );
  }
}

class _InfoCell extends StatelessWidget {
  const _InfoCell(this.title, this.value);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        decoration: const BoxDecoration(
          border: Border(right: BorderSide()),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 7.5)),
            const SizedBox(height: 2),
            Expanded(
              child: Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewProducts extends StatelessWidget {
  const _PreviewProducts({
    required this.data,
    required this.textTheme,
  });

  final ShippingLabel4x6Data data;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(flex: 1, child: _TableHeader('#')),
              Expanded(flex: 5, child: _TableHeader('Product Name')),
              Expanded(flex: 1, child: _TableHeader('Qty')),
              Expanded(flex: 2, child: _TableHeader('Price')),
              Expanded(flex: 2, child: _TableHeader('Total')),
            ],
          ),
          ...List.generate(
            data.items.length,
            (index) {
              final item = data.items[index];
              return Row(
                children: [
                  Expanded(flex: 1, child: _TableCell('${index + 1}')),
                  Expanded(flex: 5, child: _TableCell(item.name)),
                  Expanded(flex: 1, child: _TableCell('${item.qty}')),
                  Expanded(flex: 2, child: _TableCell(_money(item.price))),
                  Expanded(flex: 2, child: _TableCell(_money(item.total))),
                ],
              );
            },
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Total Items: ${data.items.fold<int>(0, (s, e) => s + e.qty)}',
                  style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'Subtotal: ${_money(data.subtotal)}',
                style: const TextStyle(fontSize: 9),
              ),
              const SizedBox(width: 12),
              Text(
                'Shipping: ${_money(data.shippingCharge)}',
                style: const TextStyle(fontSize: 9),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            color: const Color(0xffeeeeee),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'GRAND TOTAL:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                ),
                Text(
                  _money(data.grandTotal),
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      alignment: Alignment.center,
      color: const Color(0xffeeeeee),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w900),
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  const _TableCell(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 2),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black26),
          right: BorderSide(color: Colors.black26),
        ),
      ),
      child: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 7.5),
      ),
    );
  }
}

class _PreviewBottom extends StatelessWidget {
  const _PreviewBottom({required this.data});

  final ShippingLabel4x6Data data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(7),
      decoration: const BoxDecoration(border: Border(top: BorderSide())),
      child: Row(
        children: [
          const Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inventory_2_outlined, size: 22),
                SizedBox(height: 3),
                Text('Handle with Care', style: TextStyle(fontSize: 7.5)),
                SizedBox(height: 5),
                Icon(Icons.umbrella_outlined, size: 22),
                SizedBox(height: 3),
                Text('Keep Dry', style: TextStyle(fontSize: 7.5)),
              ],
            ),
          ),
          Container(width: 1, color: Colors.black),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: _SmallTextBlock(
                title: 'Return Address',
                lines: [
                  data.brand.returnAddress.isNotEmpty
                      ? data.brand.returnAddress
                      : data.returnAddress,
                  data.brand.phone.isNotEmpty
                      ? 'Phone: ${data.brand.phone}'
                      : '',
                  if (data.website.isNotEmpty) data.website,
                ],
              ),
            ),
          ),
          Container(width: 1, color: Colors.black),
          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.all(3),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: data.payment.toLowerCase().contains('cod')
                      ? Colors.black
                      : Colors.black54,
                ),
              ),
              child: Center(
                child: Text(
                  data.payment.toLowerCase().contains('cod')
                      ? 'COLLECT CASH\n${_money(data.codAmount)}'
                      : 'DO NOT COLLECT CASH\nPREPAID ORDER',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallTextBlock extends StatelessWidget {
  const _SmallTextBlock({
    required this.title,
    required this.lines,
  });

  final String title;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
        ),
        ...lines
            .where((line) => line.trim().isNotEmpty)
            .map(
              (line) => Text(
                line,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 8.5, height: 1.1),
              ),
            ),
      ],
    );
  }
}

/// Main 4x6 PDF/printing service.
class ShippingLabel4x6 {
  ShippingLabel4x6._();

  static const PdfPageFormat pageFormat = PdfPageFormat(
    4 * PdfPageFormat.inch,
    6 * PdfPageFormat.inch,
    marginAll: 0,
  );

  static Future<Uint8List> buildPdf(
    ShippingLabel4x6Data data,
  ) async {
    final document = pw.Document();

    document.addPage(
      pw.Page(
        pageFormat: pageFormat,
        margin: pw.EdgeInsets.zero,
        build: (context) => _pdfLabel(data),
      ),
    );

    return document.save();
  }

  static Future<void> printLabel(
    ShippingLabel4x6Data data,
  ) async {
    final bytes = await buildPdf(data);

    await Printing.layoutPdf(
      name: 'K-Store-${data.orderId}-${data.awb}.pdf',
      onLayout: (_) async => bytes,
      format: pageFormat,
    );
  }

  static Future<void> sharePdf(
    ShippingLabel4x6Data data,
  ) async {
    final bytes = await buildPdf(data);

    await Printing.sharePdf(
      bytes: bytes,
      filename: 'K-Store-${data.orderId}-${data.awb}.pdf',
    );
  }

  static pw.Widget _pdfLabel(ShippingLabel4x6Data data) {
    final border = pw.Border.all(width: 0.7, color: PdfColors.black);

    return pw.Container(
      width: pageFormat.width,
      height: pageFormat.height,
      decoration: pw.BoxDecoration(
        border: border,
      ),
      child: pw.Column(
        children: [
          pw.Container(
            height: 60,
            child: pw.Row(
              children: [
                pw.Expanded(
                  flex: 5,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(7),
                    child: pw.Row(
                      children: [
                        pw.Container(
                          width: 38,
                          height: 38,
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(
                            color: PdfColors.black,
                            borderRadius: pw.BorderRadius.circular(5),
                          ),
                          child: pw.Text(
                            data.brand.logoText,
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 22,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                        pw.SizedBox(width: 6),
                        pw.Expanded(
                          child: pw.Text(
                            data.brand.businessName,
                            style: pw.TextStyle(
                              fontSize: 17,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.Container(width: 0.7, color: PdfColors.black),
                pw.Expanded(
                  flex: 5,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(6),
                    child: _pdfSmallText(
                      'From (Sold By)',
                      [
                        data.brand.businessName,
                        data.brand.address,
                        'Phone: ${data.brand.phone}',
                        if (data.website.isNotEmpty) data.website,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            height: 82,
            width: double.infinity,
            padding: const pw.EdgeInsets.fromLTRB(8, 4, 8, 4),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                top: pw.BorderSide(),
                bottom: pw.BorderSide(),
              ),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  color: PdfColors.black,
                  padding: const pw.EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 2,
                  ),
                  child: pw.Text(
                    'SHIP TO',
                    style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 3),
                pw.Text(
                  data.customerName,
                  style: pw.TextStyle(
                    fontSize: 13,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  data.fullAddress,
                  maxLines: 2,
                  style: const pw.TextStyle(fontSize: 7.2),
                ),
                pw.Text(
                  'Phone: ${data.phone}',
                  style: pw.TextStyle(
                    fontSize: 7.2,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            height: 98,
            child: pw.Row(
              children: [
                pw.Expanded(
                  flex: 7,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(6),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'AWB No:',
                          style: pw.TextStyle(
                            fontSize: 8,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          data.awb,
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Expanded(
                          child: pw.BarcodeWidget(
                            barcode: pw.Barcode.code128(),
                            data: data.awb,
                            drawText: false,
                          ),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Center(
                          child: pw.Text(
                            data.awb,
                            style: const pw.TextStyle(fontSize: 6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.Container(width: 0.7, color: PdfColors.black),
                pw.Expanded(
                  flex: 3,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(6),
                    child: pw.Column(
                      children: [
                        pw.Text(
                          data.courier,
                          maxLines: 2,
                          style: pw.TextStyle(
                            fontSize: 8,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Expanded(
                          child: pw.BarcodeWidget(
                            barcode: pw.Barcode.qrCode(),
                            data: data.awb,
                            drawText: false,
                          ),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          'Scan for Tracking',
                          style: const pw.TextStyle(fontSize: 5.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            height: 35,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                top: pw.BorderSide(),
                bottom: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                _pdfInfo('Order No:', data.orderId),
                _pdfInfo('Order Date:', data.orderDate),
                _pdfInfo('Payment:', data.payment),
                _pdfInfo('PIN:', data.pinCode),
                _pdfInfo('Weight:', data.weight),
              ],
            ),
          ),
          pw.Expanded(
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Column(
                children: [
                  pw.Table(
                    border: pw.TableBorder.all(
                      width: 0.4,
                      color: PdfColors.grey700,
                    ),
                    columnWidths: const {
                      0: pw.FixedColumnWidth(18),
                      1: pw.FlexColumnWidth(5),
                      2: pw.FixedColumnWidth(24),
                      3: pw.FixedColumnWidth(45),
                      4: pw.FixedColumnWidth(48),
                    },
                    children: [
                      pw.TableRow(
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.grey300,
                        ),
                        children: [
                          _pdfCell('#', bold: true),
                          _pdfCell('Product Name', bold: true),
                          _pdfCell('Qty', bold: true),
                          _pdfCell('Price', bold: true),
                          _pdfCell('Total', bold: true),
                        ],
                      ),
                      ...data.items.take(8).toList().asMap().entries.map(
                        (entry) {
                          final item = entry.value;
                          return pw.TableRow(
                            children: [
                              _pdfCell('${entry.key + 1}'),
                              _pdfCell(item.name),
                              _pdfCell('${item.qty}'),
                              _pdfCell(_money(item.price)),
                              _pdfCell(_money(item.total)),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  pw.Spacer(),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Items: ${data.items.fold<int>(0, (s, e) => s + e.qty)}',
                        style: pw.TextStyle(fontSize: 6.5),
                      ),
                      pw.Text(
                        'Subtotal: ${_money(data.subtotal)}',
                        style: pw.TextStyle(fontSize: 6.5),
                      ),
                      pw.Text(
                        'Shipping: ${_money(data.shippingCharge)}',
                        style: pw.TextStyle(fontSize: 6.5),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 3),
                  pw.Container(
                    width: double.infinity,
                    color: PdfColors.grey300,
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'GRAND TOTAL',
                          style: pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          _money(data.grandTotal),
                          style: pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          pw.Container(
            height: 68,
            padding: const pw.EdgeInsets.all(5),
            decoration: const pw.BoxDecoration(
              border: pw.Border(top: pw.BorderSide()),
            ),
            child: pw.Row(
              children: [
                pw.Expanded(
                  flex: 3,
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        'HANDLE WITH CARE',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 6,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        'KEEP DRY  •  FRAGILE',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 6,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Container(width: 0.7, color: PdfColors.black),
                pw.Expanded(
                  flex: 6,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 6),
                    child: _pdfSmallText(
                      'Return Address',
                      [
                        data.brand.returnAddress.isNotEmpty
                            ? data.brand.returnAddress
                            : data.returnAddress,
                        'Phone: ${data.brand.phone}',
                        if (data.website.isNotEmpty) data.website,
                      ],
                    ),
                  ),
                ),
                pw.Container(width: 0.7, color: PdfColors.black),
                pw.Expanded(
                  flex: 4,
                  child: pw.Container(
                    margin: const pw.EdgeInsets.all(2),
                    padding: const pw.EdgeInsets.all(4),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(width: 1),
                    ),
                    child: pw.Center(
                      child: pw.Text(
                        data.payment.toLowerCase().contains('cod')
                            ? 'COLLECT CASH\\n${_money(data.codAmount)}'
                            : 'DO NOT COLLECT CASH\\nPREPAID ORDER',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 7,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _pdfSmallText(String title, List<String> lines) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 7.5,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        ...lines
            .where((line) => line.trim().isNotEmpty)
            .map(
              (line) => pw.Text(
                line,
                maxLines: 2,
                style: const pw.TextStyle(fontSize: 6),
              ),
            ),
      ],
    );
  }

  static pw.Widget _pdfInfo(String title, String value) {
    return pw.Expanded(
      child: pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        decoration: const pw.BoxDecoration(
          border: pw.Border(right: pw.BorderSide()),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(title, style: const pw.TextStyle(fontSize: 5.5)),
            pw.Text(
              value,
              maxLines: 2,
              style: pw.TextStyle(
                fontSize: 6,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static pw.Widget _pdfCell(
    String value, {
    bool bold = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(2),
      child: pw.Text(
        value,
        maxLines: 2,
        style: pw.TextStyle(
          fontSize: 5.8,
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }
}

class _BarcodePainter extends CustomPainter {
  _BarcodePainter(this.value);

  final String value;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    if (size.width <= 0 || size.height <= 0) return;

    // Deterministic Code128-like visual barcode for the on-screen preview.
    // The real printable PDF uses pdf's actual Code128 generator.
    final bars = <int>[2, 1, 2, 1, 3, 1, 2];
    var seed = value.codeUnits.fold<int>(17, (a, b) => (a * 31 + b) & 0x7fffffff);
    var x = 0.0;

    while (x < size.width) {
      seed = (seed * 1103515245 + 12345) & 0x7fffffff;
      final width = 1.0 + (seed % 4);
      canvas.drawRect(
        Rect.fromLTWH(x, 0, width, size.height),
        paint,
      );
      x += width + 1.0;
      seed = (seed * 1103515245 + 12345) & 0x7fffffff;
      x += (seed % 2).toDouble();
    }

    // Start/end guards.
    for (var i = 0; i < bars.length; i++) {
      final guardWidth = bars[i].toDouble();
      canvas.drawRect(
        Rect.fromLTWH(
          i.isEven ? i.toDouble() : i.toDouble() + guardWidth,
          0,
          guardWidth,
          size.height,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BarcodePainter oldDelegate) =>
      oldDelegate.value != value;
}

class _PseudoQr extends StatelessWidget {
  const _PseudoQr({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    // The printable PDF contains a real QR generated by pdf.
    // This preview intentionally avoids another runtime package dependency.
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: _QrPreviewPainter(value),
      ),
    );
  }
}

class _QrPreviewPainter extends CustomPainter {
  _QrPreviewPainter(this.value);

  final String value;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = Colors.black;
    final cells = 21;
    final cell = size.width / cells;
    final seed0 = value.codeUnits.fold<int>(7, (a, b) => (a * 33 + b) & 0x7fffffff);

    bool finder(int x, int y, int ox, int oy) {
      if (x < ox || x >= ox + 7 || y < oy || y >= oy + 7) return false;
      final dx = x - ox;
      final dy = y - oy;
      return dx == 0 ||
          dx == 6 ||
          dy == 0 ||
          dy == 6 ||
          (dx >= 2 && dx <= 4 && dy >= 2 && dy <= 4);
    }

    for (var y = 0; y < cells; y++) {
      for (var x = 0; x < cells; x++) {
        final isFinder =
            finder(x, y, 0, 0) ||
            finder(x, y, cells - 7, 0) ||
            finder(x, y, 0, cells - 7);

        var seed = seed0 ^ (x * 92821) ^ (y * 68917);
        seed = (seed * 1103515245 + 12345) & 0x7fffffff;

        if (isFinder || seed.isOdd) {
          canvas.drawRect(
            Rect.fromLTWH(x * cell, y * cell, cell + .2, cell + .2),
            p,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _QrPreviewPainter oldDelegate) =>
      oldDelegate.value != value;
}

String _money(double value) => '₹${value.toStringAsFixed(2)}';
