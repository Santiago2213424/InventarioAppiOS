import FirebaseAuth
import FirebaseFirestore

class BaseService {
    let db = Firestore.firestore()

    var userId: String {
        guard let uid = Auth.auth().currentUser?.uid else {
            fatalError("Usuario no autenticado")
        }
        return uid
    }

    func userCollection(_ name: String) -> CollectionReference {
        db.collection("users")
            .document(userId)
            .collection(name)
    }
}
