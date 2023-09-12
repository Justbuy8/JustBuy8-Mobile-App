import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/categories/filter_categories/filter_categories_bloc.dart';
import 'package:justbuyeight/blocs/search/search_products_bloc.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_config.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/product_widget.dart';
import 'package:justbuyeight/screens/maintabs/search/widgets/rating_filter_widget.dart';
import 'package:justbuyeight/widgets/components/appbars/secondary_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/border_text_button.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:velocity_x/velocity_x.dart';

// Some global variables
String selectedToggle = AppText.saleText;
String? selectedCategory;
String? selectedPriceRange;
String? selectedRating;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // blocs
  var filterCategoriesBloc = FilterCategoriesBloc();
  var searchProductsBloc = SearchProductsBloc();

  // List for storing searched products
  List<ProductModel> searchedProducts = [];

  // Flag for showing no products searched yet
  bool noProductsSearched = true;

  final TextEditingController searchController = TextEditingController();
  final List<String> searchTypes = [
    AppText.saleText,
    AppText.trendingText,
    AppText.newText,
  ];

  String? selectedCategory;
  final Map<String, bool> categoryMap = {};

  RangeValues _currentRangeValues = const RangeValues(1, 200);

  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    filterCategoriesBloc = filterCategoriesBloc
      ..add(
        FilterCategoriesLoadingEvent(
          page: AppConfig.PageOne.toString(),
          paginateBy: AppConfig.HomeBestNewArrivalPagenateCount.toString(),
          random: true,
        ),
      );
    isSelected = List.generate(searchTypes.length, (index) => false);
  }

  void filterBottomSheet(BuildContext context) {
    /*
    Bottom sheet that will be shown when the user clicks on the filter icon
    and will contain the filter options, such as categories, price range, rating, etc.
    Based on the user's selection, the products will be filtered.
    */
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height / 1.2,
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ToggleButtonsWidget(searchTypes: searchTypes),
                        const SizedBox(height: 20),
                        Text(
                          AppText.categoriesText,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 20),

                        // Categories
                        CategoriesWidget(
                          filterCategoriesBloc: filterCategoriesBloc,
                          categoryMap: categoryMap,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          AppText.priceText,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        RangeSlider(
                          values: _currentRangeValues,
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentRangeValues = values;
                            });
                          },
                          min: 1,
                          max: 200,
                          divisions: 200,
                          labels: RangeLabels(
                            "€${_currentRangeValues.start.round()}",
                            "€${_currentRangeValues.end.round()}",
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          AppText.ratingText,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 20),
                        const RatingFilterWidget(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ),
              PrimaryButtonWidget(
                caption: AppText.filterText,
                onPressed: () {
                  // TODO: Close modal and apply filters
                  context.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondaryAppbarWidget(
        title: AppText.searchText,
        leadingIcon: Ionicons.settings_outline,
        trailingIcon: Ionicons.notifications_outline,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 55.h,
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextFieldWidget(
                      controller: searchController,
                      onEditingComplete: () {
                        setState(() {
                          hideKeyboard(context);
                          // fire event to search for products
                          searchProductsBloc.add(
                            SearchProductsOnSearchEvent(
                              searchQuery: searchController.text,
                            ),
                          );
                        });
                      },
                      label: 'Search Here',
                    ),
                  ),
                  10.widthBox,
                  GestureDetector(
                    onTap: () {
                      filterBottomSheet(context);
                    },
                    child: Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: AppColors.primaryColor),
                      child: Icon(
                        Ionicons.options_outline,
                        color: AppColors.appWhiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            20.height,
            // Search Results
            BlocConsumer<SearchProductsBloc, SearchProductsState>(
              bloc: searchProductsBloc,
              builder: (context, state) {
                if (state is SearchProductsLoadingState) {
                  return Center(child: AppCircularSpinner());
                } else if (state is SearchProductsEmptyState) {
                  return Center(child: Text("No products found"));
                } else if (state is SearchProductsErrorState) {
                  return Center(child: Text(state.error));
                } else
                  return noProductsSearched == true
                      ? Center(
                          child: Text("Search for products"),
                        )
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) =>
                              ProductWidget(product: searchedProducts[index]),
                          itemCount: searchedProducts.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        );
              },
              listener: (context, state) {
                if (state is SearchProductsDataState) {
                  noProductsSearched = false;
                  searchedProducts = state.products;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ToggleButtonsWidget extends StatefulWidget {
  final List<String> searchTypes;
  const ToggleButtonsWidget({Key? key, required this.searchTypes})
      : super(key: key);

  @override
  State<ToggleButtonsWidget> createState() => _ToggleButtonsWidgetState();
}

class _ToggleButtonsWidgetState extends State<ToggleButtonsWidget> {
  int _selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondaryColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: List.generate(
          widget.searchTypes.length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedButtonIndex = index;
                  selectedToggle = widget.searchTypes[index];
                  print(selectedToggle);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedButtonIndex == index
                      ? AppColors.primaryColor
                      : AppColors.transparentColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Center(
                  child: Text(
                    widget.searchTypes[index],
                    style: TextStyle(
                      color: _selectedButtonIndex == index
                          ? AppColors.appWhiteColor
                          : AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoriesWidget extends StatefulWidget {
  final FilterCategoriesBloc filterCategoriesBloc;
  final Map<String, bool> categoryMap;
  CategoriesWidget(
      {Key? key, required this.filterCategoriesBloc, required this.categoryMap})
      : super(key: key);

  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  void initState() {
    // make all the categories false and first category true
    widget.categoryMap.updateAll((key, value) => false);
    widget.categoryMap['All'] = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterCategoriesBloc, FilterCategoriesState>(
      bloc: widget.filterCategoriesBloc,
      listener: (context, state) {
        if (state is FilterCategoriesDataState) {
          widget.categoryMap.addEntries(
            state.filterCategories.map(
              (e) => MapEntry(e.catName.toString(), false),
            ),
          );
          widget.categoryMap['All'] = true;
        }
      },
      builder: (ctx, state) {
        if (state is FilterCategoriesDataState) {
          return SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.filterCategories.length,
              itemBuilder: (context, index) {
                return BorderTextButton(
                  text: state.filterCategories[index].catName.toString(),
                  onPressed: () {
                    setState(() {
                      // make all the categories false
                      widget.categoryMap.updateAll(
                        (key, value) => false,
                      );

                      // make map true for this category and false for others
                      widget.categoryMap.updateAll(
                        (key, value) =>
                            key ==
                            state.filterCategories[index].catName.toString(),
                      );

                      // assign the selected category to the global variable
                      selectedCategory =
                          state.filterCategories[index].catName.toString();

                      // make the selected category true
                      widget.categoryMap[state.filterCategories[index].catName
                          .toString()] = true;
                      print(selectedCategory);
                    });
                    setState(() {});
                  },
                  isClicked:
                      widget.categoryMap[state.filterCategories[index].catName],
                );
              },
            ),
          );
        }
        return Shimmer(
          child: SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 40.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: AppColors.appGreyColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
