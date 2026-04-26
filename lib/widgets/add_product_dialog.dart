import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/product_provider.dart';
import '../services/admin_api_service.dart';
import '../services/app_config.dart';

class AddProductDialog extends StatefulWidget {
  const AddProductDialog({super.key, this.product});

  final Product? product;

  static Future<void> show(BuildContext context, {Product? product}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AddProductDialog(product: product),
    );
  }

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _scientificNameController;
  late final TextEditingController _descController;
  late final TextEditingController _priceController;
  late final TextEditingController _oldPriceController;
  late final TextEditingController _stockController;
  late final TextEditingController _skuController;
  late final TextEditingController _imageUrlsController;
  late final TextEditingController _difficultyController;
  late final TextEditingController _lightRequirementController;
  late final TextEditingController _waterRequirementController;

  String _category = 'Indoor Plants';
  ProductStatus _status = ProductStatus.draft;
  bool _isIndoor = true;
  bool _isSaving = false;
  bool _isUploadingImage = false;

  bool get _isEditing => widget.product != null;

  // Modern Green Palette
  static const primaryGreen = Color(0xFF2D6A4F);
  static const secondaryGreen = Color(0xFF40916C);
  static const backgroundLight = Color(0xFFF8F9FA);
  static const textDark = Color(0xFF1A1A2E);

  @override
  void initState() {
    super.initState();
    final product = widget.product;
    _nameController = TextEditingController(text: product?.name ?? '');
    _scientificNameController = TextEditingController(
      text: product?.scientificName ?? '',
    );
    _descController = TextEditingController(text: product?.description ?? '');
    _priceController = TextEditingController(
      text: product != null ? product.price.toString() : '',
    );
    _oldPriceController = TextEditingController(
      text: product?.oldPrice?.toString() ?? '',
    );
    _stockController = TextEditingController(
      text: product != null ? product.stock.toString() : '0',
    );
    _skuController = TextEditingController(text: product?.sku ?? '');
    _imageUrlsController = TextEditingController(
      text: product?.imageUrls.join(', ') ?? '',
    );
    _difficultyController = TextEditingController(
      text: product?.difficulty ?? 'easy',
    );
    _lightRequirementController = TextEditingController(
      text: product?.lightRequirement ?? 'medium',
    );
    _waterRequirementController = TextEditingController(
      text: product?.waterRequirement ?? 'medium',
    );

    if (product != null) {
      _category = product.category;
      _status = product.status;
      _isIndoor = product.isIndoor;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _scientificNameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _oldPriceController.dispose();
    _stockController.dispose();
    _skuController.dispose();
    _imageUrlsController.dispose();
    _difficultyController.dispose();
    _lightRequirementController.dispose();
    _waterRequirementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: 1000,
          height: 850,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Right Column: Form Fields
                    Expanded(
                      flex: 3,
                      child: _buildFormContent(),
                    ),
                    // Left Column: Image Gallery & Status
                    Expanded(
                      flex: 2,
                      child: _buildSidePanel(),
                    ),
                  ],
                ),
              ),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      decoration: const BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Row(
        children: [
          Icon(
            _isEditing ? Icons.edit_note_rounded : Icons.add_business_rounded,
            color: Colors.white,
            size: 32,
          ),
          const SizedBox(width: 16),
          Text(
            _isEditing ? 'تعديل تفاصيل المنتج' : 'إضافة منتج جديد للمتجر',
            style: GoogleFonts.cairo(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close_rounded, color: Colors.white, size: 28),
            style: IconButton.styleFrom(
              hoverColor: Colors.white.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('المعلومات الأساسية', Icons.info_outline_rounded),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    _nameController,
                    'اسم النبتة الشائع',
                    Icons.eco_outlined,
                    required: true,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildTextField(
                    _scientificNameController,
                    'الاسم العلمي',
                    Icons.science_outlined,
                    required: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildTextField(
              _descController,
              'وصف المنتج',
              Icons.description_outlined,
              required: true,
              maxLines: 4,
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('التسعير والمخزون', Icons.inventory_2_outlined),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    _priceController,
                    'السعر الحالي',
                    Icons.payments_outlined,
                    required: true,
                    isNumber: true,
                    suffix: 'د.ع',
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildTextField(
                    _oldPriceController,
                    'السعر السابق (اختياري)',
                    Icons.money_off_rounded,
                    isNumber: true,
                    suffix: 'د.ع',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    _stockController,
                    'الكمية المتوفرة',
                    Icons.warehouse_outlined,
                    required: true,
                    isNumber: true,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildTextField(
                    _skuController,
                    'رمز المنتج (SKU)',
                    Icons.qr_code_scanner_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('متطلبات العناية', Icons.favorite_border_rounded),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    _waterRequirementController,
                    'احتياج الري',
                    Icons.water_drop_outlined,
                    required: true,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildTextField(
                    _lightRequirementController,
                    'احتياج الإضاءة',
                    Icons.wb_sunny_outlined,
                    required: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildTextField(
              _difficultyController,
              'مستوى صعوبة العناية',
              Icons.task_alt_rounded,
              required: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidePanel() {
    return Container(
      decoration: const BoxDecoration(
        color: backgroundLight,
        border: Border(right: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('تصنيف وحالة المنتج', Icons.category_outlined),
          const SizedBox(height: 20),
          _buildCategoryDropdown(),
          const SizedBox(height: 16),
          _buildStatusDropdown(),
          const SizedBox(height: 16),
          SwitchListTile(
            title: Text('نبات داخلي', style: GoogleFonts.cairo(fontWeight: FontWeight.w600)),
            subtitle: Text('حدد إذا كان النبات يعيش في الداخل', style: GoogleFonts.cairo(fontSize: 12)),
            value: _isIndoor,
            activeColor: primaryGreen,
            onChanged: (value) => setState(() => _isIndoor = value),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 32),
          _buildSectionTitle('صور المنتج', Icons.image_outlined),
          const SizedBox(height: 16),
          Expanded(child: _buildImageManager()),
        ],
      ),
    );
  }

  Widget _buildImageManager() {
    final imageUrls = _currentImageUrls;
    return Column(
      children: [
        InkWell(
          onTap: _isUploadingImage || _isSaving ? null : _pickAndUploadImages,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: primaryGreen.withOpacity(0.3), width: 2),
              borderRadius: BorderRadius.circular(16),
              color: primaryGreen.withOpacity(0.05),
            ),
            child: Column(
              children: [
                if (_isUploadingImage)
                  const CircularProgressIndicator(color: primaryGreen)
                else
                  const Icon(Icons.cloud_upload_outlined, color: primaryGreen, size: 40),
                const SizedBox(height: 12),
                Text(
                  _isUploadingImage ? 'جارٍ رفع الصور...' : 'رفع صور جديدة',
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    color: primaryGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: imageUrls.isEmpty
              ? Center(
                  child: Text(
                    'لا توجد صور مضافة',
                    style: GoogleFonts.cairo(color: Colors.grey),
                  ),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    final url = imageUrls[index];
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            AppConfig.resolveMediaUrl(url),
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.broken_image_outlined),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          left: 4,
                          child: GestureDetector(
                            onTap: () => _removeImage(url),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close, color: Colors.white, size: 14),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: _isSaving ? null : () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              side: BorderSide(color: Colors.grey[300]!),
            ),
            child: Text('إلغاء', style: GoogleFonts.cairo(color: Colors.grey[700])),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: _isSaving ? null : _saveProduct,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: _isSaving
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                  )
                : Text(
                    _isEditing ? 'تحديث البيانات' : 'إضافة المنتج',
                    style: GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: primaryGreen),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
    bool required = false,
    bool isNumber = false,
    String? suffix,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: isNumber ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
      style: GoogleFonts.cairo(fontSize: 15),
      validator: required
          ? (value) => (value == null || value.trim().isEmpty) ? 'هذا الحقل مطلوب' : null
          : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.cairo(color: Colors.grey[600], fontSize: 14),
        prefixIcon: Icon(icon, color: secondaryGreen, size: 20),
        suffixText: suffix,
        suffixStyle: GoogleFonts.cairo(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryGreen, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    const categories = [
      'Indoor Plants',
      'Succulents',
      'Flowering Plants',
      'Hanging Plants',
      'Climbing Plants',
    ];

    return DropdownButtonFormField<String>(
      value: _category,
      decoration: InputDecoration(
        labelText: 'التصنيف',
        labelStyle: GoogleFonts.cairo(fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
      items: categories
          .map((c) => DropdownMenuItem(value: c, child: Text(c, style: GoogleFonts.cairo())))
          .toList(),
      onChanged: (v) => setState(() => _category = v!),
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButtonFormField<ProductStatus>(
      value: _status,
      decoration: InputDecoration(
        labelText: 'حالة العرض',
        labelStyle: GoogleFonts.cairo(fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
      items: const [
        DropdownMenuItem(value: ProductStatus.published, child: Text('منشور')),
        DropdownMenuItem(value: ProductStatus.draft, child: Text('مسودة')),
        DropdownMenuItem(value: ProductStatus.archived, child: Text('مؤرشف')),
      ],
      onChanged: (v) => setState(() => _status = v!),
    );
  }

  List<String> get _currentImageUrls => _imageUrlsController.text
      .split(',')
      .map((item) => item.trim())
      .where((item) => item.isNotEmpty)
      .toList(growable: false);

  Future<void> _pickAndUploadImages() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;

    setState(() => _isUploadingImage = true);
    try {
      final uploadedPaths = <String>[];
      for (final file in result.files) {
        var bytes = file.bytes;
        if (bytes == null && file.path != null) {
          bytes = await File(file.path!).readAsBytes();
        }
        if (bytes == null) continue;

        final metadata = await AdminApiService.uploadProductImage(
          bytes: bytes,
          fileName: file.name,
        );
        uploadedPaths.add(metadata['url'] as String);
      }

      final merged = [..._currentImageUrls, ...uploadedPaths];
      _imageUrlsController.text = merged.join(', ');
      if (!mounted) return;
      setState(() {});
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل رفع الصور: $error', style: GoogleFonts.cairo())),
      );
    } finally {
      if (mounted) setState(() => _isUploadingImage = false);
    }
  }

  void _removeImage(String imageUrl) {
    final updated = _currentImageUrls.where((item) => item != imageUrl).toList();
    _imageUrlsController.text = updated.join(', ');
    setState(() {});
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    final provider = context.read<ProductProvider>();

    final product = (_isEditing ? widget.product! : _emptyProduct()).copyWith(
      name: _nameController.text.trim(),
      scientificName: _scientificNameController.text.trim(),
      description: _descController.text.trim(),
      price: double.tryParse(_priceController.text.trim()) ?? 0,
      oldPrice: _oldPriceController.text.trim().isEmpty
          ? null
          : double.tryParse(_oldPriceController.text.trim()),
      category: _category,
      imageUrls: _currentImageUrls,
      status: _status,
      stock: int.tryParse(_stockController.text.trim()) ?? 0,
      sku: _skuController.text.trim().isEmpty ? null : _skuController.text.trim(),
      isIndoor: _isIndoor,
      difficulty: _difficultyController.text.trim(),
      lightRequirement: _lightRequirementController.text.trim(),
      waterRequirement: _waterRequirementController.text.trim(),
      updatedAt: DateTime.now(),
    );

    try {
      if (_isEditing) {
        await provider.updateProduct(product.id, product);
      } else {
        await provider.addProduct(product);
      }

      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isEditing ? 'تم تحديث المنتج بنجاح' : 'تمت إضافة المنتج بنجاح', style: GoogleFonts.cairo()),
          backgroundColor: primaryGreen,
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل حفظ المنتج: $error', style: GoogleFonts.cairo()), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Product _emptyProduct() {
    return Product(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: '',
      scientificName: '',
      description: '',
      price: 0,
      category: _category,
      imageUrls: const [],
      status: _status,
      stock: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isIndoor: true,
      difficulty: 'easy',
      lightRequirement: 'medium',
      waterRequirement: 'medium',
    );
  }
}
