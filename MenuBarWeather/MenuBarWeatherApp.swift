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
    var body: some Scene {
        MenuBarExtra("Menu Bar Weather", systemImage: MenuBarIcon){
            ContentView(icon: $MenuBarIcon)
        }.menuBarExtraStyle(.window)
    }
}
