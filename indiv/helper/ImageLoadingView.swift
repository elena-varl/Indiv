//
//  ImageLoadingView.swift
//  indiv
//
//  Created by AIR on 05.01.2024.
//

import SwiftUI

struct ImageLoadingView: View {
        
        let urlString: String
        let size: CGFloat
        
        var body: some View {
            AsyncImage(url: URL(string: urlString)) {
                phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: size)
                case .failure(let error):
                    Color.gray
                        .frame(width: size)
                case .success(let image):
                    image
                      
                        .border(Color(white: 0.8))
                        
                @unknown default:
                    EmptyView()
                }
            }
           
            .frame(width: size, height: size)
        }
    }


struct ImageLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoadingView(urlString: "", size: 100)
    }
}
