//
//  CardView.swift
//  wallpaper_app
//
//  Created by PropertyShare on 25/12/25.
//

import SwiftUICore
import SwiftUI



struct CardView: View{
//    let imageItem: ImageDownloadState
    @ObservedObject var imageItem: ImageDownloadState
    init(imageItem: ImageDownloadState) {
        self.imageItem = imageItem
    }
    
    var body: some View{
        ZStack(alignment: .topTrailing){
            
            AsyncImage(url: imageItem.imageUrl) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 160)
                        .cornerRadius(20)
                } else {
                    ProgressView()
                        .frame(width: 160, height: 160)
                        .cornerRadius(20)
                }
            }
            HStack{
                
                if imageItem.isDownloaded || imageItem.isInProgress{
                    CircularProgressView(
                        progress: $imageItem.downloadProgress,
                        isDownloaded: $imageItem.isDownloaded
                    )
                    .padding(.trailing, 4)
                    .padding(.top, 4)
                    .frame(width: 30, height: 30)
                }
                
            }
            
        }
        
    }
}


#Preview {
    CardView(
        imageItem: ImageDownloadState(
            imageId: 1,
            imageUrl:
                URL(string: "http://localhost:5001/generated_image/100.png")!,
            downloadUrl: URL(string: "http://localhost:5001/download/190.png")!
        
        )
    )
}
