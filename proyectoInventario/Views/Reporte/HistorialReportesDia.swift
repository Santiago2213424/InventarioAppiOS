import SwiftUI

struct HistorialReportesDiaView: View {

    let reportesDia: [Reporte] = [
        Reporte(nombre: "Venta arroz", fecha: "Hoy", monto: 120.00),
        Reporte(nombre: "Venta leche", fecha: "Hoy", monto: 80.00),
        Reporte(nombre: "Gasto limpieza", fecha: "Hoy", monto: -30.00),
        Reporte(nombre: "Venta snacks", fecha: "Hoy", monto: 50.00)
    ]

    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {

                VStack {
                    Text("📋 REPORTE DEL DÍA")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(16)
                        .frame(maxWidth: .infinity)
                }
                .background(Color.AzulOscuro)
                .cornerRadius(12)
                .shadow(radius: 6)
                .padding(16)

                ScrollView {
                    VStack {
                        ForEach(reportesDia) { reporte in
                            ReporteItemView(reporte: reporte)
                        }
                    }
                }

                Text("Ganancias: S/0.00   |   Gastos: S/0.00")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .padding(8)

                Spacer(minLength: 8)
            }
            .frame(maxWidth: 370)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HistorialReportesDiaView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HistorialReportesDiaView()
        }
    }
}
