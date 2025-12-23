import SwiftUI

struct InicioView: View {

    let onLogout: () -> Void
    let correoUsuario = "correo@ejemplo.com"

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

                        Spacer()

                        Image("ic_pin")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Circle())
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

                        NavigationLink { AgregarReporteView() } label: {
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
        .navigationBarBackButtonHidden(true) //ocultar boton back
    }
}


struct InicioView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            InicioView(
                onLogout: {
                }
            )
        }
    }
}

