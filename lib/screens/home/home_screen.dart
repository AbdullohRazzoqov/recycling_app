import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recycling_app/blocs/home/home_bloc.dart';
import 'package:recycling_app/core/resources/app_toast.dart';
import 'package:recycling_app/core/resources/state_status.dart';
import 'package:recycling_app/core/widget/w_main.button.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/resources/app_colors.dart';
import '../../core/resources/app_styles.dart';
import '../../core/widget/w_appbar.dart';
import '../../core/widget/w_main_input.dart';
import 'widget/w_category_list.dart';
import 'widget/w_product_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc homeBloc;
  @override
  void initState() {
    homeBloc = HomeBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => homeBloc,
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.message.isNotEmpty) {
            AppToast.show(
                context: context,
                message: state.message,
                toastType: state.status == StateStatus.error
                    ? ToastType.error
                    : ToastType.success);
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,

          backgroundColor: AppColors.c_C6E5BA,
          //Appbar
          appBar: const WAppBar(title: 'ITEM SEARCH'),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 46,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Search By Item:".tr(),
                  style: AppStyles.seoulRegular
                      .copyWith(fontSize: 24.sp, color: AppColors.black),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              //Search Item
              WMainInput(
                onTapSearch: (input) {
                  homeBloc.add(SearchProductEvent(input));
                },
              ),
              const SizedBox(
                height: 32,
              ),

              BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                return Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.products.isNotEmpty
                                  ? "Searched products"
                                  : "Search By Category:".tr(),
                              style: AppStyles.seoulRegular.copyWith(
                                fontSize: 24.sp,
                                color: AppColors.black,
                              ),
                            ),
                            state.products.isNotEmpty
                                ? WMainButton(
                                    borderRadius: 12,
                                    styles: AppStyles.seoulRegular.copyWith(
                                        color: Colors.white, fontSize: 24.sp),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    text: 'Clear',
                                    onPressed: () {
                                      homeBloc.add(ClearProductsEvent());
                                    })
                                : SizedBox()
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      if (state.status == StateStatus.loading) ...{
                        Expanded(
                          child: Shimmer.fromColors(
                            baseColor: AppColors.c_C2E4B5,
                            highlightColor: AppColors.c_70B458,
                            child: GridView.count(
                              crossAxisCount: 2,
                              padding: const EdgeInsets.only(left: 30),
                              scrollDirection: Axis.horizontal,
                              childAspectRatio: 1.1,
                              children: List.generate(6, (index) {
                                return Container(
                                  margin: const EdgeInsets.only(
                                      right: 24, bottom: 20),
                                  decoration: BoxDecoration(
                                    color: AppColors.c_70B458,
                                    borderRadius: BorderRadius.circular(33),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      } else ...{
                        state.products.isNotEmpty
                            ? WProductList(products: state.products)
                            : WCategoryList(categories: state.categories)
                      },
                    ],
                  ),
                );
              }),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
