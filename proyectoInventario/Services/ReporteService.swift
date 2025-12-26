import FirebaseFirestore

class ReporteService: BaseService {

    private let collection = "reportes"

    func obtenerReportes(
        completion: @escaping (Result<[Reporte], Error>) -> Void
    ) {
        userCollection(collection)
            .order(by: "fecha", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                let reportes = snapshot?.documents.compactMap {
                    try? $0.data(as: Reporte.self)
                } ?? []

                completion(.success(reportes))
            }
    }

    func agregarReporte(
        _ reporte: Reporte,
        completion: @escaping (Error?) -> Void
    ) {
        do {
            try userCollection(collection)
                .document(reporte.id)
                .setData(from: reporte)
            completion(nil)
        } catch {
            completion(error)
        }
    }
}
