import SwiftUI

struct ProveedoresView: View {
    
    let proveedores = [
        ("Proveedor San Jorge", "987654321"),
        ("Distribuidora Lima", "912345678"),
        ("Bodega Central", "934567890"),
        ("Mayorista Norte", "956789012"),
        ("Proveedor Express", "978901234")
    ]

    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {

                VStack {
                    Text("🏪 PROVEEDORES")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(16)
                        .frame(maxWidth: .infinity)
                }
                .background(Color.AzulOscuro)
                .cornerRadius(12)
                .shadow(radius: 6)
                .padding(.horizontal, 25)
                .padding(.top, 16)

                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(proveedores, id: \.0) { proveedor in
                            ProveedorItemView(
                                nombre: proveedor.0,
                                numero: proveedor.1
                            )
                        }
                        Spacer(minLength: 80)
                    }
                    .padding(16)
                }
            }
            .frame(maxWidth: 370)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            NavigationLink {
                AgregarProveedorView()
            } label: {
                Image(systemName: "plus")
            }
        }
    }
}
struct ProveedoresView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProveedoresView()
        }
    }
}
