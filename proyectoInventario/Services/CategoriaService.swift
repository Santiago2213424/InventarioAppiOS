import FirebaseFirestore

class CategoriaService {

    private let db = Firestore.firestore()
    private let collection = "categorias"

    func fetchCategorias(
        completion: @escaping (Result<[Categoria], Error>) -> Void
    ) {
        db.collection(collection).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            let categorias = snapshot?.documents.compactMap { doc -> Categoria? in
                try? doc.data(as: Categoria.self)
            } ?? []

            completion(.success(categorias))
        }
    }

    func addCategoria(
        _ categoria: Categoria,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        do {
            try db.collection(collection)
                .document(categoria.id)
                .setData(from: categoria)

            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }

    func deleteCategoria(
        id: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        db.collection(collection).document(id).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func updateCategoria(
        _ categoria: Categoria,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        do {
            try db.collection(collection)
                .document(categoria.id)
                .setData(from: categoria, merge: true)

            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }

}
