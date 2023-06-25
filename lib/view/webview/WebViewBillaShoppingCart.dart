import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_genius/bloc/BillaShoppingCart/BlocBillaShoppingCart.dart';
import 'package:recipe_genius/bloc/BillaShoppingCart/event/EventBillaShoppingCart.dart';
import 'package:recipe_genius/platform/platform.dart';
import 'package:recipe_genius/view/webview/WebViewState/WebViewState.dart';


import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';



class WebViewBillaShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var streamController = StreamController<WebState>();

    return StreamBuilder(
      initialData: WebState(state: MyState.waiting, cookie: ""),
      stream: streamController.stream,
      builder: ( context, state )  {
        switch (state.data!.state) {
          case (MyState.noCookie) :
            return _Webview(streamController, state.data!);
          case (MyState.waiting):
            return WaitingForSavedId(streamController);
          case (MyState.withCookie):
          print("withcookie");
            return _Webview(streamController, state.data!);
          }
        }
     );
  }
}


class WaitingForSavedId extends StatelessWidget {
  StreamController<WebState> _streamController;

  WaitingForSavedId(this._streamController);


  @override
  Widget build(BuildContext context) {

    (()async{
      var file = await readFileBaskedId();
      var id =  file.readAsStringSync();
      print("object");
      if (id.length == 0 ) {
        _streamController.add(WebState(state: MyState.noCookie, cookie: id));
      }else {
      print("send shopping cart to billa");
        //context.read<BlocBillaShoppingCart>().add(EventBillaShoppingCartSend());
         Timer(Duration(seconds: 1), () {
        _streamController.add(WebState(state: MyState.withCookie, cookie: id));

         });
      }

    })();


    return Scaffold(appBar: AppBar(title: Text("loading")), body: CircularProgressIndicator());
  }

}


class _Webview extends StatefulWidget {
  StreamController _streamController;
  WebState webState;
  _Webview(this._streamController, this.webState);

  @override
  State<StatefulWidget> createState() => _WebviewState();
}

class _WebviewState extends State<_Webview> {

  late final PlatformWebViewController _controller;
  late PlatformWebViewCookieManager cookieManager;


  @override
  void initState() {
    super.initState(); 

    print("init state");
    cookieManager = PlatformWebViewCookieManager(PlatformWebViewCookieManagerCreationParams());

    var requestHeader = {
      "Cookie": "AnonymousCartId=${widget.webState.cookie}"
    };

    print(requestHeader);

    _controller = PlatformWebViewController(
      WebKitWebViewControllerCreationParams(allowsInlineMediaPlayback: true, ),
    )..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setPlatformNavigationDelegate(PlatformNavigationDelegate(PlatformNavigationDelegateCreationParams())..setOnProgress((progress) async {
      debugPrint('WebView is loading (progress : $progress%)'); 
    
      if (progress == 100) {
        var cookie = await _controller.runJavaScriptReturningResult('document.cookie') as String;
        var arr  = cookie.split("; ").map((e) => e.split("=")).where((element) => element[0] == "AnonymousCartId") 
        .toList();

        if (arr.isNotEmpty && arr.length == 1 && widget.webState.state == MyState.noCookie) {
          (() async{
            var file = await readFileBaskedId();
            file.writeAsStringSync(arr[0][1]);
            widget._streamController.add(WebState(state: MyState.withCookie, cookie: arr[0][1]));
          })();

          print(arr.join());
        } else {
           print(arr.join());
        }
      }
    }))
    ..loadRequest(LoadRequestParams(uri: Uri.parse( "https://shop.billa.at/warenkorb"), headers: requestHeader));
  }

  @override
  Widget build(BuildContext context) {
  var requestHeader = {
        "Cookie": "AnonymousCartId=${widget.webState.cookie}"
    };

    if (widget.webState.state == MyState.withCookie) {
      print(requestHeader);
      print("send shopping cart to billa");
      context.read<BlocBillaShoppingCart>().add(EventBillaShoppingCartSend());

      Timer(Duration(seconds: 2), () { 

      print(requestHeader);
      _controller.loadRequest(LoadRequestParams(uri: Uri.parse( "https://shop.billa.at/warenkorb"), headers: requestHeader));

      });
    }

    return Scaffold(appBar: AppBar(title: Text("Billa Shop")), body: PlatformWebViewWidget(PlatformWebViewWidgetCreationParams(controller: _controller)).build(context));
  }

}