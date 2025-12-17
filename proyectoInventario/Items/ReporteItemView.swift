import SwiftUI

struct Reporte: Identifiable {
    let id = UUID()
    let nombre: String
    let fecha: String
    let monto: Double
}

struct ReporteItemView: View {

    let reporte: Reporte

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {

            Text("Producto: \(reporte.nombre)")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)

            Text("Fecha: \(reporte.fecha)")
                .font(.system(size: 14))
                .foregroundColor(.white)

            Text("Monto: S/ \(String(format: "%.2f", reporte.monto))")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color.AzulOscuro)
        .cornerRadius(12)
        .shadow(radius: 6)
        .padding(.horizontal, 8)
        .padding(.bottom, 12)
    }
}
