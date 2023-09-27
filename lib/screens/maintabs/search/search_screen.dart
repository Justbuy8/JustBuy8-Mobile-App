import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/categories/filter_categories/filter_categories_bloc.dart';
import 'package:justbuyeight/blocs/rating/rating_filter_bloc.dart';
import 'package:justbuyeight/blocs/search/search_products_bloc.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_config.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/product_widget.dart';
import 'package:justbuyeight/widgets/components/appbars/secondary_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/border_text_button.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:velocity_x/velocity_x.dart';

// Some global variables that we will be needing in this page.
String? selectedMethod;
String? selectedCategory;
RangeValues _currentRangeValues = const RangeValues(1, 1000);
int? minRange, maxRange;
String? selectedRating;
int _selectedButtonIndex = 0;
final Map<String, bool> ratingMap = {};
bool isInitialRating = false;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // blocs used in the search screen
  var filterCategoriesBloc = FilterCategoriesBloc();
  var searchProductsBloc = SearchProductsBloc();

  // Pagination variables that will help the search screen to load products after scrolling
  int currentPage = AppConfig.PageOne;
  int paginatedCount =
      AppConfig.GetSearchedAndFilteredProductsByShopPagenateCount;
  ScrollController scrollController = ScrollController();

  // List for storing searched products
  List<ProductModel> searchedProducts = [];
  final List<String> searchTypes = [
    AppText.saleText,
    AppText.trendingText,
    AppText.newText,
  ];

  // Flag for showing no products searched yet
  bool noProductsSearched = true;

  // Text editing controllers
  final TextEditingController searchController = TextEditingController();

  final Map<String, bool> categoryMap = {};

  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();

    /// First we will grab out all the categories we have.
    filterCategoriesBloc = filterCategoriesBloc
      ..add(
        FilterCategoriesLoadingEvent(
          page: AppConfig.PageOne.toString(),
          paginateBy: AppConfig.HomeBestNewArrivalPagenateCount.toString(),
          random: true,
        ),
      );

    /// Listening for the scroll events so we can load the data using scrolling
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent -
              scrollController.position.pixels <=
          AppConfig.LoadOnScrollHeight) {
        currentPage++;
        getMoreData();
      }
    });

    isSelected = List.generate(searchTypes.length, (index) => false);
    // make all the categories false and first category true
    categoryMap.updateAll((key, value) => false);
    categoryMap['All'] = true;
  }

  getInitialData() {
    ///@The initial data that will be displayed on the screen after we search or filer.
    searchProductsBloc = searchProductsBloc
      ..add(
        SearchProductsOnSearchEvent(
          page: currentPage.toString(),
          paginatedBy: paginatedCount.toString(),
          searchQuery: searchController.text,
          method: selectedMethod,
          category: selectedCategory,
          startingPrice: minRange,
          endingPrice: maxRange,
          totalRatings: selectedRating,
        ),
      );
  }

  getMoreData() {
    /// The loaded data that will appear after we scroll.
    searchProductsBloc = searchProductsBloc
      ..add(
        SearchedProductsMoreDataEvent(
          page: currentPage.toString(),
          paginatedBy: paginatedCount.toString(),
          searchQuery: searchController.text,
          method: selectedMethod,
          category: selectedCategory,
          startingPrice: minRange,
          endingPrice: maxRange,
          totalRatings: selectedRating,
        ),
      );
  }

  clearFilter() {
    /// Clearing the filter.
    /// Clearing filter means that we will list all the products we searced
    /// for the very first time..

    // For that first we will reinitialize the blocs
    filterCategoriesBloc = FilterCategoriesBloc();
    searchProductsBloc = SearchProductsBloc();

    // then we will restore pagination
    currentPage = AppConfig.PageOne;
    paginatedCount =
        AppConfig.GetSearchedAndFilteredProductsByShopPagenateCount;

    // and then all the filtration parameterss
    selectedMethod = null;
    selectedCategory = null;
    minRange = null;
    maxRange = null;
    selectedRating = null;
    _selectedButtonIndex = 0;
    categoryMap.updateAll((key, value) => false);
    categoryMap['All'] = true;
    _currentRangeValues = const RangeValues(1, 1000);

    // at the last we will grab the initial searched data.
    getInitialData();
    context.pop();
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
                        // clear button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Clear",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: AppColors.primaryColor),
                            ),
                            IconButton(
                              onPressed: clearFilter,
                              icon: Icon(
                                Icons.clear,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // search bar
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
                        SliderWidget(),
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
                  getInitialData();
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
        controller: scrollController,
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
                          getInitialData();
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
                      ? Container(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                LottieAssets.emptyproducts,
                                repeat: false,
                                height: 300.h,
                                width: 300.w,
                              ),
                              Text(
                                AppText.noProductsSearchedYetText,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) => ProductWidget(
                                  product: searchedProducts[index]),
                              itemCount: searchedProducts.length,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              // controller: scrollController,
                            ),
                            10.height,
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppCircularSpinner(),
                                    10.width,
                                    Text(AppText.loadingMoreProducts),
                                  ],
                                ),
                              ],
                            ).visible(state is SearchProductsLoadingMoreState),
                            60.height,
                          ],
                        );
              },
              listener: (context, state) {
                if (state is SearchProductsDataState) {
                  noProductsSearched = false;
                  searchedProducts.addAll(state.products);
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
                  selectedMethod = widget.searchTypes[index];
                  print(selectedMethod);
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

                      // make the selected category true
                      widget.categoryMap[state.filterCategories[index].catName
                          .toString()] = true;

                      // assign the selected category to the global variable
                      selectedCategory =
                          state.filterCategories[index].catName.toString();
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

class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key}) : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: _currentRangeValues,
      onChanged: (RangeValues values) {
        setState(() {
          _currentRangeValues = values;
        });
      },
      min: 1,
      max: 1000,
      divisions: 1000,
      labels: RangeLabels(
        "\$${_currentRangeValues.start.round()}",
        "\$${_currentRangeValues.end.round()}",
      ),
    );
  }
}

