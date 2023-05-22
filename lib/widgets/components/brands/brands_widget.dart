// ignore_for_file: non_constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/brands/brands_bloc.dart';
import 'package:justbuyeight/blocs/brands/brands_events_and_states.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:nb_utils/nb_utils.dart';

class BrandsWidget extends StatefulWidget {
  const BrandsWidget({Key? key}) : super(key: key);

  @override
  State<BrandsWidget> createState() => _BrandsWidgetState();
}

class _BrandsWidgetState extends State<BrandsWidget> {
  var brandBloc = BrandsBloc();

  @override
  void initState() {
    super.initState();
    brandBloc = BrandsBloc()
      ..add(BrandsLoadEvent(
        1.toString(),
        10.toString(),
        true,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: brandBloc,
      builder: (context, state) {
        if (state is BrandsLoadingState) {
          return SizedBox(
            height: context.height() * 0.35,
            child: const AppCircularSpinner(),
          );
        } else if (state is BrandsGetState) {
          return SizedBox(
            height: context.height() * 0.2,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 20,
              ),
              shrinkWrap: true,
              itemCount: state.brands.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: BrandWidget(
                    text: state.brands[index].brandName.toString(),
                    imageUrl: state.brands[index].brandImage.toString(),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(child: Text("Error"));
        }
      },
    );
  }
}

class BrandWidget extends StatelessWidget {
  const BrandWidget({
    Key? key,
    required this.text,
    required this.imageUrl,
  }) : super(key: key);
  final String text;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              shape: BoxShape.rectangle,
              color: AppColors.appGreyColor.withOpacity(0.5),
              image: DecorationImage(
                image: CachedNetworkImageProvider(imageUrl),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        AutoSizeText(
          text,
          style: TextStyle(
            fontFamily: AppFonts.openSansBold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
