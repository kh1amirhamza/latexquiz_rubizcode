import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:latexquiz_rubizcode/core/constants/app_colors.dart';
import 'package:latexquiz_rubizcode/core/constants/app_text_styles.dart';


class DropdownDefault extends HookWidget {
  final Function(int index) onItemSelect;
  final List<String> items;
  final int? selectedIndex;
  final String? hint;
  final bool enabled;
  const DropdownDefault({
    super.key,
    required this.items,
    required this.onItemSelect,
    this.selectedIndex,
    this.hint,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isOpen = useState(false);
    return DropdownButtonHideUnderline(
      child: PopupMenuButton<String>(
        enabled: enabled,
        onOpened: () {
          isOpen.value = true;
        },
        onCanceled: () {
          isOpen.value = false;
        },
        //elevation: 0,
        position: PopupMenuPosition.under,
        shadowColor: Colors.white,
        padding: EdgeInsets.zero,
        menuPadding: EdgeInsets.zero,
        onSelected: (String item) {},
        constraints: BoxConstraints(
          minWidth: 0,
          maxWidth: MediaQuery.sizeOf(context).width - 32,
        ),
        itemBuilder:
            (BuildContext context) => <PopupMenuEntry<String>>[
              // if (onSearch != null)
              //   PopupMenuItem<String>(
              //
              //     onTap: () {},
              //     child: Container(child: TextField()),
              //   ),
              ...List.generate(items.length, (index) {
                return PopupMenuItem<String>(
                  padding: EdgeInsets.zero,
                  // value: items[index],
                  onTap: () {
                    onItemSelect(index);
                  },
                  child: Container(
                    //height: 24,
                    width: double.maxFinite,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    decoration: BoxDecoration(
                      border:
                          index == items.length - 1
                              ? null
                              : Border(
                                bottom: BorderSide(
                                  color: AppColors.border,
                                  width: 0.5,
                                ),
                              ),
                    ),
                    child: Text(
                      items[index],
                      style: AppTextStyles.infoLargeTSBlack900.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              }),
            ],

        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  selectedIndex != null
                      ? items[selectedIndex!]
                      : hint ?? 'Choose item',
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  style: AppTextStyles.infoTSBlack400.copyWith(color: AppColors.blackSecondary900),
                ),
              ),
              Icon(
                isOpen.value
                    ? Icons.keyboard_arrow_up_sharp
                    : Icons.keyboard_arrow_down_sharp,
                color: AppColors.blackSecondary400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
