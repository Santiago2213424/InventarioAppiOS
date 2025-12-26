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

    func existeProducto(nombre: String, categoriaId: String) -> Bool {
        let nombreNormalizado = nombre
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        return productos.contains {
            $0.categoriaId == categoriaId &&
            $0.nombre.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == nombreNormalizado
        }
    }

    func agregarProducto(_ producto: Producto) {

        if existeProducto(nombre: producto.nombre, categoriaId: producto.categoriaId) {
            errorMessage = "Ya existe un producto con ese nombre en esta categoría"
            return
        }

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

        let nombreNormalizado = producto.nombre
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        let duplicado = productos.contains {
            $0.id != producto.id &&
            $0.categoriaId == producto.categoriaId &&
            $0.nombre.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == nombreNormalizado
        }

        if duplicado {
            errorMessage = "Ya existe otro producto con ese nombre en esta categoría"
            return
        }

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
