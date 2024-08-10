import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/data/models/category/category_model.dart';
import 'package:eshop/presentation/views/main/category/sub_category_add_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/router/app_router.dart';
import '../../domain/entities/category/category.dart';

class CategoryCard extends StatefulWidget {
  final Category? category;
  final Function? onFavoriteToggle;
  final Function? onClick;
  final  Function(Category)? onClickMoreAction;

  const CategoryCard(
      {Key? key,
      this.category,
      this.onFavoriteToggle,
      this.onClick, this.onClickMoreAction})
      : super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool isExpanded = false;
  final GlobalKey _listKey = GlobalKey();
  double expandedHeight = 80;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: widget.category == null
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade100,
              highlightColor: Colors.white,
              child: buildBody(context),
            )
          : buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to category details if necessary
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isExpanded ? expandedHeight : 90,
            child: Column(
              children: [
                Row(
                  children: [
                    widget.category == null
                        ? Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(35),
                            ),
                          )
                        : Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 80,
                              width: 80,
                              child: Card(
                                color: Colors.white,
                                elevation: 2,
                                margin: const EdgeInsets.all(4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Hero(
                                  tag: widget.category!.id,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.category!.image,
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: Colors.grey.shade100,
                                        highlightColor: Colors.white,
                                        child: Container(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Center(
                                              child: Icon(Icons.error)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(4, 16, 4, 0),
                              child: widget.category == null
                                  ? Container(
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    )
                                  : Text(
                                      widget.category!.name,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    )),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 18,
                                  child: widget.category == null
                                      ? Container(
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        )
                                      : Text(
                                          widget.category!.desc,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                            if (isExpanded) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                setState(() {
                                  expandedHeight = _listKey
                                          .currentContext!.size!.height +
                                      80; // Adjust based on the height of your header
                                });
                              });
                            }
                          });
                        },
                        child: Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            widget.onClickMoreAction!(widget.category!);
                          },
                          child: const Icon(
                            Icons.more_vert,
                          ),
                        ))
                  ],
                ),
                if (isExpanded)
                  Column(key: _listKey, children: [
                    GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SubCategoryAddBottomSheet(
                                onSave: () {
                                  // Handle save action
                                },
                                categoryModel: widget.category!,
                              );
                            },
                          );
                        },
                        child: ListTile(
                            leading: Icon(Icons.add),
                            title: Text('Add Sub Category'),
                            trailing: Icon(Icons.add))),
                    ...List.generate(3, (index) {
                      return ListTile(
                        leading: Icon(Icons.circle),
                        title: Text('Sub-item ${index + 1}'),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Handle add button press
                          },
                        ),
                      );
                    }),
                  ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
