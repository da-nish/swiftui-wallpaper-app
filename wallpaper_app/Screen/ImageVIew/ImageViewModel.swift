//
//  ImageViewModel.swift
//  wallpaper_app
//
//  Created by PropertyShare on 25/12/25.
//

import CoreFoundation
import Foundation


class ImageViewModel: ObservableObject{
    
//    @Published var progress: CGFloat = 0.0
    let dd = ImageDownloadService1()
    
    func startDownload(_ image: ImageDownloadState) {
        
//        LocalSaveService.shared.checkPermission{ hasPermission in
//            if hasPermission{
                self.dd.downloadImage(
                    image: image,
                    onStart: { value in
                        DispatchQueue.main.async {
                            image.isInProgress = true
                        }
                    },
                    onChange: { value in
                        DispatchQueue.main.async{
                            image.downloadProgress = Float(value)
                        }
                    },
                    onComplete: { img in
                        DispatchQueue.main.async {
                            image.isDownloaded = true
                            image.isInProgress = false
                            image.downloadProgress = 1.0
                        }
                        LocalSaveService.shared.saveImage(img){result, error in
                            print("res: \(result)")
                            print("err: \(error)")
                        }
                        print("calling service 2")
                        try? WallpaperDownloadService.shared.saveImage(img, wallpaperID: String(image.imageId))

                    }
                )
                
//            }
//            else{
//                print("Don't have permssion")
//            }
//        }

        
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
