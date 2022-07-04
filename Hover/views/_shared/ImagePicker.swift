//
//  ImagePicker.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 03/07/22.
//

import Foundation
import SwiftUI

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var isShown: Bool
    @Binding var imageUrl: String
    
    init(isShown: Binding<Bool>, imageUrl: Binding<String>) {
        _isShown = isShown
        _imageUrl = imageUrl
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        // ini harus pake save image to directory
        // Obtaining the Location of the Documents Directory
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let fileName = "\(dateToString(Date.now, dateFormat: "YYYY-MM-DD-HH:mm:ss.SSSS")).png"

        // Create URL
        let url = documents.appendingPathComponent(fileName)
        // Convert to Data
        if let data = uiImage.jpegData(compressionQuality: 1) {
            do {
                try data.write(to: url)
            } catch {
                print("Unable to Write Image Data to Disk")
            }
        }

        isShown = false
        imageUrl = url.path
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var isShown: Bool
    @Binding var imageUrl: String
    
    var pickerMode: Int = 0 // 0 -> album, 1 -> camera
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(isShown: $isShown, imageUrl: $imageUrl)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        // if preview, show gallery view instead of camera view
        if pickerMode == 1 {
            picker.sourceType = .camera
        }
        return picker
    }
}

