//
//  ContentView.swift
//  PhotoGallery
//
//  Created by bubblecocoa on 12/18/23.
//

import SwiftUI

struct ContentView: View {
    private static let initailColumns = 4
    
    @State private var gridColumns = Array(repeating: GridItem(.flexible(), spacing: 1), count: initailColumns)
    
    var body: some View {
        VStack {
            // 선택된 이미지 영역
            Rectangle()
            
            // 사진(이미지)들
            ScrollView {
                LazyVGrid(columns: gridColumns, spacing: 1) {
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
            .padding([.leading, .trailing], 10)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button {
                        changeColumns(3)
                    } label: {
                        Text("3개로 보기")
                    }
                    
                    Button {
                        changeColumns(4)
                    } label: {
                        Text("4개로 보기")
                    }
                    
                    Button {
                        changeColumns(5)
                    } label: {
                        Text("5개로 보기")
                    }
                } label: {
                    Image(systemName: "circle.grid.3x3.circle")
                }

            }
        }
    }
    
    private func changeColumns(_ count: Int) {
        withAnimation {
            gridColumns = Array(repeating: GridItem(.flexible(), spacing: 1), count: count)
        }
    }
}

#Preview {
    ContentView()
}
