

import Foundation
import SwiftUI
import Combine

class ImageDownloadService1: NSObject, ObservableObject, URLSessionDownloadDelegate {
//    @Published var downloadedImage: UIImage?
//    @Published var downloadProgress: Float = 0.0
    private var cancellables = Set<AnyCancellable>()
    
    private var session: URLSession?
    private var imageState: ImageDownloadState?
    var onProgress: ((Float) -> Void)?
    
    // Download image with progress tracking
    func downloadImage(image: ImageDownloadState, onChange: ((Float) -> Void)?) {
        self.imageState = image
        self.onProgress = onChange
        DispatchQueue.main.async {
            self.imageState?.isInProgress = true
        }
        
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
        
        onProgress?(progress)
        
        // Optional: You can debug and print progress here
//        print("Download Progress: \(progress * 100)%", Double(progress*10))
    }

    // Delegate method when download completes
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        // Convert downloaded file to UIImage
        
        print("Download completed")
        
        DispatchQueue.main.async {
            self.imageState?.isDownloaded = true
            self.imageState?.isInProgress = false
            self.imageState?.downloadProgress = 1.0
        }
        onProgress?(1.0)
//        if let data = try? Data(contentsOf: location), let image = UIImage(data: data) {
//            downloadedImage = image
//        }
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
