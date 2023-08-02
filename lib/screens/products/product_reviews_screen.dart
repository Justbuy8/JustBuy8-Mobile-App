import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/product_reviews/reviews_bloc.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
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
      appBar: BasicAppbarWidget(title: "Reviews"),
      body: BlocBuilder<ReviewBloc, ReviewState>(
        bloc: reviewBloc,
        builder: (context, state) {
          if (state is ReviewsLoadingState) {
            return AppCircularSpinner();
          } else if (state is ReviewsErrorState) {
            return Center(child: Text(state.message));
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
                              DateTime(
                                state.reviews[index].timePassed!.years!,
                                state.reviews[index].timePassed!.months!,
                                state.reviews[index].timePassed!.days!,
                                state.reviews[index].timePassed!.hours!,
                                state.reviews[index].timePassed!.minutes!,
                                state.reviews[index].timePassed!.seconds!,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
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
