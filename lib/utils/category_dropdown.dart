import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../contoller/homeController/get_category_data.dart';
import '../contoller/homeController/home_controller.dart';

class CategoryDropdown extends StatefulWidget {
  final String text;
  final String? text2;
  final Function(Data?)? onCategorySelected;

  const CategoryDropdown({
    super.key,
    required this.text,
    this.text2,
    this.onCategorySelected,
  });

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  late HomeController homeController;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
    
    // Get the HomeController instance
    try {
      homeController = Get.find<HomeController>();
    } catch (e) {
      Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
      homeController = Get.find<HomeController>();
    }
    
    // Set initial value if category is already selected
    if (homeController.selectedCategory.value != null) {
      _controller.text = homeController.selectedCategory.value!.name ?? '';
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _showCategoryOptions() async {
    if (!mounted) return;
    
    if (homeController.isLoadingCategories.value) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Categories are still loading...')),
        );
      }
      return;
    }
    
    if (homeController.categories.isEmpty) {
      // Try to refresh categories
      await homeController.refreshCategories();
      
      if (!mounted) return;
      
      if (homeController.categories.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No categories available. Please try again later.'),
              action: SnackBarAction(
                label: 'Retry',
                onPressed: () {
                  homeController.refreshCategories();
                },
              ),
            ),
          );
        }
        return;
      }
    }

    if (!mounted) return;
    
    final selected = await showModalBottomSheet<Data>(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Select Category',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: homeController.categories.length,
                  itemBuilder: (context, index) {
                    final category = homeController.categories[index];
                    return ListTile(
                      leading: category.icon != null && category.icon!.isNotEmpty
                          ? Image.network(
                              category.icon!,
                              width: 30,
                              height: 30,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.category, size: 30);
                              },
                            )
                          : Icon(Icons.category, size: 30),
                      title: Text(category.name ?? ''),
                      onTap: () {
                        Navigator.pop(context, category);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    if (selected != null && mounted) {
      setState(() {
        _controller.text = selected.name ?? '';
      });
      
      // Update the controller
      homeController.setSelectedCategory(selected);
      
      // Call the callback if provided
      if (widget.onCategorySelected != null) {
        widget.onCategorySelected!(selected);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Focus(
        onFocusChange: (hasFocus) {
          setState(() {});
        },
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          readOnly: true,
          onTap: _showCategoryOptions,
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            labelText: widget.text,
            hintText: homeController.isLoadingCategories.value 
                ? 'Loading categories...' 
                : homeController.categories.isEmpty
                    ? 'Tap to load categories'
                    : (widget.text2 ?? 'Select a category'),
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(.3),
              fontSize: 12,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(
              color: _focusNode.hasFocus ? AppColors.primaryColor : const Color(0xFF6F6F6F),
            ),
            suffixIcon: homeController.isLoadingCategories.value
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                    ),
                  )
                : const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFF6F6F6F),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
          ),
        ),
      );
    });
  }
}
