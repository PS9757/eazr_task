import 'package:eazr/core/constants/sizedbox_ratio.dart';
import 'package:eazr/domain/home/entity/most_popular_entity.dart';
import 'package:eazr/presentation/home/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PopularDetailsScreen extends StatefulWidget {
  const PopularDetailsScreen({super.key, required this.popularModel});

  final MostPopularEntity popularModel;

  @override
  State<PopularDetailsScreen> createState() => _PopularDetailsScreenState();
}

class _PopularDetailsScreenState extends State<PopularDetailsScreen> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(widget.popularModel.url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.popularModel.url));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 80,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      launchUrl(Uri.parse(widget.popularModel.url));
                    },
                    icon: Icon(
                      Icons.open_in_browser,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(
                    size.height * SizedBoxRatio.sizedBoxHeight20),
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(
                    top: size.height * SizedBoxRatio.sizedBoxHeight5,
                    bottom: size.height * SizedBoxRatio.sizedBoxHeight10,
                    left: size.width * SizedBoxRatio.sizedBoxWidth10,
                    right: size.width * SizedBoxRatio.sizedBoxWidth10,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              size.height * SizedBoxRatio.sizedBoxHeight20),
                          topRight: Radius.circular(
                              size.height * SizedBoxRatio.sizedBoxHeight20))),
                  child: Center(
                    child: Text(
                      widget.popularModel.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size.height * SizedBoxRatio.sizedBoxHeight20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              pinned: true,
              backgroundColor: Colors.white,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: widget.popularModel.media.isNotEmpty &&
                        widget.popularModel.media[0].mediaMetadata[2].url
                            .isNotEmpty
                    ? Image.network(
                        widget.popularModel.media[0].mediaMetadata[2].url,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/placeholder.jpg',
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: size.height * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * SizedBoxRatio.sizedBoxWidth16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Source : ${widget.popularModel.source}'),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Section : ${widget.popularModel.section}'),
                      ],
                    ),
                    //publish date
                    Row(
                      children: [
                        Text(
                          'Published Date : ${DateFormat('dd-MMM-yyyy').format(widget.popularModel.publishedDate)}',
                        ),
                      ],
                    ),
                    //tags
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          // width: size.width * 0.9,
                          child: Text(
                            'Tags : ',
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.8,
                          child: Text(
                            widget.popularModel.desFacet.join(', '),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(widget.popularModel.byline),
                      ],
                    ),
                    Text(
                      'Abstract : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ExpandableTextWidget(
                      text: widget.popularModel.popularModelAbstract,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
