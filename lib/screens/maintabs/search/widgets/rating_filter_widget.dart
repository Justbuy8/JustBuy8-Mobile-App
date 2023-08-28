import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/blocs/rating/rating_filter_bloc.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';

class RatingFilterWidget extends StatefulWidget {
  const RatingFilterWidget({Key? key}) : super(key: key);

  @override
  State<RatingFilterWidget> createState() => _RatingFilterWidgetState();
}

class _RatingFilterWidgetState extends State<RatingFilterWidget> {
  final Map<String, bool> ratingMap = {};

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RatingFilterBloc()..add(RatingFilterLoadingEvent()),
      child: BlocConsumer<RatingFilterBloc, RatingFilterState>(
        listener: (context, state) {
          if (state is RatingFilterDataState) {
            ratingMap.addEntries(
              state.ratings.map(
                (e) => MapEntry(e, false),
              ),
            );
            ratingMap['All'] = true;
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
                      ratingMap.updateAll((key, value) => false);
                      ratingMap.update(
                        state.ratings[index].toString(),
                        (value) => true,
                      );
                      setState(() {});
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
