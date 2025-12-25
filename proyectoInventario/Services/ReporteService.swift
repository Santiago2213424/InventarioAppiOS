import FirebaseFirestore
import FirebaseAuth

class ReporteService {

    private let db = Firestore.firestore()
    private let collection = "reportes"

    func obtenerReportesUsuario(
        completion: @escaping (Result<[Reporte], Error>) -> Void
    ) {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        db.collection(collection)
            .whereField("userId", isEqualTo: userId)
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

    func agregarReporte(_ reporte: Reporte, completion: @escaping (Error?) -> Void) {
        do {
            try db.collection(collection)
                .document(reporte.id)
                .setData(from: reporte)
            completion(nil)
        } catch {
            completion(error)
        }
    }
}
