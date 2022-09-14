//
//  VariantApp.swift
//  Variant
//
//  Created by macbro on 21/05/22.
//

import SwiftUI

@main
struct VariantApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var statusApp = StatusApp()
    @StateObject var defaults = Defaults()
    var body: some Scene {
        WindowGroup {
            StartScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(statusApp)
                .environmentObject(defaults)
        }
    }
}
