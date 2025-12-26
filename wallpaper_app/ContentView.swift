import SwiftUI

import Foundation
import SwiftUI
import Combine


struct ContentView: View {
    
    let imageURL = URL(string: "https://pixabay.com/images/download/jingle-bells-9924928_1920.jpg")!
    
    let downloadUrl =
    "http://localhost:5001/download/224.png"
//    "https://pixabay.com/images/download/jingle-bells-9924928_1920.jpg"
//    "https://publications.gbdirect.co.uk/c_book/thecbook.pdf"
//    "https://raw.githubusercontent.com/PicoTrex/Awesome-Nano-Banana-images/refs/heads/main/images/case103/output.jpg"
    
    var body: some View {
        VStack {
            Button("DDDDDDD"){
//                let www = Wallpaper(id: UUID(), url: URL(string: "http://localhost:5001/download/1000.png")!)
//                
//                
//                let dm = DownloadManager()
//                dm.downloadWallpaper(www){
//                    print("Completed....")
//                }
                
            }
            Button("Download"){
                let downloadTask = DownloadTask()
                downloadTask.download(url:  downloadUrl) { totalDownloaded in
                 print(totalDownloaded)
                }
            }
            
            Button("Download 1"){
//                let downloadTask = ImageDownloadService1()
//                downloadTask.downloadImage(from: URL(string: downloadUrl)!)
            }
        }
        
        
    }
}



#Preview {
    ContentView()
}
