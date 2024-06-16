//
//  MenuBarWeatherApp.swift
//  MenuBarWeather
//
//  Created by 勝勝寶寶 on 2024/6/15.
//

import SwiftUI

@main
struct MenuBarWeatherApp: App {
    @State private var MenuBarIcon = "cloud.sun"
    @State private var MenuBarText = ""
    var body: some Scene {
        MenuBarExtra() {
            ContentView(icon: $MenuBarIcon, text: $MenuBarText)
        } label: {
            HStack {
                Image(systemName: MenuBarIcon)
                Text(MenuBarText)
            }
        }.menuBarExtraStyle(.window)
    }
}
