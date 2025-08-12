import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_app/models/menu.dart';
import 'package:recipe_app/utils/app_assets.dart';
import 'package:recipe_app/utils/app_colors.dart';
import 'package:recipe_app/utils/app_constans.dart';
import 'package:recipe_app/utils/app_typography.dart';
import 'package:recipe_app/utils/size_helper.dart';
import 'package:recipe_app/widgets/app_textfield.dart';
import 'package:recipe_app/widgets/recipe_card_item.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment>
    with SingleTickerProviderStateMixin {
  int _indexCategory = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Gap(SizeHelper.fromFigmaHeight(16, context)),
                  _buildHeader(),
                  Gap(SizeHelper.fromFigmaHeight(24, context)),
                  _buildCategory(context),
                  Gap(SizeHelper.fromFigmaHeight(24, context)),
                  Container(height: 8, color: AppColors.form),
                  Gap(SizeHelper.fromFigmaHeight(24, context)),
                ],
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(_buildTabBar()),
              pinned: true,
            ),
          ];
        },
        body: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.outline, width: 1)),
          ),
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTabContentLeft(),
              const Center(child: Text('Right Tab Content')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: AppTextField(
        hintText: 'Search',
        prefixIcon: AppIcons.search,
        type: TextFieldType.search,
      ),
    );
  }

  Widget _buildCategory(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text('Category', style: AppTypography.h2(context)),
        ),
        const Gap(16),
        SizedBox(
          height: 48,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            physics: const BouncingScrollPhysics(),
            itemCount: AppConstants.categories.length,
            itemBuilder: (context, index) {
              final item = AppConstants.categories[index];
              final isActive = _indexCategory == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _indexCategory = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(
                    right: index == AppConstants.categories.length - 1 ? 0 : 16,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 24,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: isActive ? AppColors.primary : AppColors.form,
                  ),
                  child: Center(
                    child: Text(
                      item,
                      style: AppTypography.small(context).copyWith(
                        color: isActive
                            ? Colors.white
                            : AppColors.secondaryText,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: AppColors.primary,
      indicatorWeight: 3,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      unselectedLabelColor: AppColors.secondaryText,
      labelPadding: const EdgeInsets.only(bottom: 16),
      labelStyle: AppTypography.h3(
        context,
      ).copyWith(fontWeight: FontWeight.w500),
      unselectedLabelStyle: AppTypography.h3(
        context,
      ).copyWith(fontWeight: FontWeight.w500),
      tabs: const [
        Tab(text: 'Left'),
        Tab(text: 'Right'),
      ],
    );
  }

  GridView _buildTabContentLeft() {
    return GridView.builder(
      itemCount: menuLeft.length,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 156 / 235,
      ),
      itemBuilder: (context, index) {
        final menu = menuLeft[index];

        return RecipeCardItem(menu: menu);
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
