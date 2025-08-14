// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// class DropdownSection {
//   final String title;
//   final List<String> items;
//   DropdownSection({required this.title, required this.items});
// }
//
// class CustomDropdownSearch extends StatefulWidget {
//   final List<String>? items;
//   final List<DropdownSection>? sections;
//   final String hint;
//   final Function(String value, int index)? onItemSelect;
//   final Function(String value, int sectionIndex, int itemIndex)?
//   onSectionItemSelect;
//   final bool fixMinWidthWithParent;
//   final bool fixMaxWidthWithParent;
//   final double itemPopupMaxHeight;
//   final int? initialSelectedIndex;
//   final int? initialSelectedSectionIndex;
//   final int? initialSelectedSectionItemIndex;
//   final Widget? prefixWidget;
//   final Widget? suffixWidget;
//   const CustomDropdownSearch._(
//       {super.key,
//         this.items,
//         this.sections,
//         required this.hint,
//         this.onItemSelect,
//         this.onSectionItemSelect,
//         this.fixMinWidthWithParent = true,
//         this.fixMaxWidthWithParent = true,
//         this.initialSelectedIndex,
//         this.itemPopupMaxHeight = 256,
//         this.initialSelectedSectionIndex,
//         this.initialSelectedSectionItemIndex,
//         this.prefixWidget,
//         this.suffixWidget});
//
//   factory CustomDropdownSearch({
//     Key? key,
//     required List<String> items,
//     required String hint,
//     required Function(String value, int index) onItemSelect,
//     Widget? prefixWidget,
//     Widget? suffixWidget,
//     bool fixMinWidthWithParent = true,
//     bool fixMaxWidthWithParent = true,
//     double itemPopupMaxHeight = 256,
//     int initialSelectedIndex = -1,
//   }) {
//     return CustomDropdownSearch._(
//       key: key,
//       items: items,
//       hint: hint,
//       onItemSelect: onItemSelect,
//       prefixWidget: prefixWidget,
//       suffixWidget: suffixWidget,
//       fixMinWidthWithParent: fixMinWidthWithParent,
//       fixMaxWidthWithParent: fixMaxWidthWithParent,
//       itemPopupMaxHeight: itemPopupMaxHeight,
//       initialSelectedIndex: initialSelectedIndex,
//     );
//   }
//
//   factory CustomDropdownSearch.sections({
//     Key? key,
//     required List<DropdownSection> sections,
//     required String hint,
//     required Function(String value, int sectionIndex, int itemIndex)
//     onSectionItemSelect,
//     bool fixMinWidthWithParent = true,
//     bool fixMaxWidthWithParent = true,
//     double itemPopupMaxHeight = 256,
//     int? initialSelectedSectionIndex,
//     int? initialSelectedSectionItemIndex,
//   }) {
//     return CustomDropdownSearch._(
//       key: key,
//       sections: sections,
//       hint: hint,
//       onSectionItemSelect: onSectionItemSelect,
//       fixMinWidthWithParent: fixMinWidthWithParent,
//       fixMaxWidthWithParent: fixMaxWidthWithParent,
//       itemPopupMaxHeight: itemPopupMaxHeight,
//       initialSelectedSectionIndex: initialSelectedSectionIndex,
//       initialSelectedSectionItemIndex: initialSelectedSectionItemIndex,
//     );
//   }
//
//   @override
//   State<CustomDropdownSearch> createState() => _CustomDropdownSearchState();
// }
//
// class _CustomDropdownSearchState extends State<CustomDropdownSearch> {
//   final GlobalKey _dropDownKey = GlobalKey();
//
//   final ValueNotifier<String?> _title = ValueNotifier(null);
//   final ValueNotifier<String> _searchQuery = ValueNotifier<String>('');
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         key: _dropDownKey,
//         onTap: () {
//           _searchQuery.value = '';
//
//           /// 32 is the height of the section title, 32 is the height of the item if widget.items is not null but 52 is the height for search view
//           // Calculate the total height of the popup for the items
//           double totalHeight = (((widget.items?.length ?? 0) * 32) + 52);
//
//           // Calculate the total height of the popup for the sections
//           if (widget.sections != null) {
//             for (int i = 0; i < widget.sections!.length; i++) {
//               totalHeight += 32 + (widget.sections![i].items.length * 32);
//             }
//           }
//
//           double contentMaxHeight = totalHeight > widget.itemPopupMaxHeight
//               ? widget.itemPopupMaxHeight
//               : totalHeight;
//           showCustomPositionedDialog(
//               context,
//               _dropDownKey,
//               showFromBorder: false,
//               fixMinWidthWithParent: widget.fixMinWidthWithParent,
//               fixMaxWidthWithParent: widget.fixMaxWidthWithParent,
//               contentMaxHeight: contentMaxHeight,
//               Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.shade200,
//                         spreadRadius: 1,
//                         blurRadius: 10,
//                         offset: const Offset(0, 1),
//                       ),
//                       BoxShadow(
//                         color: Colors.grey.shade200,
//                         spreadRadius: 1,
//                         blurRadius: 10,
//                         offset: const Offset(4, 4),
//                       ),
//                       BoxShadow(
//                         color: Colors.grey.shade200,
//                         spreadRadius: 1,
//                         blurRadius: 10,
//                         offset: const Offset(-2, 4),
//                       ),
//                     ],
//                     color: Colors.white),
//                 height: contentMaxHeight,
//                 width: 50,
//                 child: Column(
//                   // crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
//                       child: TextFieldDefault(
//                         validator: (text) => null,
//                         hint: "Search",
//                         prefixIcon: const Padding(
//                           padding: EdgeInsets.only(left: 8),
//                           child: Icon(Icons.search),
//                         ),
//                         onChange: (text) {
//                           _searchQuery.value = text;
//                         },
//                       ),
//                     ),
//                     Flexible(
//                       child: ValueListenableBuilder(
//                           valueListenable: _searchQuery,
//                           builder: (context, value, __) {
//                             final List<String> filteredItems = value.isEmpty
//                                 ? (widget.items ?? [])
//                                 : (widget.items ?? [])
//                                 .where((item) => item
//                                 .toLowerCase()
//                                 .contains(value.toLowerCase()))
//                                 .toList();
//
//                             final List<DropdownSection> filteredSections =
//                             (widget.sections ?? [])
//                                 .map((section) => DropdownSection(
//                                 title: section.title,
//                                 items: section.items
//                                     .where((item) => item
//                                     .toLowerCase()
//                                     .contains(value.toLowerCase()))
//                                     .toList()))
//                                 .toList()
//                               ..removeWhere(
//                                       (section) => section.items.isEmpty);
//
//                             if (filteredItems.isEmpty &&
//                                 filteredSections.isEmpty) {
//                               return const Center(
//                                   child: Text("No items found"));
//                             } else if (filteredItems.isNotEmpty) {
//
//                               return ListView.builder(
//                                   itemCount: filteredItems.length,
//                                   shrinkWrap: true,
//                                   itemBuilder: (context, index) {
//                                     return Material(
//                                       color: Colors.transparent,
//                                       child: InkWell(
//                                         splashColor: AppColorsOld.primaryColor
//                                             .withOpacity(0.3),
//                                         onTap: () {
//                                           context.pop();
//                                           _title.value = filteredItems[index];
//                                           if (widget.onItemSelect != null) {
//                                             widget.onItemSelect!(
//                                                 filteredItems[index], index);
//                                           }
//                                         },
//                                         child: Padding(
//                                           padding: const EdgeInsets.fromLTRB(
//                                               12, 7, 12, 7),
//                                           child: Text(
//                                             filteredItems[index],
//                                             style:
//                                             TextStyles.textStyleBodySmall,
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   });
//                             } else {
//                               return ListView.builder(
//                                   itemCount: filteredSections.length,
//                                   shrinkWrap: true,
//                                   itemBuilder: (context, index) {
//                                     return Material(
//                                       color: Colors.transparent,
//                                       child: Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.fromLTRB(
//                                                 12, 12, 12, 4),
//                                             child: Text(
//                                                 filteredSections[index].title,
//                                                 style:
//                                                 AppTextStyles.subheading),
//                                           ),
//                                           ...List.generate(
//                                               filteredSections[index]
//                                                   .items
//                                                   .length, (i) {
//                                             bool isSelected = (widget
//                                                 .initialSelectedSectionIndex !=
//                                                 null &&
//                                                 widget.initialSelectedSectionIndex ==
//                                                     index &&
//                                                 widget.initialSelectedSectionItemIndex !=
//                                                     null &&
//                                                 widget.initialSelectedSectionItemIndex ==
//                                                     i);
//
//                                             return Container(
//                                               width: double.infinity,
//                                               margin: const EdgeInsets.fromLTRB(
//                                                   8, 0, 8, 0),
//                                               decoration: BoxDecoration(
//                                                 color: isSelected
//                                                     ? AppColorsOld.primaryColor
//                                                     : Colors.transparent,
//                                                 borderRadius:
//                                                 BorderRadius.circular(4),
//                                               ),
//                                               child: InkWell(
//                                                 borderRadius:
//                                                 BorderRadius.circular(4),
//                                                 splashColor: AppColorsOld
//                                                     .primaryColor
//                                                     .withOpacity(0.3),
//                                                 onTap: () {
//                                                   context.pop();
//                                                   _title.value =
//                                                   filteredSections[index]
//                                                       .items[i];
//                                                   if (widget
//                                                       .onSectionItemSelect !=
//                                                       null) {
//                                                     widget.onSectionItemSelect!(
//                                                         filteredSections[index]
//                                                             .items[i],
//                                                         index,
//                                                         i);
//                                                   }
//                                                 },
//                                                 child: Padding(
//                                                   padding:
//                                                   const EdgeInsets.fromLTRB(
//                                                       12, 7, 12, 7),
//                                                   child: Text(
//                                                     filteredSections[index]
//                                                         .items[i],
//                                                     style: isSelected
//                                                         ? AppTextStyles
//                                                         .subheading
//                                                         .copyWith(
//                                                         color: Colors
//                                                             .white)
//                                                         : TextStyles
//                                                         .textStyleBodySmall,
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           }),
//                                         ],
//                                       ),
//                                     );
//                                   });
//                             }
//                           }),
//                     ),
//                   ],
//                 ),
//               ));
//         },
//         child: ValueListenableBuilder(
//             valueListenable: _title,
//             builder: (context, value, __) {
//               return UIHelpers.defaultContainer(
//                 showPrefix: widget.prefixWidget != null,
//                 prefixWidget: widget.prefixWidget,
//                 suffixWidget:  widget.suffixWidget,
//                 title: value ??
//                     (widget.initialSelectedIndex != -1
//                         ? (widget.items ?? [])[widget.initialSelectedIndex!]
//                         : null),
//                 widget.hint,
//               );
//             }));
//   }
// }