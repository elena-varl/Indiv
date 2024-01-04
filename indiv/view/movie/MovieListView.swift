//
//  MovieListView.swift
//  indiv
//
//  Created by AIR on 04.01.2024.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject var viewModel: MovieListViewModel
    
    var body: some View {
       
            List{
                
                ForEach(viewModel.movies){
                    movie in Text(movie.trackName)
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

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(viewModel: MovieListViewModel())
    }
}
