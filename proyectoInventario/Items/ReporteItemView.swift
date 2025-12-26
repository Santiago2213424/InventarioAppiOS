import SwiftUI

struct ReporteItemView: View {

    let reporte: Reporte

    // Formatter reutilizable
    private var fechaFormateada: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_PE")
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: reporte.fecha)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {

            Text("Detalle: \(reporte.detalle)")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)

            Text("Fecha: \(fechaFormateada)")
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
