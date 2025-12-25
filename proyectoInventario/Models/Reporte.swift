import Foundation

struct Reporte: Identifiable, Codable, Hashable {
    let id: String
    let nombre: String
    let fecha: Date
    let monto: Double

    init(
        id: String = UUID().uuidString,
        nombre: String,
        fecha: Date,
        monto: Double
    ) {
        self.id = id
        self.nombre = nombre
        self.fecha = fecha
        self.monto = monto
    }
}
