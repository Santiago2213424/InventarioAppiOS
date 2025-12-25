import Foundation
import FirebaseFirestore

struct Producto: Identifiable, Codable, Hashable {
    let id: String
    let nombre: String
    let cantidad: Int
    let precio: Double
    let categoriaId: String

    init(
        id: String = UUID().uuidString,
        nombre: String,
        cantidad: Int,
        precio: Double,
        categoriaId: String
    ) {
        self.id = id
        self.nombre = nombre
        self.cantidad = cantidad
        self.precio = precio
        self.categoriaId = categoriaId
    }
}
