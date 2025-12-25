import Foundation
import FirebaseFirestore

struct Categoria: Identifiable, Codable, Hashable {
    let id: String
    let nombre: String

    init(
        id: String = UUID().uuidString,
        nombre: String
    ) {
        self.id = id
        self.nombre = nombre
    }
}
