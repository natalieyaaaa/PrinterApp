import SwiftUI
import UIKit

struct VView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?

    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            } else {
                Text("No image selected")
                    .foregroundColor(.gray)
            }
            Button(action: {
                self.showImagePicker = true
            }) {
                Text("Select Photo")
            }
        }
        .sheet(isPresented: $showImagePicker) {
            CustomImagePicker(selectedImage: self.$selectedImage, isPresented: self.$showImagePicker)
        }
    }
}

struct CustomImagePicker: View {
    @Binding var selectedImage: UIImage?
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            ImagePicker(selectedImage: self.$selectedImage, isPresented: self.$isPresented)
            Button(action: {
                self.isPresented = false // Close the picker
            }) {
                Text("Add")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isPresented: Bool

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = pickedImage
            }
        }
    }
}

#Preview {
    VView()
}
