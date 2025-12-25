import Foundation
import FirebaseFirestore

struct Proveedor: Identifiable, Codable, Hashable {
    let id: String
    let nombre: String
    let telefono: String

    init(
        id: String = UUID().uuidString,
        nombre: String,
        telefono: String
    ) {
        self.id = id
        self.nombre = nombre
        self.telefono = telefono
    }
}
