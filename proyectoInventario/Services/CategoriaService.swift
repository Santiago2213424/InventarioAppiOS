import FirebaseFirestore

class CategoriaService: BaseService {

    private let collection = "categorias"

    func fetchCategorias(
        completion: @escaping (Result<[Categoria], Error>) -> Void
    ) {
        userCollection(collection).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            let categorias = snapshot?.documents.compactMap {
                try? $0.data(as: Categoria.self)
            } ?? []

            completion(.success(categorias))
        }
    }

    func addCategoria(
        _ categoria: Categoria,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        do {
            try userCollection(collection)
                .document(categoria.id)
                .setData(from: categoria)
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }

    func updateCategoria(
        _ categoria: Categoria,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        do {
            try userCollection(collection)
                .document(categoria.id)
                .setData(from: categoria, merge: true)
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }

    func deleteCategoria(
        id: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        userCollection(collection)
            .document(id)
            .delete { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }
}
