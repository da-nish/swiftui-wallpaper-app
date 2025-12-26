//
//  ImageViewScreen.swift
//  wallpaper_app
//
//  Created by PropertyShare on 25/12/25.
//


import SwiftUI

struct ImageViewScreen: View {
    @StateObject var viewModel = ImageViewModel()
//    @Binding var imageItem: ImageDownloadState
    @ObservedObject var imageItem: ImageDownloadState
    init(imageItem: ImageDownloadState) {
        self.imageItem = imageItem
    }
    

    var body: some View {
        ZStack {
            // Fullscreen background image
            AsyncImage(url: imageItem.imageUrl) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                } else {
                    ProgressView()
                        .frame(width: 300, height: 300)
                        .cornerRadius(20)
                }
            }
            VStack {
                
                Spacer()
                HStack{
                    Spacer()
                    if imageItem.isInProgress || imageItem.isDownloaded{
                        CircularProgressView(
                            progress: $imageItem.downloadProgress,
                            isDownloaded: $imageItem.isDownloaded
                        )
                        .padding(.trailing, 20)
                    }
                    else{
                        DownloadButton{
                            print("Download tapped")
                            viewModel.startDownload(imageItem)
                        }
                        
                    }
                    
                    
                }
            }
            .padding()
        }
//        .navigationBarHidden(true)
//        .navigationTitle("Image View")
        .navigationBarBackButtonHidden(false)
        
    }
}
#Preview {
    ImageViewScreen(
        imageItem: ImageDownloadState(
            imageId: 1,
            imageUrl:
                URL(string: "http://localhost:5001/generated_image/100.png")!,
            downloadUrl: URL(string: "http://localhost:5001/download/190.png")!
        
        )
    )
}

