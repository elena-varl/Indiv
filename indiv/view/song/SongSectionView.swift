//
//  SongSectionView.swift
//  indiv
//
//  Created by AIR on 05.01.2024.
//

import SwiftUI

struct SongSectionView: View {
    let songs: [Song]
    let rows = Array (repeating: GridItem(.fixed(60), spacing: 0, alignment: .leading), count:4 )
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows,  spacing: 15) {
                ForEach(songs) {
                    song in
                    SongRowView(song: song)
                        .frame(width: 300)
                    
                }
            }
            .padding([.horizontal, .bottom])
        }
        
    }
}

struct SongSectionView_Previews: PreviewProvider {
    static var previews: some View {
        SongSectionView(songs: [Song.example()])
    }
}
