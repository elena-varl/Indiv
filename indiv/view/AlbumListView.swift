//
//  AlbumListView.swift
//  indiv
//
//  Created by AIR on 04.01.2024.
//

import SwiftUI

struct AlbumListView: View {
    
    @ObservedObject var viewModel: AlbumListViewModel
    
    var body: some View {
       
            List{
                
            ForEach(viewModel.albums){
            album in Text(album.collectionName)
            }
                switch viewModel.state {
                case .good:
                    Color.clear
                        .onAppear {
                            viewModel.LoadMore()
                            
                }
                case .isLoading:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(maxWidth: .infinity)
                case .loadedAll:
                    EmptyView()
                    //Color.gray
                case .error(let message):
                    Text(message)
                        .foregroundColor(.pink)
               
                }
                    
        }
        .listStyle(.plain)
     
    }
}

struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView(viewModel: AlbumListViewModel())
    }
}
