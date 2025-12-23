//
//  proyectoInventarioApp.swift
//  proyectoInventario
//
//  Created by DAMII on 12/12/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct proyectoInventarioApp: App {
    
    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @State private var estaLogueado = false

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if estaLogueado {
                    InicioView(
                        onLogout: {
                            estaLogueado = false
                        }
                    )
                } else {
                    LoginView(
                        onLoginSuccess: {
                            estaLogueado = true
                        }
                    )
                }
            }
        }
    }
}
