//
//  proyectoInventarioApp.swift
//  proyectoInventario
//
//  Created by DAMII on 12/12/25.
//

import SwiftUI

@main
struct proyectoInventarioApp: App {

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
