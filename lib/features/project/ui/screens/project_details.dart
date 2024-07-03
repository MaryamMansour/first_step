import 'dart:io';
import 'package:first_step/core/theming/styles.dart';
import 'package:first_step/features/project/ui/widgets/pdf_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../chat/ui/chat_room_screen.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final String projectName;
  final String userId;
  final String userName;
  final String projectDescription;
  final String about;
  final String industry;
  final List<String> tags;
  final String businessModel;
  final String customerModel;
  final String website;
  final String legalName;
  final String raisedAmount;
  final String stage;
  final String year;
  final String type;
  final List<String> investors;
  final dynamic slideshowFile; // Can be a URL or File
  final dynamic logoImage; // Can be a URL or File

  ProjectDetailsScreen({
    required this.projectName,
    required this.projectDescription,
    required this.about,
    required this.industry,
    required this.businessModel,
    required this.customerModel,
    required this.stage,
    required this.year,
    required this.type,
    required this.legalName,
    this.slideshowFile,
    this.logoImage,
    required this.tags,
    required this.website,
    required this.raisedAmount,
    required this.investors, required this.userId, required this.userName,
  });

  @override
  _ProjectDetailsScreenState createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  String? _localPath;
  late WebViewController _webViewController;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  UniqueKey _key = UniqueKey();

  @override
  void initState() {
    super.initState();
    _preparePDF();
    if (widget.slideshowFile is String &&
        widget.slideshowFile.startsWith('http')) {
      _webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {},
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.slideshowFile));
    }
  }

  Future<void> _preparePDF() async {
    if (widget.slideshowFile is String &&
        widget.slideshowFile.startsWith('http')) {
      final googleDriveDownloadLink =
          widget.slideshowFile.replaceFirst('/view', '/uc?export=download');
      final localPath = await _downloadFile(googleDriveDownloadLink);
      setState(() {
        _localPath = localPath;
      });
    }
  }

  Future<String> _downloadFile(String url) async {
    final tempDir = await getTemporaryDirectory();
    final localPath = '${tempDir.path}/temp.pdf';
    await Dio().download(url, localPath);
    return localPath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    child: Image.asset("assets/images/logo_dark.png"),
                  ),
                ],
              ),
              verticalSpace(20),
              const Divider(
                color: AppColors.lightGray,
                thickness: 0.5,
              ),
              verticalSpace(20),
              Text('${widget.projectName} Pitch Deck',
                  style: AppTextStyles.font24PrimaryBold),
              verticalSpace(10),
              Text(widget.projectDescription,
                  style: AppTextStyles.font20BlackThin
                      .copyWith(fontWeight: FontWeight.w300, height: 1.2)),
              verticalSpace(30),
              Row(
                children: [
                  Text(
                    '${widget.year} ● ${widget.stage}',
                    style: AppTextStyles.font16GrayLight.copyWith(
                        color: AppColors.gray, fontWeight: FontWeight.w300),
                  ),
                  horizontalSpace(5),
                  const Icon(
                    Icons.stairs_outlined,
                    size: 15,
                    color: AppColors.gray,
                  )
                ],
              ),
              verticalSpace(10),
              const Divider(
                color: AppColors.lightGray,
                thickness: 0.5,
              ),
              verticalSpace(10),
              if (widget.slideshowFile is String &&
                  widget.slideshowFile.startsWith('http'))
                Container(
                  height: 200,
                  child: WebViewWidget(
                      gestureRecognizers: gestureRecognizers,
                      key: _key,
                      controller: _webViewController),
                ),
              verticalSpace(15),
              Text('About ${widget.projectName}',
                  style: AppTextStyles.font24PrimaryBold),
              verticalSpace(20),
              Text(widget.about,
                  style: AppTextStyles.font20BlackThin
                      .copyWith(fontWeight: FontWeight.w300, height: 1.2)),
              verticalSpace(50),
              richText('Industry', widget.industry),
              verticalSpace(5),
              richTextList('Tags', widget.tags),
              verticalSpace(5),
              richText('Business Model', widget.businessModel),
              verticalSpace(5),
              richText('Customer Model', widget.customerModel),
              verticalSpace(5),
              richText('Website', widget.website),
              verticalSpace(5),
              richText('Legal Name', widget.legalName),
              verticalSpace(25),
              const Divider(
                color: AppColors.lightGray,
                thickness: 0.5,
              ),
              verticalSpace(20),
              Text('About ${widget.projectName} Pitch Deck',
                  style: AppTextStyles.font24PrimaryBold),
              verticalSpace(20),
              richText('Amount Raised', widget.raisedAmount),
              verticalSpace(5),
              richText('Year', widget.year),
              verticalSpace(5),
              richText('Stage', widget.stage),
              verticalSpace(5),
              richTextList('Investors', widget.investors),
              verticalSpace(5),
              richText('Username', widget.userName),
              verticalSpace(100)

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatRoomScreen(
                description: "",
                receiverUserEmails:  [],
                receiverUserID: widget.userId,
                receiverName: widget.userName?? 'Unknown',
                isGroup: false,
                isChannel: false,
              ),
            ),
          );
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.chat,color: AppColors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget richText(String first, String second) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(text: '$first:', style: AppTextStyles.font12BlackBold),
        TextSpan(text: ' $second', style: AppTextStyles.font12Blacklight),
      ]),
    );
  }

  Widget richTextList(String first, List<String> second) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$first:',
            style: AppTextStyles.font12BlackBold,
          ),
          for (var item in second)
            TextSpan(
              text: ' $item, ',
              style: AppTextStyles.font12Blacklight,
            ),
        ],
      ),
    );
  }



}
