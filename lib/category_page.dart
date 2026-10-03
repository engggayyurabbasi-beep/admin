import 'package:flutter/material.dart';

/// K - Store Admin
/// Category Management Page
///
/// This page is a complete UI for Category Management:
/// - Category overview
/// - Add category
/// - Search categories
/// - Active/Inactive filter
/// - Edit category
/// - Delete category
/// - Enable/disable category
/// - Product count
/// - Sub-category count
///
/// NOTE:
/// This version keeps data in local page state.
/// Connect the add/edit/delete/toggle methods to your API/Firebase
/// when the backend is ready.

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController _searchController = TextEditingController();

  String _filter = 'All';

  final List<CategoryItem> _categories = [
    CategoryItem(
      id: '1',
      name: 'Ayurvedic',
      description: 'Ayurvedic and herbal products',
      icon: Icons.spa_outlined,
      color: const Color(0xFF16A05D),
      productCount: 24,
      subCategoryCount: 5,
      active: true,
    ),
    CategoryItem(
      id: '2',
      name: 'Unani',
      description: 'Unani medicines and products',
      icon: Icons.local_pharmacy_outlined,
      color: const Color(0xFF2E7D32),
      productCount: 18,
      subCategoryCount: 4,
      active: true,
    ),
    CategoryItem(
      id: '3',
      name: 'Herbal',
      description: 'Natural herbal products',
      icon: Icons.eco_outlined,
      color: const Color(0xFF00897B),
      productCount: 31,
      subCategoryCount: 7,
      active: true,
    ),
    CategoryItem(
      id: '4',
      name: 'Personal Care',
      description: 'Hair, skin and personal care',
      icon: Icons.face_retouching_natural_outlined,
      color: const Color(0xFF7B1FA2),
      productCount: 16,
      subCategoryCount: 6,
      active: true,
    ),
    CategoryItem(
      id: '5',
      name: 'Wellness',
      description: 'Health and wellness products',
      icon: Icons.favorite_border,
      color: const Color(0xFFE91E63),
      productCount: 12,
      subCategoryCount: 3,
      active: false,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<CategoryItem> get _filteredCategories {
    final query = _searchController.text.trim().toLowerCase();

    return _categories.where((category) {
      final matchesSearch =
          query.isEmpty ||
          category.name.toLowerCase().contains(query) ||
          category.description.toLowerCase().contains(query);

      final matchesFilter =
          _filter == 'All' ||
          (_filter == 'Active' && category.active) ||
          (_filter == 'Inactive' && !category.active);

      return matchesSearch && matchesFilter;
    }).toList();
  }

  int get _activeCount => _categories.where((e) => e.active).length;

  int get _inactiveCount => _categories.where((e) => !e.active).length;

  int get _productCount =>
      _categories.fold(0, (total, item) => total + item.productCount);

  void _showAddCategoryDialog() {
    _showCategoryDialog();
  }

  void _showEditCategoryDialog(CategoryItem category) {
    _showCategoryDialog(category: category);
  }

  void _showCategoryDialog({CategoryItem? category}) {
    final nameController = TextEditingController(text: category?.name ?? '');
    final descriptionController =
        TextEditingController(text: category?.description ?? '');

    IconData selectedIcon = category?.icon ?? Icons.category_outlined;
    Color selectedColor =
        category?.color ?? const Color(0xFF16A05D);

    final icons = <IconData>[
      Icons.category_outlined,
      Icons.spa_outlined,
      Icons.eco_outlined,
      Icons.local_pharmacy_outlined,
      Icons.medication_outlined,
      Icons.favorite_border,
      Icons.face_retouching_natural_outlined,
      Icons.health_and_safety_outlined,
      Icons.shopping_bag_outlined,
      Icons.home_outlined,
    ];

    final colors = <Color>[
      const Color(0xFF16A05D),
      const Color(0xFF2E7D32),
      const Color(0xFF00897B),
      const Color(0xFF1976D2),
      const Color(0xFF7B1FA2),
      const Color(0xFFE91E63),
      const Color(0xFFE67E22),
      const Color(0xFF455A64),
    ];

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                category == null ? 'Add Category' : 'Edit Category',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              content: SizedBox(
                width: 520,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: nameController,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          labelText: 'Category Name',
                          hintText: 'e.g. Ayurvedic',
                          prefixIcon:
                              const Icon(Icons.category_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: descriptionController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'Short category description',
                          prefixIcon:
                              const Icon(Icons.description_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Select Icon',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: icons.map((icon) {
                          final selected = selectedIcon == icon;
                          return InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              setDialogState(() {
                                selectedIcon = icon;
                              });
                            },
                            child: Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                color: selected
                                    ? selectedColor.withValues(alpha: 0.12)
                                    : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: selected
                                      ? selectedColor
                                      : Colors.transparent,
                                  width: 1.5,
                                ),
                              ),
                              child: Icon(
                                icon,
                                color: selected
                                    ? selectedColor
                                    : Colors.grey.shade700,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Select Color',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: colors.map((color) {
                          final selected = selectedColor == color;
                          return InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              setDialogState(() {
                                selectedColor = color;
                              });
                            },
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selected
                                      ? Colors.black
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                              child: selected
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 19,
                                    )
                                  : null,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                FilledButton.icon(
                  onPressed: () {
                    final name = nameController.text.trim();

                    if (name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter category name.'),
                        ),
                      );
                      return;
                    }

                    setState(() {
                      if (category == null) {
                        _categories.insert(
                          0,
                          CategoryItem(
                            id: DateTime.now()
                                .microsecondsSinceEpoch
                                .toString(),
                            name: name,
                            description:
                                descriptionController.text.trim().isEmpty
                                    ? 'Product category'
                                    : descriptionController.text.trim(),
                            icon: selectedIcon,
                            color: selectedColor,
                            productCount: 0,
                            subCategoryCount: 0,
                            active: true,
                          ),
                        );
                      } else {
                        final index = _categories.indexWhere(
                          (item) => item.id == category.id,
                        );

                        if (index != -1) {
                          _categories[index] = category.copyWith(
                            name: name,
                            description:
                                descriptionController.text.trim().isEmpty
                                    ? 'Product category'
                                    : descriptionController.text.trim(),
                            icon: selectedIcon,
                            color: selectedColor,
                          );
                        }
                      }
                    });

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          category == null
                              ? 'Category added successfully.'
                              : 'Category updated successfully.',
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    category == null ? Icons.add : Icons.save_outlined,
                  ),
                  label: Text(category == null ? 'Add Category' : 'Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteCategory(CategoryItem category) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Delete Category',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          content: Text(
            'Are you sure you want to delete "${category.name}"? '
            'This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  _categories.removeWhere(
                    (item) => item.id == category.id,
                  );
                });

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Category deleted successfully.'),
                  ),
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _toggleCategory(CategoryItem category) {
    setState(() {
      final index =
          _categories.indexWhere((item) => item.id == category.id);

      if (index != -1) {
        _categories[index] =
            category.copyWith(active: !category.active);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = _filteredCategories;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1F2937),
        title: const Text(
          'Categories',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: () => setState(() {}),
            icon: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;

          return SingleChildScrollView(
            padding: EdgeInsets.all(isWide ? 24 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(isWide),
                const SizedBox(height: 20),
                _buildStats(),
                const SizedBox(height: 20),
                _buildToolbar(isWide),
                const SizedBox(height: 16),
                if (categories.isEmpty)
                  _buildEmptyState()
                else if (isWide)
                  _buildDesktopTable(categories)
                else
                  _buildMobileList(categories),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddCategoryDialog,
        backgroundColor: const Color(0xFF16A05D),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text(
          'Add Category',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isWide) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF16A05D),
            Color(0xFF087F5B),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Flex(
        direction: isWide ? Axis.horizontal : Axis.vertical,
        crossAxisAlignment:
            isWide ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: isWide ? 1 : 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Category Management',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Create, organize and manage your store categories.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.88),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          if (isWide) const SizedBox(width: 20),
          if (!isWide) const SizedBox(height: 16),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF087F5B),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 13,
              ),
            ),
            onPressed: _showAddCategoryDialog,
            icon: const Icon(Icons.add),
            label: const Text(
              'Add Category',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = width >= 900
            ? 4
            : width >= 560
                ? 2
                : 1;

        final cards = [
          _StatCard(
            title: 'Total Categories',
            value: '${_categories.length}',
            icon: Icons.category_outlined,
            iconColor: const Color(0xFF1976D2),
          ),
          _StatCard(
            title: 'Active',
            value: '$_activeCount',
            icon: Icons.check_circle_outline,
            iconColor: const Color(0xFF16A05D),
          ),
          _StatCard(
            title: 'Inactive',
            value: '$_inactiveCount',
            icon: Icons.pause_circle_outline,
            iconColor: const Color(0xFFE67E22),
          ),
          _StatCard(
            title: 'Products',
            value: '$_productCount',
            icon: Icons.inventory_2_outlined,
            iconColor: const Color(0xFF7B1FA2),
          ),
        ];

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cards.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: columns == 1 ? 4.0 : 2.1,
          ),
          itemBuilder: (_, index) => cards[index],
        );
      },
    );
  }

  Widget _buildToolbar(bool isWide) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Flex(
        direction: isWide ? Axis.horizontal : Axis.vertical,
        children: [
          Expanded(
            flex: isWide ? 1 : 0,
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search categories...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                        icon: const Icon(Icons.clear),
                      ),
                filled: true,
                fillColor: const Color(0xFFF7F8FA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          if (isWide) const SizedBox(width: 14),
          if (!isWide) const SizedBox(height: 12),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(
                value: 'All',
                label: Text('All'),
              ),
              ButtonSegment(
                value: 'Active',
                label: Text('Active'),
              ),
              ButtonSegment(
                value: 'Inactive',
                label: Text('Inactive'),
              ),
            ],
            selected: {_filter},
            onSelectionChanged: (selection) {
              setState(() {
                _filter = selection.first;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopTable(List<CategoryItem> categories) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(
            const Color(0xFFF7F8FA),
          ),
          columns: const [
            DataColumn(label: Text('Category')),
            DataColumn(label: Text('Products')),
            DataColumn(label: Text('Sub-categories')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Actions')),
          ],
          rows: categories.map((category) {
            return DataRow(
              cells: [
                DataCell(_CategoryName(category: category)),
                DataCell(Text('${category.productCount}')),
                DataCell(Text('${category.subCategoryCount}')),
                DataCell(_StatusChip(active: category.active)),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: 'Edit',
                        onPressed: () =>
                            _showEditCategoryDialog(category),
                        icon: const Icon(Icons.edit_outlined),
                      ),
                      IconButton(
                        tooltip: category.active
                            ? 'Disable'
                            : 'Enable',
                        onPressed: () => _toggleCategory(category),
                        icon: Icon(
                          category.active
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Delete',
                        onPressed: () => _deleteCategory(category),
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMobileList(List<CategoryItem> categories) {
    return Column(
      children: categories.map((category) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  _CategoryAvatar(category: category),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _CategoryName(category: category),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _showEditCategoryDialog(category);
                      } else if (value == 'toggle') {
                        _toggleCategory(category);
                      } else if (value == 'delete') {
                        _deleteCategory(category);
                      }
                    },
                    itemBuilder: (_) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.edit_outlined),
                          title: Text('Edit'),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'toggle',
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            category.active
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          title: Text(
                            category.active ? 'Disable' : 'Enable',
                          ),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          title: Text('Delete'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  category.description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _MiniInfo(
                    icon: Icons.inventory_2_outlined,
                    label: '${category.productCount} Products',
                  ),
                  const SizedBox(width: 8),
                  _MiniInfo(
                    icon: Icons.account_tree_outlined,
                    label:
                        '${category.subCategoryCount} Sub-categories',
                  ),
                  const Spacer(),
                  _StatusChip(active: category.active),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 60,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.category_outlined,
            size: 56,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 14),
          const Text(
            'No categories found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try another search or add a new category.',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: _showAddCategoryDialog,
            icon: const Icon(Icons.add),
            label: const Text('Add Category'),
          ),
        ],
      ),
    );
  }
}

class CategoryItem {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final int productCount;
  final int subCategoryCount;
  final bool active;

  const CategoryItem({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.productCount,
    required this.subCategoryCount,
    required this.active,
  });

  CategoryItem copyWith({
    String? name,
    String? description,
    IconData? icon,
    Color? color,
    int? productCount,
    int? subCategoryCount,
    bool? active,
  }) {
    return CategoryItem(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      productCount: productCount ?? this.productCount,
      subCategoryCount: subCategoryCount ?? this.subCategoryCount,
      active: active ?? this.active,
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryAvatar extends StatelessWidget {
  final CategoryItem category;

  const _CategoryAvatar({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: category.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(
        category.icon,
        color: category.color,
      ),
    );
  }
}

class _CategoryName extends StatelessWidget {
  final CategoryItem category;

  const _CategoryName({required this.category});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CategoryAvatar(category: category),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                category.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final bool active;

  const _StatusChip({required this.active});

  @override
  Widget build(BuildContext context) {
    final color = active
        ? const Color(0xFF16A05D)
        : const Color(0xFFE67E22);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        active ? 'Active' : 'Inactive',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _MiniInfo extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MiniInfo({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: Colors.grey.shade700,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
