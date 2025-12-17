import SwiftUI

struct HistorialReportesFechaView: View {

    @State private var fechaFiltro = ""

    // mock
    let reportes: [Reporte] = [
        Reporte(nombre: "Galletas Oreo", fecha: "2025-06-25", monto: 50.00),
        Reporte(nombre: "Leche Gloria", fecha: "2025-06-25", monto: 32.50),
        Reporte(nombre: "Pago proveedor", fecha: "2025-06-25", monto: -40.00),
        Reporte(nombre: "Venta gaseosa", fecha: "2025-06-25", monto: 120.00)
    ]

    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {

                VStack {
                    Text("📊 REPORTES")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding(12)
                        .frame(maxWidth: .infinity)
                }
                .background(Color.AzulOscuro)
                .cornerRadius(12)
                .shadow(radius: 6)
                .padding(12)

                // Filtro
                HStack {

                    TextField("YYYY-MM-DD", text: $fechaFiltro)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Spacer()
                                Image(systemName: "calendar")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        )

                    Button("Filtrar") {
                        // filtrar (mock)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.AzulOscuro)
                    .cornerRadius(8)
                    .padding(.leading, 8)
                }
                .padding(.horizontal, 12)
                .padding(.top, 10)
                .padding(.bottom, 20)


                ScrollView {
                    VStack {
                        ForEach(reportes) { reporte in
                            ReporteItemView(reporte: reporte)
                        }
                    }
                }

                // Totales
                Text("Ganancias: S/0.00   |   Gastos: S/0.00")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .padding(12)
            }
            .frame(maxWidth: 370)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HistorialReportesFechaView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HistorialReportesFechaView()
        }
    }
}
