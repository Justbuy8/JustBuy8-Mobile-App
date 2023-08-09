import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/product_reviews/reviews_bloc.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/constants/app_textstyle.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:velocity_x/velocity_x.dart';

class ProductReviewsScreen extends StatefulWidget {
  final int productId;
  const ProductReviewsScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductReviewsScreen> createState() => _ProductReviewsScreenState();
}

class _ProductReviewsScreenState extends State<ProductReviewsScreen> {
  ReviewBloc reviewBloc = ReviewBloc();

  @override
  void initState() {
    reviewBloc = reviewBloc..add(GetReviewsEvent(productId: widget.productId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbarWidget(title: AppText.reviewText),
      body: BlocBuilder<ReviewBloc, ReviewState>(
        bloc: reviewBloc,
        builder: (context, state) {
          if (state is ReviewsLoadingState) {
            return AppCircularSpinner();
          } else if (state is ReviewsErrorState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  LottieAssets.error,
                  repeat: false,
                ),
                10.height,
                Text(
                  state.message,
                  style: AppTextStyle.heading,
                ),
                // retry button
                20.height,
                ElevatedButton(
                  onPressed: () {
                    reviewBloc
                        .add(GetReviewsEvent(productId: widget.productId));
                  },
                  child: Text(AppText.tryAgain),
                ),
              ],
            );
          } else if (state is ReviewsEmptyState) {
            return Center(
              child: Text(
                state.message,
                style: AppTextStyle.heading,
              ),
            );
          } else if (state is ReviewsLoadedState) {
            return ListView.builder(
              itemCount: state.reviews.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(state.reviews[index].image.toString()),
                      ),
                      title: Text(
                        state.reviews[index].fName.toString() +
                            " " +
                            state.reviews[index].lName.toString(),
                        style: TextStyle(fontFamily: AppFonts.openSansBold),
                      ),
                      subtitle: Row(
                        children: [
                          // rating in velocity x
                          VxRating(
                            onRatingUpdate: (value) {},
                            count: 5,
                            selectionColor: AppColors.appOrangeColor,
                            size: 15,
                            isSelectable: false,
                            value: state.reviews[index].rating.toDouble(),
                          ),
                          10.width,
                          // time ago
                          Text(
                            timeago.format(
                              DateTime.parse(
                                state.reviews[index].timePassed.toString(),
                              ),
                            ),
                            style: TextStyle(
                              color: AppColors.appBlackColor.withOpacity(0.7),
                              fontSize: 12,
                              fontFamily: AppFonts.openSansRegular,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(state.reviews[index].comment.toString()),
                    ),
                    Divider(),
                  ],
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
