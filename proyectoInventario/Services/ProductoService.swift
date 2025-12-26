import FirebaseFirestore

class ProductoService: BaseService {

    private let collection = "productos"

    func obtenerProductos(
        completion: @escaping (Result<[Producto], Error>) -> Void
    ) {
        userCollection(collection).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            let productos = snapshot?.documents.compactMap {
                try? $0.data(as: Producto.self)
            } ?? []

            completion(.success(productos))
        }
    }

    func agregarProducto(
        _ producto: Producto,
        completion: @escaping (Error?) -> Void
    ) {
        do {
            try userCollection(collection)
                .document(producto.id)
                .setData(from: producto)
            completion(nil)
        } catch {
            completion(error)
        }
    }

    func eliminarProducto(
        id: String,
        completion: @escaping (Error?) -> Void
    ) {
        userCollection(collection)
            .document(id)
            .delete(completion: completion)
    }
}
