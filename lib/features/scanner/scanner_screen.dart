import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:recycling_app/features/scanner/bloc/scan_bloc.dart';
import '../../core/resources/app_colors.dart';
import '../../core/widget/w_main.button.dart';
import 'scan_result_page.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String? barcode;
  late ScanBloc scanBloc;
  @override
  void initState() {
    scanBloc = ScanBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => scanBloc,
      child: BlocListener<ScanBloc, ScanState>(
        listener: (context, state) {
          print(state);
          if (state is SeachResultState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ScanResultPage(product: scanBloc.product!),
              ),
            );
          } else if (state is ScanErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("SCAN YOUR ITEM".tr()),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 22,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(85),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width - 32,
                    child: MobileScanner(
                        controller: MobileScannerController(
                            detectionSpeed: DetectionSpeed.noDuplicates,
                            returnImage: true),
                        onDetect: (capture) {
                          final List<Barcode> barcodes = capture.barcodes;
                          barcode = barcodes.first.rawValue;
                          setState(() {});
                        }),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<ScanBloc, ScanState>(
                    builder: (context, state) {
                      return WMainButton(
                        backgroundColor: barcode == null
                            ? Colors.grey
                            : AppColors.buttonColor,
                        margin: const EdgeInsets.symmetric(vertical: 32),
                        text: "Scan",
                        isLoading: state is ScanLoadingState,
                        onPressed: () {
                          if (barcode != null) {
                            scanBloc.add(SearchProductEvent(barcode!));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please scan a barcode".tr()),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
