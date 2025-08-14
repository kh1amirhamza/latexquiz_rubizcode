import 'package:flutter/material.dart';
import 'package:latexquiz_rubizcode/core/common/widgets/appbar_default.dart';

class ScaffoldDefault extends StatelessWidget {
  final GlobalKey? scaffoldKey;
  final AppBarDefault? appBar;
  final FloatingActionButton? floatingActionButton;
  final List<Widget> slivers;
  final Widget? body;
  final EdgeInsets padding;
  final bool resizeToAvoidBottomInset;
  final Widget? endDrawer;
  final Function()? onRefresh;
  final ScrollController? controller;
  final Widget? bottomNavBar;

  const ScaffoldDefault({
    super.key,
    this.scaffoldKey,
    this.appBar,
    this.floatingActionButton,
    this.slivers = const [],
    this.body,
    this.padding = const EdgeInsets.fromLTRB(16, 0, 16, 0),
    this.resizeToAvoidBottomInset = true,
    this.endDrawer,
    this.onRefresh,
    this.controller,
    this.bottomNavBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar,

      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      endDrawer: endDrawer,
      bottomNavigationBar: bottomNavBar,
      body: RefreshIndicator(
        onRefresh: () {
          onRefresh?.call();
          return Future<void>.delayed(const Duration(milliseconds: 1500));
        },
        child: Padding(
          padding: padding,
          child: CustomScrollView(
            controller: controller,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              if (body != null) SliverFillRemaining(child: body),
              ...slivers,
            ],
          ),
        ),
      ),
    );
  }
}
