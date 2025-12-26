//
//  DownloadManager.swift
//  wallpaper_app
//
//  Created by PropertyShare on 25/12/25.
//


import Foundation
import Combine

class DownloadManager: ObservableObject {
    func downloadWallpaper(_ imageState: ImageDownloadState, completion: @escaping () -> Void) {
        let url = imageState.imageUrl
        
        // Sample download using URLSession
        let task = URLSession.shared.downloadTask(with: url) { (location, response, error) in
            guard let _ = location else { return }
            DispatchQueue.main.async {
                imageState.isDownloaded = true
                imageState.downloadProgress = 1.0
                completion()
            }
        }
        
        // Monitor progress using the URLSession delegate
        task.observe(\.countOfBytesReceived, options: .new) { (task, change) in
//            guard let expectedLength = task.countOfBytesExpectedToReceive else { return }
            
            print("progess---")
            let expectedLength = task.countOfBytesExpectedToReceive
            guard expectedLength > 0 else { return }  // Ensure we have a valid expected length
                        
            let currentProgress = Float(task.countOfBytesReceived) / Float(expectedLength)
            print("progess: \(currentProgress)")
            DispatchQueue.main.async {
                imageState.downloadProgress = currentProgress
            }
        }
        
        task.resume()
    }
}




class Wallpaper: Identifiable, ObservableObject {
    var id: UUID
    var url: URL
    @Published var downloadProgress: Double = 0.0  // Progress (0.0 to 1.0)
    @Published var isDownloaded: Bool = false  // Flag to check if it's downloaded
    
    init(id: UUID, url: URL) {
        self.id = id
        self.url = url
    }
}


