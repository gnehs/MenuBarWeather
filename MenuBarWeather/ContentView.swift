//
//  ContentView.swift
//  MenuBarWeather
//
//  Created by 勝勝寶寶 on 2024/6/15.
//

import SwiftUI
import WebViewKit
import WebKit

class WeatherIconHandler: NSObject, WKScriptMessageHandler {
    @Binding var icon: String

    init(icon: Binding<String>) {
        _icon = icon
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "weatherIcon", let messageBody = message.body as? String {
            icon = messageBody
        }
    }
}


struct ContentView: View {
    @Binding var icon: String
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack{
            HStack{
                Image(systemName: icon)
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
            .blendMode(colorScheme == .dark ? .lighten : .plusDarker)
        }
        .background(colorScheme == .dark ? .clear : .white.opacity(0.75))
    }
    // Example of WKWebViewConfiguration
    var configuration: WKWebViewConfiguration {
        let bgColor = colorScheme == .dark ? "#000" : "#fff"
        let userScriptString = """
  const ob = new MutationObserver(function (mutationsList, observer) {
    injectScript();
  });
  ob.observe(document, {
    childList: true,
    subtree: true,
  });
 function injectScript(){
    const injectCSS = ":root { color-scheme: light dark; }";
    const weatherContainer = document.querySelector('#wob_wc');
    if (weatherContainer) {
        if (!weatherContainer.hasAttribute('data-injected')) {
            const style = document.createElement('style');
            style.textContent = injectCSS;
            document.head.appendChild(style);

            weatherContainer.setAttribute('data-injected', 'true');
            weatherContainer.style.position = 'fixed';
            weatherContainer.style.top = '0';
            weatherContainer.style.left = '0';
            weatherContainer.style.zIndex = '99999';
            weatherContainer.style.backgroundColor = '\(bgColor)';
            document.body.style.overflow = 'hidden';
            document.body.style.opacity = '1';
            // get weather icon
            let icon = document.querySelector('.wob_tci').src.split("/").at(-1).split(".").at(0)
            const weather_to_sf_symbols = {
                'partly_cloudy': 'cloud.sun.fill',
                'thunderstorms': 'cloud.bolt.fill',
                'rain_s_cloudy': 'cloud.sun.rain.fill',
                'sunny': 'sun.max.fill',
                'sunny_s_cloudy': 'cloud.sun.fill',
                'rain': 'cloud.rain.fill',
                'cloudy': 'cloud.fill',
                'rain_light': 'cloud.drizzle.fill',
                'cloudy_s_rain': 'cloud.sun.rain.fill',
                'cloudy_s_sunny': 'cloud.sun.fill',
                'rain_heavy': 'cloud.heavyrain.fill',
                'sunny_s_rain': 'cloud.sun.rain.fill',
                'fog': 'cloud.fog.fill'
            }
            icon = weather_to_sf_symbols[icon]??"cloud.sun"
            window.webkit.messageHandlers.weatherIcon.postMessage(icon)
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
        userContentController.add(WeatherIconHandler(icon: $icon), name: "weatherIcon")

        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController

        return configuration
    }


}


#Preview {
    ContentView(icon: .constant("cloud.sun"))
}
