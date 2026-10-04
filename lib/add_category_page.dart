import 'package:flutter/material.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _categoryIdController;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _sortOrderController = TextEditingController(text: '1');
  final _metaTitleController = TextEditingController();
  final _metaDescriptionController = TextEditingController();

  String _parentCategory = 'None';
  String _status = 'Active';
  bool _featured = false;
  bool _showInMenu = true;

  @override
  void initState() {
    super.initState();
    _categoryIdController = TextEditingController(
      text: 'C${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  @override
  void dispose() {
    _categoryIdController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _sortOrderController.dispose();
    _metaTitleController.dispose();
    _metaDescriptionController.dispose();
    super.dispose();
  }

  void _saveCategory() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Category saved successfully'),
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.pop(context, {
      'id': _categoryIdController.text.trim(),
      'name': _nameController.text.trim(),
      'description': _descriptionController.text.trim(),
      'parent': _parentCategory,
      'status': _status,
      'featured': _featured,
      'showInMenu': _showInMenu,
      'sortOrder': _sortOrderController.text.trim(),
      'metaTitle': _metaTitleController.text.trim(),
      'metaDescription': _metaDescriptionController.text.trim(),
    });
  }

  InputDecoration _inputDecoration({
    required String label,
    String? hint,
    IconData? icon,
    bool filled = true,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon == null ? null : Icon(icon),
      filled: filled,
      fillColor: const Color(0xFFFFF8F9),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE0D4D7)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE0D4D7)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFE91E63),
          width: 1.5,
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, String subtitle, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE91E63), Color(0xFF7B1FA2)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF0E5E8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.035),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _switchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: const Color(0xFFE91E63),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        titleSpacing: 0,
        title: const Text(
          'Add Category',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton.icon(
              onPressed: _saveCategory,
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Save'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFE91E63),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
            children: [
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle(
                      'Basic Information',
                      'Enter the main details of this category.',
                      Icons.category_outlined,
                    ),
                    TextFormField(
                      controller: _categoryIdController,
                      readOnly: true,
                      decoration: _inputDecoration(
                        label: 'Category ID',
                        icon: Icons.tag,
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: _inputDecoration(
                        label: 'Category Name *',
                        hint: 'e.g. Herbal Products',
                        icon: Icons.drive_file_rename_outline,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter category name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 4,
                      decoration: _inputDecoration(
                        label: 'Description *',
                        hint: 'Describe what products belong to this category',
                        icon: Icons.description_outlined,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle(
                      'Category Structure',
                      'Organize this category in your catalogue.',
                      Icons.account_tree_outlined,
                    ),
                    DropdownButtonFormField<String>(
                      value: _parentCategory,
                      decoration: _inputDecoration(
                        label: 'Parent Category',
                        icon: Icons.folder_outlined,
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'None',
                          child: Text('None — Main Category'),
                        ),
                        DropdownMenuItem(
                          value: 'Grocery',
                          child: Text('Grocery'),
                        ),
                        DropdownMenuItem(
                          value: 'Herbal',
                          child: Text('Herbal'),
                        ),
                        DropdownMenuItem(
                          value: 'Personal Care',
                          child: Text('Personal Care'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _parentCategory = value);
                        }
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _sortOrderController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration(
                        label: 'Sort Order',
                        hint: '1',
                        icon: Icons.sort,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter sort order';
                        }
                        if (int.tryParse(value.trim()) == null) {
                          return 'Enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle(
                      'Category Image / Icon',
                      'Choose an image or icon for the category.',
                      Icons.image_outlined,
                    ),
                    Container(
                      height: 130,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF0F6),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFE8D7DE),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 38,
                            color: Color(0xFFE91E63),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            'No image selected',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          OutlinedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Image picker can be connected here.',
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.upload_outlined),
                            label: const Text('Choose Image'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Recommended: square image, preferably 512 × 512 px.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle(
                      'Visibility & Status',
                      'Control where and how the category appears.',
                      Icons.visibility_outlined,
                    ),
                    DropdownButtonFormField<String>(
                      value: _status,
                      decoration: _inputDecoration(
                        label: 'Status',
                        icon: Icons.toggle_on_outlined,
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Active',
                          child: Text('Active'),
                        ),
                        DropdownMenuItem(
                          value: 'Paused',
                          child: Text('Paused'),
                        ),
                        DropdownMenuItem(
                          value: 'Inactive',
                          child: Text('Inactive'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _status = value);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    _switchTile(
                      title: 'Featured Category',
                      subtitle: 'Show this category in featured sections.',
                      value: _featured,
                      onChanged: (value) {
                        setState(() => _featured = value);
                      },
                    ),
                    _switchTile(
                      title: 'Show in Store Menu',
                      subtitle: 'Display this category in the customer menu.',
                      value: _showInMenu,
                      onChanged: (value) {
                        setState(() => _showInMenu = value);
                      },
                    ),
                  ],
                ),
              ),

              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle(
                      'SEO Settings',
                      'Optional information for search engines.',
                      Icons.search_outlined,
                    ),
                    TextFormField(
                      controller: _metaTitleController,
                      maxLength: 60,
                      decoration: _inputDecoration(
                        label: 'Meta Title',
                        hint: 'Category title for search engines',
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _metaDescriptionController,
                      maxLines: 3,
                      maxLength: 160,
                      decoration: _inputDecoration(
                        label: 'Meta Description',
                        hint: 'Short description for search results',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 2),
              SizedBox(
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _saveCategory,
                  icon: const Icon(Icons.save_outlined),
                  label: const Text(
                    'Save Category',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE91E63),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: const BorderSide(color: Color(0xFFD5C9CD)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
