//
//  LocalSaveService.swift
//  wallpaper_app
//
//  Created by PropertyShare on 26/12/25.
//


import SwiftUI
import Photos

final class LocalSaveService: NSObject {
    
    static let shared = LocalSaveService()
    private override init() {}
    
    func saveImage(_ image: UIImage, completion: @escaping (Bool, Error?) -> Void) {
        saveToPhotos(image: image, completion: completion)
    }
    
    // MARK: - Private Methods
    
    /// Check and request photo library permission if needed
     func checkPermission(completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized, .limited:
            completion(true)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                DispatchQueue.main.async {
                    completion(newStatus == .authorized || newStatus == .limited)
                }
            }
        default:
            // .denied, .restricted
            completion(false)
        }
    }
    
    /// Save UIImage to Photos
    private func saveToPhotos(image: UIImage, completion: @escaping (Bool, Error?) -> Void) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompletion(_:didFinishSavingWithError:contextInfo:)), Unmanaged.passRetained(CallbackWrapper(completion)).toOpaque())
    }
    
    @objc private func saveCompletion(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            let callbackWrapper = Unmanaged<CallbackWrapper>.fromOpaque(contextInfo).takeRetainedValue()
            callbackWrapper.completion(error == nil, error)
        }
    
    /// Helper class to retain completion block
    private class CallbackWrapper {
        let completion: (Bool, Error?) -> Void
        init(_ completion: @escaping (Bool, Error?) -> Void) {
            self.completion = completion
        }
    }
}
