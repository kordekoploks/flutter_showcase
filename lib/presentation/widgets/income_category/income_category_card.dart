import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constant/colors.dart';
import '../../../data/models/category/income_category_model.dart';
import '../../../domain/entities/category/income_category.dart';
import '../../blocs/category/income_category_bloc.dart';


class IncomeCategoryCard extends StatefulWidget {
  final IncomeCategory? category;
  final int index;
  final Function? onFavoriteToggle;
  final Function? onClick;
  final Function(IncomeCategory)? onClickMoreAction;
  final Function(IncomeCategory)? onClickToggle;
  final Function(IncomeCategoryModel)? onUpdate;
  final bool isUpdated;
  final VoidCallback onAnimationEnd;


  const IncomeCategoryCard({
    Key? key,
    this.category,
    required this.index,
    this.onFavoriteToggle,
    this.onClick,
    this.onClickMoreAction,
    this.onClickToggle,
    this.onUpdate,
    required this.isUpdated,
    required this.onAnimationEnd
  }) : super(key: key);

  @override
  _IncomeCategoryCardState createState() => _IncomeCategoryCardState();
}

class _IncomeCategoryCardState extends State<IncomeCategoryCard> {
  final GlobalKey _listKey = GlobalKey();

  IncomeCategoryModel? _updatedCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child:
        BlocBuilder<IncomeCategoryBloc, IncomeCategoryState>(builder: (context, state) {
          return _buildCategoryContent(context);
        }));
  }

  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade100,
      highlightColor: Colors.white,
      child: _buildCategoryContent(context),
    );
  }

  Widget _buildCategoryContent(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle category click
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _buildCategoryHeader(),
            ],
          ),
          Container(
            child: LayoutBuilder(
              builder: (context, constraint) {
                return Container(
                  width: constraint.maxWidth * 0.95,
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(60)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader() {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: widget.isUpdated ? vWPrimaryColor : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      onEnd: widget.onAnimationEnd,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            _buildCategoryImage(),
            _buildCategoryDetails(),
            _buildExpandIcon(),
            _buildMoreActionsIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryImage() {
    return widget.category == null
        ? _buildPlaceholderImage()
        : _buildCachedImage();
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(35),
      ),
    );
  }

  Widget _buildCachedImage() {
    return Expanded(
      flex: 2,
      child: SizedBox(
        height: 60,
        width: 60,
        child: Card(
          color: Colors.white,
          elevation: 2,
          shadowColor: Colors.transparent,
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
                      child: const SizedBox.shrink(),
                    ),
                errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDetails() {
    return Expanded(
      flex: 7,
      child: SizedBox(
        height: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 4, 0),
              child: widget.category == null
                  ? _buildPlaceholderText(width: 120)
                  : Text(
                widget.category!.name,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 4, 0),
              child: Row(
                children: [
                  SizedBox(
                    height: 18,
                    child: widget.category == null
                        ? _buildPlaceholderText(width: 100)
                        : Text(
                      widget.category!.desc,
                      style: Theme
                          .of(context)
                          .textTheme
                          .labelMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderText({required double width}) {
    return Container(
      width: width,
      height: 18,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildExpandIcon() {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          if (widget.onClickToggle != null && widget.category != null) {
            widget.onClickToggle!(widget.category!);
          }
        },    child: const Icon(
        Icons.keyboard_arrow_down,
        color: Colors.grey,
      ),
      ),
    );
  }

  Widget _buildMoreActionsIcon() {
    return Expanded(
      flex: 2,
      child: GestureDetector(
        onTap: () {
          if (widget.onClickMoreAction != null && widget.category != null) {
            widget.onClickMoreAction!(widget.category!);
          }
        },
        child: const Icon(
          Icons.more_vert,
          color: Colors.grey,
        ),
      ),
    );
  }



}
