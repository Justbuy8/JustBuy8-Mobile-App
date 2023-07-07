import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/models/categories/SubCategoryModel.dart';
import 'package:justbuyeight/widgets/components/buttons/border_text_button.dart';
import 'package:nb_utils/nb_utils.dart';

class SubCategoryListItemWidget extends StatefulWidget {
  final SubCategoryModel subCategory;
   SubCategoryListItemWidget({ Key? key, required this.subCategory  }) : super(key: key);

  @override
  _SubCategoryListItemWidgetState createState() => _SubCategoryListItemWidgetState();
}

class _SubCategoryListItemWidgetState extends State<SubCategoryListItemWidget> {
   bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: radius(),
                        color: AppColors.primaryColor,
                      ),
                      child: ExpansionTile(
                        childrenPadding: EdgeInsets.all(8),
                        title: Text.rich(
                          TextSpan(
                            text: widget.subCategory.subCatName,
                            style:
                                boldTextStyle(color: AppColors.appWhiteColor),
                          ),
                        ),
                        trailing: isExpanded
                            ? Container(
                                child: Icon(Icons.keyboard_arrow_up,
                                    color: AppColors.appWhiteColor, size: 30),
                                decoration:
                                    BoxDecoration(borderRadius: radius(100)),
                              )
                            : Icon(Icons.keyboard_arrow_down,
                                color: AppColors.appWhiteColor, size: 30),
                        onExpansionChanged: (t) {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        children: [
                          Container(
                            width: context.width(),
                            decoration: boxDecorationDefault(
                                color: context.cardColor, boxShadow: null),
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: context.width() / 2,
                                    childAspectRatio: 5,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, i) => BorderTextButton(
                                    text: widget.subCategory.child![i]
                                        .childCatName
                                        .toString(),
                                  ),
                                  itemCount:
                                       widget.subCategory.child!.length,
                                )
                              ],
                            ).paddingAll(8),
                          )
                        ],
                      ),
                    );
  }
}