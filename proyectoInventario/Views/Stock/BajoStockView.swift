import SwiftUI

struct BajoStockView: View {

    @Environment(\.dismiss) private var dismiss

    let productos: [Producto] = [
        Producto(nombre: "Azúcar Rubia", cantidad: 3, precio: 4.20, categoriaId: "Abarrotes"),
        Producto(nombre: "Aceite Cocinero", cantidad: 2, precio: 9.50, categoriaId: "Abarrotes"),
        Producto(nombre: "Leche Ideal", cantidad: 4, precio: 3.60, categoriaId: "Lácteos"),
        Producto(nombre: "Gaseosa Pepsi", cantidad: 1, precio: 2.30, categoriaId: "Bebidas")
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

                VStack {
                    Text("📉 BAJO STOCK")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity)
                        .background(Color.AzulOscuro)
                        .cornerRadius(12)
                        .padding(.horizontal, 12)
                        .padding(.top, 12)
                }

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
                if let Producto = productoSeleccionado {
                    EditarProductoView()
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BajoStockView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BajoStockView()
        }
    }
}
