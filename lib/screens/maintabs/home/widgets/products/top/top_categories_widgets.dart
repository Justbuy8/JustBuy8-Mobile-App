import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/blocs/categories/top_catogeries/top_categories_model.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:nb_utils/nb_utils.dart';

class TopCategoriesWidget extends StatelessWidget {
  const TopCategoriesWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TopCategoriesBloc>(
      create: (context) =>
          TopCategoriesBloc()..add(TopCategoriesLoadingEvent()),
      child: BlocBuilder<TopCategoriesBloc, TopCategoriesState>(
        builder: (context, state) {
          if (state is TopCategoriesLoadingState) {
            return SizedBox(
              height: context.height() * 0.35,
              child: const AppCircularSpinner(),
            );
          }
          if (state is TopCategoriesErrorState) {}
          if (state is TopCategoriesDataState) {
            return SizedBox(
              height: context.height() * 0.35,
              child: GridView.builder(
                itemCount: state.topCategories.length,
                // disable scrolling
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return TopCategoryWidget(
                    icon: state.topCategories[index].cateImage.toString(),
                    text: state.topCategories[index].catName.toString(),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class TopCategoryWidget extends StatelessWidget {
  const TopCategoryWidget({
    Key? key,
    required this.icon,
    required this.text,
    this.onTap,
  }) : super(key: key);
  final String icon;
  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          color: AppColors.appGreyColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                backgroundColor: AppColors.appWhiteColor,
                radius: 30,
                child: CachedNetworkImage(
                  imageUrl: icon,
                  fit: BoxFit.cover,
                  height: 30,
                  width: 30,
                )),
            const SizedBox(height: 5),
            AutoSizeText(
              text,
              textAlign: TextAlign.center,
              maxLines: 2,
              group: AutoSizeGroup(),
              minFontSize: 8.sp,
              maxFontSize: 12.sp,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
