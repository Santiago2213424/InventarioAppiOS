import SwiftUI
import FirebaseAuth

struct InicioView: View {

    let onLogout: () -> Void
    
    var correoUsuario: String {
            Auth.auth().currentUser?.email ?? " (correo) "
        }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            onLogout()
        } catch {
            print("Error al cerrar sesión: \(error.localizedDescription)")
        }
    }


    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {

                VStack(alignment: .leading, spacing: 12) {

                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Bienvenido")
                                .font(.system(size: 18, weight: .bold))

                            Text("Correo: \(correoUsuario)")
                                .font(.system(size: 14))
                        }
                    }

                    Image("imageninicio")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 230)
                        .clipped()
                        .cornerRadius(12)
                        .padding(.top, 20)
                }
                .padding(16)
                .frame(maxWidth: 370)

                ScrollView {
                    VStack(spacing: 12) {

                        NavigationLink { CategoriaView() } label: {
                            MenuCard(icon: "📦", title: "Inventario")
                        }

                        NavigationLink { StockView() } label: {
                            MenuCard(icon: "🔔", title: "Stock")
                        }

                        NavigationLink { AgregarReporteView(viewModel: ReporteViewModel()) } label: {
                            MenuCard(icon: "📊", title: "Reporte")
                        }

                        NavigationLink { ProveedoresView() } label: {
                            MenuCard(icon: "👥", title: "Proveedores")
                        }

                        Button {
                            onLogout()
                        } label: {
                            MenuCard(icon: "🚪", title: "Salir")
                        }

                        Spacer(minLength: 20)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    .frame(maxWidth: 370)
                }
            }
        }
        // .navigationBarBackButtonHidden(true) //ocultar boton back del navigation
    }
}
