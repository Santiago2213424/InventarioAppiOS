import Foundation

struct Reporte: Identifiable, Codable, Hashable {
    let id: String
    let detalle: String
    let fecha: Date
    let monto: Double

    init(
        id: String = UUID().uuidString,
        detalle: String,
        fecha: Date,
        monto: Double
    ) {
        self.id = id
        self.detalle = detalle
        self.fecha = fecha
        self.monto = monto
    }
}
