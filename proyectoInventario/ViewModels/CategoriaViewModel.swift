import Foundation

class CategoriaViewModel: ObservableObject {

    @Published var categorias: [Categoria] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = CategoriaService()

    func cargarCategorias() {
        isLoading = true
        errorMessage = nil

        service.fetchCategorias { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false

                switch result {
                case .success(let categorias):
                    self?.categorias = categorias

                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func agregarCategoria(nombre: String) {
        let nuevaCategoria = Categoria(nombre: nombre)

        service.addCategoria(nuevaCategoria) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.cargarCategorias() // refrescar lista

                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func eliminarCategoria(id: String) {
        service.deleteCategoria(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.categorias.removeAll { $0.id == id }

                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func actualizarCategoria(_ categoria: Categoria) {
        service.updateCategoria(categoria) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.cargarCategorias()

                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

}
