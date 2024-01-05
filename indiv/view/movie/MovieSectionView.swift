//
//  MovieSectionView.swift
//  indiv
//
//  Created by AIR on 05.01.2024.
//

import SwiftUI

struct MovieSectionView: View {
    let movies: [Movie]
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack() {
                ForEach(movies){
                    movie in
                    Text(movie.trackName)
                     
                }
            }
        }
    }
}

struct MovieSectionView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSectionView(movies: [Movie.example()])
    }
}
