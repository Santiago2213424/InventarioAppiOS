import SwiftUI

struct HistorialReportesFechaView: View {

    @State private var fechaFiltro = ""

    // mock con Date
    let reportes: [Reporte] = [
        Reporte(nombre: "Galletas Oreo", fecha: dateFrom("2025-06-25"), monto: 50.00),
        Reporte(nombre: "Leche Gloria", fecha: dateFrom("2025-06-25"), monto: 32.50),
        Reporte(nombre: "Pago proveedor", fecha: dateFrom("2025-06-25"), monto: -40.00),
        Reporte(nombre: "Venta gaseosa", fecha: dateFrom("2025-06-25"), monto: 120.00)
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

                // filtro x fecha
                HStack {
                    TextField("YYYY-MM-DD", text: $fechaFiltro)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)

                    Button("Filtrar") {
                        // filtrar con dateformatter
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.AzulOscuro)
                    .cornerRadius(8)
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 20)

                ScrollView {
                    VStack {
                        ForEach(reportes) { reporte in
                            ReporteItemView(reporte: reporte)
                        }
                    }
                }

                Text("Ganancias: S/0.00   |   Gastos: S/0.00")
                    .font(.system(size: 16))
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
