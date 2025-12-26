import Foundation

class ProveedorViewModel: ObservableObject {

    @Published var proveedores: [Proveedor] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = ProveedorService()

    func cargarProveedores() {
        isLoading = true
        errorMessage = nil

        service.obtenerProveedores { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false

                switch result {
                case .success(let proveedores):
                    self?.proveedores = proveedores
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func agregarProveedor(_ proveedor: Proveedor) {
        service.agregarProveedor(proveedor) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.cargarProveedores()
                }
            }
        }
    }

    func eliminarProveedor(id: String) {
        service.eliminarProveedor(id: id) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.proveedores.removeAll { $0.id == id }
                }
            }
        }
    }
}
