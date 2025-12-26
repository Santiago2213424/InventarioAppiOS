import SwiftUI

struct ProveedorRowView: View {

    let proveedor: Proveedor
    let viewModel: ProveedorViewModel

    var body: some View {
        NavigationLink {
            EditarProveedorView(
                proveedor: proveedor,
                viewModel: viewModel
            )
        } label: {
            ProveedorItemView(
                nombre: proveedor.nombre,
                numero: proveedor.telefono
            )
        }
        .contextMenu {
            Button(role: .destructive) {
                viewModel.eliminarProveedor(id: proveedor.id)
            } label: {
                Label("Eliminar", systemImage: "trash")
            }
        }
    }
}
