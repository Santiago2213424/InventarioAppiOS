import SwiftUI

struct AltoStockView: View {

    let productos: [Producto] = [
        Producto(nombre: "Arroz Costeño", cantidad: 50, precio: 4.50, categoriaId: "Abarrotes"),
        Producto(nombre: "Leche Gloria", cantidad: 30, precio: 3.80, categoriaId: "Lácteos"),
        Producto(nombre: "Gaseosa Inca Kola", cantidad: 40, precio: 2.50, categoriaId: "Bebidas"),
        Producto(nombre: "Aceite Primor", cantidad: 25, precio: 9.90, categoriaId: "Abarrotes")
    ]

    @State private var productoSeleccionado: Producto?
    @State private var navegarEditar = false

    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 12) {

                Text("📈 ALTO STOCK")
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
                        ForEach(productos) { producto in
                            ProductoItemView(
                                nombre: producto.nombre,
                                cantidad: producto.cantidad,
                                precio: producto.precio,
                                categoria: producto.categoriaId,
                                mostrarAcciones: true,
                                onEditar: {
                                    productoSeleccionado = producto
                                    navegarEditar = true
                                }
                            )
                        }
                        Spacer(minLength: 80)
                    }
                    .padding(.horizontal, 8)
                }
            }
            .frame(maxWidth: 370)


            .navigationDestination(isPresented: $navegarEditar) {
                if let producto = productoSeleccionado {
                    EditarProductoView()
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct AltoStockView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AltoStockView()
        }
    }
}
