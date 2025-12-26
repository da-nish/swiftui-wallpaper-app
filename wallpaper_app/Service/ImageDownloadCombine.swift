

import Foundation
import SwiftUI
import Combine

class ImageDownloadService1: NSObject, ObservableObject, URLSessionDownloadDelegate {
//    @Published var downloadedImage: UIImage?
//    @Published var downloadProgress: Float = 0.0
    private var cancellables = Set<AnyCancellable>()
    
    private var session: URLSession?
//    private var imageState: ImageDownloadState?
    var onStart: ((Bool) -> Void)?
    var onChange: ((Float) -> Void)?
    var onComplete: ((UIImage) -> Void)?
    
    // Download image with progress tracking
    func downloadImage(image: ImageDownloadState, onStart: @escaping (Bool) -> Void, onChange: @escaping  (Float) -> Void, onComplete: @escaping  (UIImage) -> Void) {
//        self.imageState = image
        
        self.onStart = onStart
        self.onChange = onChange
        self.onComplete = onComplete
        
        onStart(true)
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        self.session = session

        
        let downloadTask = session.downloadTask(with: image.downloadUrl)
        downloadTask.resume()
    }

    // Delegate method to track progress
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        // Calculate progress
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
//        downloadProgress = progress
        
        onChange?(progress)
        
        // Optional: You can debug and print progress here
//        print("Download Progress: \(progress * 100)%", Double(progress*10))
    }

    // Delegate method when download completes
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        // Convert downloaded file to UIImage
        
        print("Download completed")
        
        
        if let data = try? Data(contentsOf: location), let image = UIImage(data: data) {
//            downloadedImage = image
            onComplete?(image)
        }
    }
}



//class ImageDownloadService1: NSObject, ObservableObject, URLSessionDownloadDelegate {
//    @Published var downloadedImage: UIImage?
//    @Published var downloadProgress: Float = 0.0
//    private var cancellables = Set<AnyCancellable>()
//    
//    private var session: URLSession?
//    
//    // Download image with progress tracking
//    func downloadImage(from url: URL) {
//        let configuration = URLSessionConfiguration.default
//        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
//        self.session = session
//        
//        let downloadTask = session.downloadTask(with: url)
//        downloadTask.resume()
//    }
//
//    // Delegate method to track progress
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
//        // Calculate progress
//        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
//        downloadProgress = progress
//        
//        // Optional: You can debug and print progress here
//        print("Download Progress: \(progress * 100)%")
//    }
//
//    // Delegate method when download completes
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//        // Convert downloaded file to UIImage
//        print("Download completed")
////        if let data = try? Data(contentsOf: location), let image = UIImage(data: data) {
////            downloadedImage = image
////        }
//    }
//}
