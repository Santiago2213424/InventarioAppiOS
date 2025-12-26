import Foundation

class ProductoViewModel: ObservableObject {

    @Published var productos: [Producto] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = ProductoService()

    func cargarProductos() {
        isLoading = true
        errorMessage = nil

        service.obtenerProductos { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let productos):
                    self?.productos = productos
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func agregarProducto(_ producto: Producto) {
        service.agregarProducto(producto) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.cargarProductos()
                }
            }
        }
    }

    func actualizarProducto(_ producto: Producto) {
        service.actualizarProducto(producto) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.cargarProductos()
                }
            }
        }
    }

    func eliminarProducto(id: String) {
        service.eliminarProducto(id: id) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.productos.removeAll { $0.id == id }
                }
            }
        }
    }
}
