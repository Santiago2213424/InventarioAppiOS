import SwiftUI

struct ProductoView: View {

    let categoria: String

    let productos: [Producto] = [
        Producto(nombre: "Arroz Costeño", cantidad: 10, precio: 4.50, categoriaId: "Abarrotes"),
        Producto(nombre: "Azúcar Rubia", cantidad: 6, precio: 3.20, categoriaId: "Abarrotes"),
        Producto(nombre: "Aceite Primor", cantidad: 4, precio: 9.90, categoriaId: "Abarrotes"),
        Producto(nombre: "Fideos Don Vittorio", cantidad: 12, precio: 2.80, categoriaId: "Abarrotes")
    ]

    @State private var productoSeleccionado: Producto?

    var body: some View {
        NavigationStack {
            ZStack {

                Image("fondologin")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(spacing: 12) {

                    Text("📦 \(categoria)")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity)
                        .background(Color.AzulOscuro)
                        .cornerRadius(12)
                        .padding(.horizontal, 12)
                        .padding(.top, 12)

                    ScrollView {
                        VStack(spacing: 8) {

                            ForEach(productos.filter { $0.categoriaId == categoria }) { producto in
                                ProductoItemView(
                                    nombre: producto.nombre,
                                    cantidad: producto.cantidad,
                                    precio: producto.precio,
                                    categoria: producto.categoriaId,
                                    mostrarAcciones: true,
                                    onEditar: {
                                        productoSeleccionado = producto
                                    }
                                )
                            }

                            Spacer(minLength: 80)
                        }
                        .padding(.horizontal, 8)
                    }
                }
                .frame(maxWidth: 370)
            }
            .navigationDestination(item: $productoSeleccionado) { producto in
                EditarProductoView(
                    nombre: producto.nombre,
                    cantidad: producto.cantidad,
                    precio: producto.precio
                )
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProductoView_Previews: PreviewProvider {
    static var previews: some View {
        ProductoView(categoria: "Abarrotes")
    }
}

