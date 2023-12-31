//
//  ContentView.swift
//  PhotoGallery
//
//  Created by bubblecocoa on 12/18/23.
//

import SwiftUI
import Photos

struct ContentView: View {
    private static let initailColumns = 4
    
    @State private var numberOfColuns = initailColumns
    @State private var gridColumns = Array(repeating: GridItem(.flexible(), spacing: 1), count: initailColumns)
    
    @State private var images: [UIImage] = []
    @State private var previewImage: UIImage?
    
    var body: some View {
        VStack {
            // 선택된 이미지 영역
            if let previewImage {
                Image.init(uiImage: previewImage)
                    .resizable()
            }
            
            // 사진(이미지)들
            ScrollView {
                LazyVGrid(columns: gridColumns, spacing: 1) {
                    ForEach(images, id: \.self) { image in
                        Button {
                            previewImage = image
                        } label: {
                            GeometryReader { geometry in
                                Image(uiImage: image)
                                    .resizable()
                            }
                            .aspectRatio(contentMode: .fill) // 정사각 형태
                        }
                    }
                }
            }
            .padding([.leading, .trailing], 10)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    ForEach((3...5), id: \.self) { number in
                        if numberOfColuns != number {
                            Button {
                                changeColumns(number)
                            } label: {
                                Text("\(number)개로 보기")
                            }
                        }
                    }
                } label: {
                    Image(systemName: "circle.grid.3x3.circle")
                }

            }
        }
        .onAppear {
            loadImages()
        }
    }
    
    private func changeColumns(_ count: Int) {
        withAnimation {
            numberOfColuns = count
            gridColumns = Array(repeating: GridItem(.flexible(), spacing: 1), count: count)
        }
    }
    
    private func loadImages() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            if status == .authorized {
                let fetchOptions = PHFetchOptions()
                fetchOptions.sortDescriptors = [
                    NSSortDescriptor(key: "creationDate", ascending: false) // 최근 사진 순 정렬
                ]
                
                let imageAssets = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                
                imageAssets.enumerateObjects { asset, _, _ in
                    let requestOptions = PHImageRequestOptions()
                    requestOptions.isSynchronous = true
                    
                    PHImageManager.default().requestImage(
                        for: asset,
                        targetSize: PHImageManagerMaximumSize,
                        contentMode: .aspectFit,
                        options: requestOptions
                    ) { image, _ in
                        if let image {
                            images.append(image)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
