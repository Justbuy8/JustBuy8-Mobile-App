import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/arrivals/new_arrival_bloc.dart';
import 'package:justbuyeight/blocs/products/arrivals/new_arrival_state_and_events.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/product_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/border_text_button.dart';

class NewArrivalGrid extends StatefulWidget {
  const NewArrivalGrid({Key? key}) : super(key: key);

  @override
  State<NewArrivalGrid> createState() => _NewArrivalGridState();
}

class _NewArrivalGridState extends State<NewArrivalGrid> {
  final Map<String, bool> categoryMap = {
    "all": false,
    "clothes": false,
    "electronics": false,
    "cosmetics": false,
    "fitness": false,
  };
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewArrivalBloc>(
      create: (context) =>
          NewArrivalBloc()..add(NewArrivalGetAllEvent("1", "10", "all")),
      child: BlocConsumer<NewArrivalBloc, NewArrivalState>(
        listener: (context, state) {
          if (state is NewArrivalGetAllState) {
            categoryMap["all"] = true;
            // make all false
            categoryMap["clothes"] = false;
            categoryMap["electronics"] = false;
            categoryMap["cosmetics"] = false;
            categoryMap["fitness"] = false;
          }
        },
        builder: (context, state) {
          if (state is NewArrivalGetAllState) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BorderTextButton(
                      text: "All",
                      isClicked: categoryMap['all'],
                      onPressed: () {
                        BlocProvider.of<NewArrivalBloc>(context)
                            .add(NewArrivalGetAllEvent("1", "10", "all"));
                      },
                    ),
                    BorderTextButton(
                      text: "Clothes",
                      isClicked: categoryMap['clothes'],
                      onPressed: () {
                        BlocProvider.of<NewArrivalBloc>(context)
                            .add(NewArrivalGetAllEvent("1", "10", "11"));
                      },
                    ),
                    BorderTextButton(
                        text: "Electronics",
                        isClicked: categoryMap['electronics']),
                    BorderTextButton(
                        text: "Cosmetics", isClicked: categoryMap['cosmetics']),
                    BorderTextButton(
                      text: "Fitness",
                      isClicked: categoryMap['fitness'],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 0.7,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: List.generate(
                    state.products.length,
                    (index) => ProductWidget(
                      text: state.products[index].name.toString(),
                      imageUrl: state.products[index].thumbnail.toString(),
                      price: state.products[index].unitPrice.toString(),
                      rating: state.products[index].totalRating.toString(),
                    ),
                  ),
                ),
              ],
            );
          }
          return GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(
              10,
              (index) => Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
