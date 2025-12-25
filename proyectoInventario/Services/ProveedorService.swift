import FirebaseFirestore

class ProveedorService {

    private let db = Firestore.firestore()
    private let collection = "proveedores"

    func obtenerProveedores(
        completion: @escaping (Result<[Proveedor], Error>) -> Void
    ) {
        db.collection(collection)
            .getDocuments { snapshot, error in

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

    func agregarProveedor(_ proveedor: Proveedor, completion: @escaping (Error?) -> Void) {
        do {
            try db.collection(collection)
                .document(proveedor.id)
                .setData(from: proveedor)
            completion(nil)
        } catch {
            completion(error)
        }
    }
}
