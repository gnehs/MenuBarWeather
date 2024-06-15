//
//  MenuBarWeatherApp.swift
//  MenuBarWeather
//
//  Created by 勝勝寶寶 on 2024/6/15.
//

import SwiftUI

@main
struct MenuBarWeatherApp: App { 
    var body: some Scene {
        MenuBarExtra("Menu Bar Weather", systemImage: "cloud.sun"){
            ContentView()
        }.menuBarExtraStyle(.window)
    }
}