class RatingFilterWidget extends StatefulWidget {
  const RatingFilterWidget({Key? key}) : super(key: key);

  @override
  State<RatingFilterWidget> createState() => _RatingFilterWidgetState();
}

class _RatingFilterWidgetState extends State<RatingFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RatingFilterBloc()..add(RatingFilterLoadingEvent()),
      child: BlocConsumer<RatingFilterBloc, RatingFilterState>(
        listener: (context, state) {
          if (state is RatingFilterDataState) {
            if (!isInitialRating) {
              isInitialRating = true;
              ratingMap.addEntries(
                state.ratings.map(
                  (e) => MapEntry(e, false),
                ),
              );
              ratingMap['All'] = true;
            }
          }
        },
        builder: (bloccontext, state) {
          if (state is RatingFilterDataState) {
            return SizedBox(
              height: 40.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.ratings.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        ratingMap.updateAll((key, value) => false);
                        ratingMap.update(
                          state.ratings[index].toString(),
                          (value) => true,
                        );
                        selectedRating = state.ratings[index];
                        print(selectedRating);
                      });
                    },
                    child: Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1,
                        ),
                        color: ratingMap[state.ratings[index]] == true
                            ? AppColors.primaryColor
                            : AppColors.transparentColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: ratingMap[state.ratings[index]] == true
                                  ? AppColors.appWhiteColor
                                  : AppColors.primaryColor,
                              size: 14.sp,
                            ),
                            const SizedBox(width: 5),
                            AutoSizeText(
                              state.ratings[index].toString(),
                              style: TextStyle(
                                color: ratingMap[state.ratings[index]] == true
                                    ? AppColors.appWhiteColor
                                    : AppColors.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              maxFontSize: 14.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const AppCircularSpinner();
        },
      ),
    );
  }
}
