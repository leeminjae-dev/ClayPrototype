
import SwiftUI
import FirebaseStorage
import Combine

struct ProfileImagePicker: UIViewControllerRepresentable {

    @Binding var shown: Bool
    @Binding var imageURL:String
    @State var isProfile : Bool = false
    func makeCoordinator() -> ProfileImagePicker.Coordinator {
        return ProfileImagePicker.Coordinator(parent: self)
    }
    
    class Coordinator: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        var parent: ProfileImagePicker
        let storage = Storage.storage().reference()
        init(parent: ProfileImagePicker) {
            self.parent = parent
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.shown.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            
            uploadProfileImageToFireBase(image: image)
        }
        
      
        
        func uploadProfileImageToFireBase(image: UIImage) {
            // Create the file metadata
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            // Upload the file to the path FILE_NAME
            storage.child(PROFILE_FILE_NAME).putData(image.jpegData(compressionQuality: 0.42)!, metadata: metadata) { (metadata, error) in
                guard let metadata = metadata else {
                  // Uh-oh, an error occurred!
                  print((error?.localizedDescription)!)
                  return
                }
                // Metadata contains file metadata such as size, content-type.
                let size = metadata.size
                
                print("Upload size is \(size)")
                print("Upload success")
                self.downloadProfileImageFromFirebase()
            }
        }
        
        
        func downloadProfileImageFromFirebase() {
            // Create a reference to the file you want to download
            storage.child(PROFILE_FILE_NAME).downloadURL { (url, error) in
                if error != nil {
                    // Handle any errors
                    print((error?.localizedDescription)!)
                    return
                }
                print("Download success")
                self.parent.imageURL = "\(url!)"
                self.parent.shown.toggle()
                
                self.listOfImageFile()
            }
        }
        
        func listOfImageFile() {
            let storageReference = Storage.storage().reference().child("images/")
            storageReference.listAll { (result, error) in
              if error != nil {
                  // Handle any errors
                  print((error?.localizedDescription)!)
                  return
              }
              for prefix in result.prefixes {
                // The prefixes under storageReference.
                // You may call listAll(completion:) recursively on them.
                print("prefix is \(prefix)")
              }
              for item in result.items {
                // The items under storageReference.
                print("items is \(item)")
              }
            }
        }
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ProfileImagePicker>) -> UIImagePickerController {
        let imagepic = UIImagePickerController()
        imagepic.sourceType = .photoLibrary
        imagepic.delegate = context.coordinator
        return imagepic
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ProfileImagePicker>) {
    }
}
