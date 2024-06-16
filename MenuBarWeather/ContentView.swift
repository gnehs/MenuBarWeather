//
//  ContentView.swift
//  MenuBarWeather
//
//  Created by 勝勝寶寶 on 2024/6/15.
//

import SwiftUI
import WebViewKit
import WebKit
struct ContentView: View {
    var body: some View {
        VStack{
            HStack{
                Text("Menu Bar Weather")
                    .fontWeight(.bold)
                Spacer()
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
            }
            .padding([.top, .trailing], 8.0)
            .padding(.leading, 16.0)
            WebView(urlString: "https://www.google.com.tw/search?q=weather", configuration: configuration)
            { webView in
                webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"
            }
            .frame(width:652.0, height: 338.0)
            .padding(16.0)
            .blendMode(.plusDarker)
        }
        .background(.white.opacity(0.75))
    }
    // Example of WKWebViewConfiguration
    var configuration: WKWebViewConfiguration {
        let userScriptString = """
  const ob = new MutationObserver(function (mutationsList, observer) {
    injectScript();
  });
  ob.observe(document, {
    childList: true,
    subtree: true,
  });
 function injectScript(){
    const weatherContainer = document.querySelector('#wob_wc');
    if (weatherContainer) {
        if (!weatherContainer.hasAttribute('data-injected')) {
            weatherContainer.setAttribute('data-injected', 'true');
            weatherContainer.style.position = 'fixed';
            weatherContainer.style.top = '0';
            weatherContainer.style.left = '0';
            weatherContainer.style.zIndex = '99999';
            weatherContainer.style.backgroundColor = '#fff';
            document.body.style.overflow = 'hidden';
            document.body.style.opacity = '1';
        }
    } else {
        document.body.style.opacity = '0';
    }
 }
 // reload every hour
 let currentMinute = new Date().getMinutes();
 setTimeout(() => {
    location.reload();
 }, (60 - currentMinute) * 60 * 1000);
"""
        let  userScript = WKUserScript(
            source: userScriptString,
            injectionTime: .atDocumentStart,
            forMainFrameOnly: true)

        let userContentController = WKUserContentController()
        userContentController.addUserScript(userScript)

        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController

        return configuration
    }
}

#Preview {
    ContentView()
}
