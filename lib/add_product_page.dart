import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final brand = TextEditingController();
  final sku = TextEditingController();
  final price = TextEditingController(text: '0');
  final mrp = TextEditingController(text: '0');
  final cost = TextEditingController(text: '0');
  final stock = TextEditingController(text: '0');
  final shortDescription = TextEditingController();
  final description = TextEditingController();

  String? category;
  String? subCategory;
  String stockStatus = 'In Stock';

  final categories = <String>[
    'Herbal',
    'Ayurvedic',
    'Unani',
    'Personal Care',
    'Health & Wellness',
    'Hair Care',
    'Skin Care',
    'Other',
  ];

  final subCategories = <String, List<String>>{
    'Herbal': ['Herbal Oil', 'Herbal Powder', 'Herbal Syrup', 'Herbal Tablet'],
    'Ayurvedic': ['Oil', 'Powder', 'Syrup', 'Tablet'],
    'Unani': ['Majoon', 'Syrup', 'Tablet', 'Oil', 'Powder'],
    'Personal Care': ['Hair Care', 'Skin Care', 'Body Care'],
    'Health & Wellness': ['General Wellness', 'Digestive Care', 'Fitness'],
    'Hair Care': ['Hair Oil', 'Hair Powder', 'Hair Shampoo'],
    'Skin Care': ['Face Care', 'Body Care', 'Skin Oil'],
    'Other': ['Other'],
  };

  @override
  void dispose() {
    name.dispose();
    brand.dispose();
    sku.dispose();
    price.dispose();
    mrp.dispose();
    cost.dispose();
    stock.dispose();
    shortDescription.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF4B83), Color(0xFFE91E63)],
                ),
              ),
              child: const Text(
                'K',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'K - Store',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF17181A),
                  ),
                ),
                Text(
                  'Admin Panel',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF727781),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  size: 29,
                ),
              ),
              Positioned(
                right: 4,
                top: 3,
                child: Container(
                  width: 20,
                  height: 20,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE91E63),
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '5',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 6),
          Container(
            width: 43,
            height: 43,
            decoration: const BoxDecoration(
              color: Color(0xFFE5E7EB),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Color(0xFF5D636B)),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    const SizedBox(height: 22),
                    _images(),
                    const SizedBox(height: 22),
                    _label('Product Name', required: true),
                    const SizedBox(height: 7),
                    _field(
                      name,
                      'Enter product name (e.g. Soha Hair Oil)',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Product name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _dropdown(
                            'Category',
                            category,
                            'Select Category',
                            categories,
                            (value) {
                              setState(() {
                                category = value;
                                subCategory = null;
                              });
                            },
                            required: true,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _dropdown(
                            'Sub Category',
                            subCategory,
                            'Select Sub Category',
                            category == null
                                ? const <String>[]
                                : (subCategories[category] ?? const <String>[]),
                            (value) {
                              setState(() => subCategory = value);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _labelField(
                            'Brand',
                            brand,
                            'Enter brand name',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _labelField(
                            'SKU',
                            sku,
                            'Enter SKU (e.g. SOHA100)',
                            required: true,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'SKU is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _labelField(
                            'Price (₹)',
                            price,
                            '0',
                            keyboardType: TextInputType.number,
                            required: true,
                          ),
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: _labelField(
                            'MRP (₹)',
                            mrp,
                            '0',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: _labelField(
                            'Cost Price (₹)',
                            cost,
                            '0',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _labelField(
                            'Stock Quantity',
                            stock,
                            '0',
                            keyboardType: TextInputType.number,
                            required: true,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _dropdown(
                            'Stock Status',
                            stockStatus,
                            'Select Status',
                            const [
                              'In Stock',
                              'Low Stock',
                              'Out of Stock',
                              'Coming Soon',
                            ],
                            (value) {
                              if (value != null) {
                                setState(() => stockStatus = value);
                              }
                            },
                            green: stockStatus == 'In Stock',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    _label('Short Description', required: true),
                    const SizedBox(height: 7),
                    _field(
                      shortDescription,
                      'Enter short description (shown in product list)',
                      maxLines: 4,
                      maxLength: 200,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Short description is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    _label('Full Description', required: true),
                    const SizedBox(height: 7),
                    _descriptionBox(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            _bottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add New Product',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Fill in the product details to add to your store',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF747982),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          onPressed: null,
          icon: Icon(
            Icons.auto_awesome,
            size: 17,
            color: Color(0xFFE91E63),
          ),
          label: Text(
            'AI Generate',
            style: TextStyle(
              color: Color(0xFFD81B60),
              fontWeight: FontWeight.w800,
            ),
          ),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xFFFFEEF4)),
            side: WidgetStatePropertyAll(
              BorderSide(color: Color(0xFFFFB4CA)),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(13)),
              ),
            ),
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 12, vertical: 13),
            ),
          ),
        ),
      ],
    );
  }

  Widget _images() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Product Images',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            const Text(
              'Add up to 5 images',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF737982),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 145,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _imageBox(
                width: 175,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      size: 38,
                      color: Color(0xFF59616D),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Add Images',
                      style: TextStyle(
                        color: Color(0xFF59616D),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '(0/5)',
                      style: TextStyle(
                        color: Color(0xFF737982),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              _productImage(),
              const SizedBox(width: 10),
              _fadedProductImage(),
              const SizedBox(width: 10),
              _plusImage(),
              const SizedBox(width: 10),
              _plusImage(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _imageBox({
    required double width,
    required Widget child,
  }) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xFFFAFBFD),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: const Color(0xFFC9CED7),
          width: 1.2,
        ),
      ),
      child: child,
    );
  }

  Widget _productImage() {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFFD5D9E0)),
      ),
      child: Center(
        child: Container(
          height: 78,
          width: 52,
          decoration: BoxDecoration(
            color: const Color(0xFF7B211D),
            borderRadius: BorderRadius.circular(7),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Soha',
                style: TextStyle(
                  color: Color(0xFFF6D96A),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 5),
              Icon(
                Icons.local_florist,
                color: Color(0xFF4CAF50),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fadedProductImage() {
    return Opacity(
      opacity: 0.15,
      child: _productImage(),
    );
  }

  Widget _plusImage() {
    return _imageBox(
      width: 92,
      child: const Center(
        child: Icon(
          Icons.add,
          size: 31,
          color: Color(0xFF59616D),
        ),
      ),
    );
  }

  Widget _label(
    String text, {
    bool required = false,
  }) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Color(0xFF202124),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        children: required
            ? const [
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: Color(0xFFE91E63)),
                ),
              ]
            : const [],
      ),
    );
  }

  Widget _labelField(
    String label,
    TextEditingController controller,
    String hint, {
    bool required = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label, required: required),
        const SizedBox(height: 7),
        _field(
          controller,
          hint,
          keyboardType: keyboardType,
          validator: validator,
        ),
      ],
    );
  }

  Widget _field(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
    int? maxLength,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF202124),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xFF9AA1AB),
          fontSize: 14,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFDDE1E8),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFDDE1E8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFE91E63),
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _dropdown(
    String label,
    String? value,
    String hint,
    List<String> items,
    ValueChanged<String?> onChanged, {
    bool required = false,
    bool green = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label, required: required),
        const SizedBox(height: 7),
        Container(
          height: 53,
          decoration: BoxDecoration(
            color: green ? const Color(0xFFE9F9EF) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: green
                  ? const Color(0xFFB7E9C8)
                  : const Color(0xFFDDE1E8),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value != null && items.contains(value) ? value : null,
              isExpanded: true,
              borderRadius: BorderRadius.circular(12),
              hint: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  hint,
                  style: TextStyle(
                    color: green
                        ? const Color(0xFF228B45)
                        : const Color(0xFF9AA1AB),
                    fontSize: 14,
                  ),
                ),
              ),
              icon: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.keyboard_arrow_down_rounded),
              ),
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(item),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _descriptionBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDDE1E8)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 52,
            child: Row(
              children: [
                _tool(Icons.format_bold_rounded),
                _tool(Icons.format_italic_rounded),
                _tool(Icons.format_underlined_rounded),
                const VerticalDivider(
                  width: 15,
                  indent: 12,
                  endIndent: 12,
                ),
                _tool(Icons.format_list_bulleted_rounded),
                _tool(Icons.format_list_numbered_rounded),
                _tool(Icons.link_rounded),
                _tool(Icons.image_outlined),
              ],
            ),
          ),
          const Divider(height: 1),
          TextFormField(
            controller: description,
            minLines: 6,
            maxLines: 9,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Full description is required';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Enter detailed product description...',
              hintStyle: TextStyle(
                color: Color(0xFF9AA1AB),
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tool(IconData icon) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        icon,
        size: 21,
        color: const Color(0xFF46505C),
      ),
    );
  }

  Widget _bottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 54,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFE91E63),
                    side: const BorderSide(
                      color: Color(0xFFE91E63),
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF50057),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  child: const Text(
                    'Save Product',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _save() {
    FocusScope.of(context).unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    if (category == null) {
      _message('Please select a category.');
      return;
    }

    _message(
      '${name.text.trim()} saved successfully.',
      success: true,
    );

    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  void _message(
    String text, {
    bool success = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: success ? const Color(0xFF16A05D) : null,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
