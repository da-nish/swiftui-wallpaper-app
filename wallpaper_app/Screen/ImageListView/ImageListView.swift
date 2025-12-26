//
//  ImageListView.swift
//  wallpaper_app
//
//  Created by PropertyShare on 24/12/25.
//

import SwiftUI

struct ImageListView: View {
    @StateObject var viewModel = ImageListViewModel()
    @State private var isLoading = false

    let columns: [GridItem] = [
        GridItem(.flexible()),  // 1st column
        GridItem(.flexible()),  // 2nd column
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.images, id: \.imageId) { item in
                        NavigationLink(destination: ImageViewScreen(imageItem: item) /*$viewModel.images[viewModel.images.firstIndex(where: { $0.imageId == item.imageId })!])*/
                        ) {
                            CardView(imageItem: item)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .onAppear {
                            if item.imageId == viewModel.images.last?.imageId {
                                loadMoreImagesIfNeeded()
                            }
                        }
                    }
                }
                .padding()
            }
            .task {
                await viewModel.loadImages()
            }
        }
    }
    
    private func loadMoreImagesIfNeeded() {
        guard !isLoading else { return }
        isLoading = true
        Task {
            await viewModel.loadImages()
            isLoading = false
        }
    }
}



#Preview {
    ImageListView()
}
