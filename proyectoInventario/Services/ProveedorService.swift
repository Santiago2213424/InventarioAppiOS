import FirebaseFirestore

class ProveedorService: BaseService {

    private let collection = "proveedores"

    func obtenerProveedores(
        completion: @escaping (Result<[Proveedor], Error>) -> Void
    ) {
        userCollection(collection).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            let proveedores = snapshot?.documents.compactMap {
                try? $0.data(as: Proveedor.self)
            } ?? []

            completion(.success(proveedores))
        }
    }

    func agregarProveedor(
        _ proveedor: Proveedor,
        completion: @escaping (Error?) -> Void
    ) {
        do {
            try userCollection(collection)
                .document(proveedor.id)
                .setData(from: proveedor)
            completion(nil)
        } catch {
            completion(error)
        }
    }

    func eliminarProveedor(
        id: String,
        completion: @escaping (Error?) -> Void
    ) {
        userCollection(collection)
            .document(id)
            .delete(completion: completion)
    }
    
    func actualizarProveedor(
        _ proveedor: Proveedor,
        completion: @escaping (Error?) -> Void
    ) {
        do {
            try userCollection(collection)
                .document(proveedor.id)
                .setData(from: proveedor)
            completion(nil)
        } catch {
            completion(error)
        }
    }

}
