import Foundation

class ReporteViewModel: ObservableObject {

    @Published var reportes: [Reporte] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = ReporteService()

    func cargarReportes() {
        isLoading = true
        errorMessage = nil

        service.obtenerReportes { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false

                switch result {
                case .success(let reportes):
                    self?.reportes = reportes
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func agregarReporte(_ reporte: Reporte) {
        service.agregarReporte(reporte) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.cargarReportes()
                }
            }
        }
    }
}
