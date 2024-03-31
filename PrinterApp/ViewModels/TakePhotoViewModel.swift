import SwiftUI
import UIKit

struct SimpleCameraView: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var capturedImages: [UIImage]
    let onCompletion: (Result<[UIImage], Error>) -> Void
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                UIViewControllerWrapper(onCompletion: self.onCompletion, isPresented: self.$isPresented, capturedImages: self.$capturedImages)
            }
    }
}

struct UIViewControllerWrapper: UIViewControllerRepresentable {
    let onCompletion: (Result<[UIImage], Error>) -> Void
    @Binding var isPresented: Bool
    @Binding var capturedImages: [UIImage]
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = UIViewController()
        DispatchQueue.main.async {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            picker.sourceType = .camera
            viewController.present(picker, animated: true, completion: nil)
        }
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: UIViewControllerWrapper
        
        init(_ parent: UIViewControllerWrapper) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.capturedImages.append(uiImage) // Store the captured image in the array
            }
            parent.onCompletion(.success(parent.capturedImages)) // Pass the array in the completion handler
            parent.isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
}

extension View {
    func simpleCameraView(isPresented: Binding<Bool>, capturedImages: Binding<[UIImage]>, onCompletion: @escaping (Result<[UIImage], Error>) -> Void) -> some View {
        self.modifier(SimpleCameraView(isPresented: isPresented, capturedImages: capturedImages, onCompletion: onCompletion))
    }
}
