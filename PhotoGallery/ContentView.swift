//
//  ContentView.swift
//  PhotoGallery
//
//  Created by bubblecocoa on 12/18/23.
//

import SwiftUI

struct ContentView: View {
    private static let initailColumns = 4
    
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: initailColumns)
    
    var body: some View {
        VStack {
            // 선택된 이미지 영역
            Rectangle()
            
            // 사진(이미지)들
            ScrollView {
                LazyVGrid(columns: gridColumns) {
                    ForEach((1...100), id: \.self) { number in
                        Button {
                            
                        } label: {
                            Rectangle()
                                .fill()
                                .aspectRatio(contentMode: .fill)
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
