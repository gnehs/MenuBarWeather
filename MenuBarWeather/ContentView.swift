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
            WebView(urlString: "https://www.google.com.tw/search?q=weather", configuration: configuration)
            { webView in
                webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"
                
                 
            }
            .frame(width:652.0, height: 338.0)
            .padding(16.0)
            .blendMode(.plusDarker)
            .background(.white.opacity(0.75))
        }
    }
    // Example of WKWebViewConfiguration
    var configuration: WKWebViewConfiguration {
        let userScriptString = """
 const {x, y} = document.querySelector('#wob_wc').getClientRects()[0];
 document.body.style.transform = `translate(-${x}px, -${y}px)`;
 document.body.style.overflow = 'hidden';
"""
        let  userScript = WKUserScript(
            source: userScriptString,
            injectionTime: .atDocumentEnd,
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
