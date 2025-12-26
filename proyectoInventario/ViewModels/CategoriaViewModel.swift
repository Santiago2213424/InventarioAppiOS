import Foundation

class CategoriaViewModel: ObservableObject {

    @Published var categorias: [Categoria] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = CategoriaService()

    // validar si categoria existe
    private func existeCategoriaConNombre(_ nombre: String) -> Bool {
        let nombreNormalizado = nombre
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        return categorias.contains {
            $0.nombre.trimmingCharacters(in: .whitespacesAndNewlines)
                .lowercased() == nombreNormalizado
        }
    }

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

        let nombreLimpio = nombre
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard !nombreLimpio.isEmpty else {
            errorMessage = "El nombre no puede estar vacío"
            return
        }

        guard !existeCategoriaConNombre(nombreLimpio) else {
            errorMessage = "Ya existe una categoría con ese nombre"
            return
        }

        let nuevaCategoria = Categoria(nombre: nombreLimpio)

        service.addCategoria(nuevaCategoria) { [weak self] result in
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

        guard !existeCategoriaConNombre(categoria.nombre) else {
            errorMessage = "Ya existe una categoría con ese nombre"
            return
        }

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
