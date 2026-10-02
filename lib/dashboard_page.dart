import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String selectedPeriod = 'This Month';

  final List<Map<String, dynamic>> recentOrders = [
    {
      'id': '#KS10245',
      'customer': 'Rahul Sharma',
      'amount': '₹1,250',
      'status': 'Delivered',
    },
    {
      'id': '#KS10244',
      'customer': 'Aman Khan',
      'amount': '₹890',
      'status': 'Processing',
    },
    {
      'id': '#KS10243',
      'customer': 'Priya Singh',
      'amount': '₹2,450',
      'status': 'Pending',
    },
    {
      'id': '#KS10242',
      'customer': 'Mohammed Arif',
      'amount': '₹650',
      'status': 'Delivered',
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {'name': 'Herbal', 'orders': 128, 'icon': Icons.eco},
    {'name': 'Ayurvedic', 'orders': 96, 'icon': Icons.local_pharmacy},
    {'name': 'Unani', 'orders': 74, 'icon': Icons.spa},
    {'name': 'Personal Care', 'orders': 52, 'icon': Icons.health_and_safety},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF202124),
        title: const Text(
          'K - Store Admin',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 19,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshDashboard,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF17181A),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFE3E5EA),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedPeriod,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      borderRadius: BorderRadius.circular(12),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      items: const [
                        DropdownMenuItem(
                          value: 'Today',
                          child: Text('Today'),
                        ),
                        DropdownMenuItem(
                          value: 'This Week',
                          child: Text('This Week'),
                        ),
                        DropdownMenuItem(
                          value: 'This Month',
                          child: Text('This Month'),
                        ),
                        DropdownMenuItem(
                          value: 'This Year',
                          child: Text('This Year'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedPeriod = value;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            _buildSummaryGrid(),
            const SizedBox(height: 22),
            _buildSectionTitle('Sales Overview'),
            const SizedBox(height: 12),
            _buildSalesChart(),
            const SizedBox(height: 22),
            _buildSectionTitle('Order Status'),
            const SizedBox(height: 12),
            _buildOrderStatus(),
            const SizedBox(height: 22),
            _buildSectionTitle('Top Categories'),
            const SizedBox(height: 12),
            _buildCategories(),
            const SizedBox(height: 22),
            _buildSectionTitle('Recent Orders'),
            const SizedBox(height: 12),
            _buildRecentOrders(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryGrid() {
    final cards = [
      {
        'title': 'Total Sales',
        'value': '₹1,24,580',
        'change': '+12.5%',
        'icon': Icons.currency_rupee_rounded,
        'iconColor': const Color(0xFF2563EB),
      },
      {
        'title': 'Orders',
        'value': '248',
        'change': '+8.2%',
        'icon': Icons.shopping_bag_outlined,
        'iconColor': const Color(0xFF7C3AED),
      },
      {
        'title': 'Customers',
        'value': '1,846',
        'change': '+15.4%',
        'icon': Icons.people_outline_rounded,
        'iconColor': const Color(0xFF059669),
      },
      {
        'title': 'Products',
        'value': '356',
        'change': '+4.8%',
        'icon': Icons.inventory_2_outlined,
        'iconColor': const Color(0xFFEA580C),
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cards.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.48,
      ),
      itemBuilder: (context, index) {
        final card = cards[index];

        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.035),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: (card['iconColor'] as Color).withValues(
                        alpha: 0.10,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      card['icon'] as IconData,
                      color: card['iconColor'] as Color,
                      size: 21,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.more_horiz_rounded,
                    color: Color(0xFF9AA0A6),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                card['title'] as String,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF73777D),
                ),
              ),
              const SizedBox(height: 3),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    card['value'] as String,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1D2024),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      card['change'] as String,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF059669),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF17181A),
            ),
          ),
        ),
        if (title != 'Recent Orders')
          TextButton(
            onPressed: () {},
            child: const Text('View All'),
          ),
      ],
    );
  }

  Widget _buildSalesChart() {
    return Container(
      height: 250,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                '₹1,24,580',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F7EF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '+12.5%',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF059669),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Expanded(
            child: CustomPaint(
              painter: SalesChartPainter(),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatus() {
    final statuses = [
      {
        'name': 'Delivered',
        'count': '126',
        'percent': '51%',
        'color': const Color(0xFF059669),
      },
      {
        'name': 'Processing',
        'count': '62',
        'percent': '25%',
        'color': const Color(0xFF2563EB),
      },
      {
        'name': 'Pending',
        'count': '38',
        'percent': '15%',
        'color': const Color(0xFFF59E0B),
      },
      {
        'name': 'Cancelled',
        'count': '22',
        'percent': '9%',
        'color': const Color(0xFFDC2626),
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: statuses.map((status) {
          final color = status['color'] as Color;

          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    status['name'] as String,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  status['count'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 48,
                  child: Text(
                    status['percent'] as String,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF73777D),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: categories.map((category) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                category['icon'] as IconData,
                color: const Color(0xFF059669),
              ),
            ),
            title: Text(
              category['name'] as String,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              '${category['orders']} orders',
              style: const TextStyle(
                color: Color(0xFF858A91),
                fontSize: 12,
              ),
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF9AA0A6),
            ),
            onTap: () {},
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRecentOrders() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: recentOrders.map((order) {
          final status = order['status'] as String;

          Color statusColor = const Color(0xFF2563EB);
          Color statusBackground = const Color(0xFFEFF6FF);

          if (status == 'Delivered') {
            statusColor = const Color(0xFF059669);
            statusBackground = const Color(0xFFECFDF5);
          } else if (status == 'Pending') {
            statusColor = const Color(0xFFD97706);
            statusBackground = const Color(0xFFFFF7ED);
          }

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            leading: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Color(0xFF4B5563),
                size: 21,
              ),
            ),
            title: Text(
              order['id'] as String,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            subtitle: Text(
              order['customer'] as String,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF858A91),
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  order['amount'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: statusBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _refreshDashboard() async {
    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) {
      return;
    }

    setState(() {});
  }
}

class SalesChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFFE8EAF0)
      ..strokeWidth = 1;

    final linePaint = Paint()
      ..color = const Color(0xFF2563EB)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = const Color(0xFF2563EB).withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    const rows = 4;

    for (int i = 0; i <= rows; i++) {
      final y = size.height * i / rows;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    final points = [
      Offset(0, size.height * 0.72),
      Offset(size.width * 0.14, size.height * 0.58),
      Offset(size.width * 0.28, size.height * 0.64),
      Offset(size.width * 0.42, size.height * 0.38),
      Offset(size.width * 0.56, size.height * 0.48),
      Offset(size.width * 0.70, size.height * 0.23),
      Offset(size.width * 0.84, size.height * 0.34),
      Offset(size.width, size.height * 0.12),
    ];

    final linePath = Path()..moveTo(points.first.dx, points.first.dy);

    for (int i = 1; i < points.length; i++) {
      linePath.lineTo(points[i].dx, points[i].dy);
    }

    final fillPath = Path.from(linePath)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, linePaint);

    final dotPaint = Paint()
      ..color = const Color(0xFF2563EB)
      ..style = PaintingStyle.fill;

    for (final point in points) {
      canvas.drawCircle(point, 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
