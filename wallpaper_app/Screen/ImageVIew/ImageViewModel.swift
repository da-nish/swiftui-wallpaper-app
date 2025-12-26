//
//  ImageViewModel.swift
//  wallpaper_app
//
//  Created by PropertyShare on 25/12/25.
//

import CoreFoundation
import Foundation


class ImageViewModel: ObservableObject{
    
    @Published var progress: CGFloat = 0.0
    let dd = ImageDownloadService1()
    
    func startDownload(_ image: ImageDownloadState) {

        dd.downloadImage(image: image,){ value in
            DispatchQueue.main.async{
                image.downloadProgress = Float(value)
            }
        }
        
//        progress = 0.0 // Reset progress
//        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
//            if self.progress >= 1.0 {
//                timer.invalidate() // Stop the timer when progress is 100%
//            } else {
//                self.progress += 0.013517792 // Increase progress
//                print("progres: \(Float(self.progress))")
//                image.downloadProgress = Float(self.progress)
//            }
//        }
    }
    
    
}
