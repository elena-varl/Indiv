//
//  SongsForAlbumListView.swift
//  indiv
//
//  Created by AIR on 05.01.2024.
//

import SwiftUI

struct SongsForAlbumListView: View {
    
    @ObservedObject var songsViewModel: SongsForAlbumListViewModel
    
    var body: some View {
        ScrollView {
            if songsViewModel.state == .isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            else {
                
                VStack(alignment: .leading, spacing: 15) {
                    ForEach (songsViewModel.songs){
                        song in
                        HStack {
                            Text("\(song.trackNumber)")
                                .font(.footnote)
                                .frame(width: 25, alignment: .trailing)
                            Text(song.trackName)
                            
                            Spacer()
                            Text(formattedDuration(time: song.trackTimeMillis))
                                .font(.footnote)
                                .frame(width: 50, alignment: .trailing)
                            
                            BuySongButton(urlString: song.previewURL, price: song.trackPrice, currency: song.currency)
                            
                        }
                        .padding(.horizontal)
                        Divider()
                    }
                }
                .padding([.vertical, .leading])
            }
        }
    }
}
func formattedDuration(time: Int) -> String {
    
    let timeInSeconds = time / 1000
    let formatter = DateComponentsFormatter()
    let interval = TimeInterval(timeInSeconds)
    formatter.zeroFormattingBehavior = .pad
    formatter.allowedUnits = [.minute, .second ]
    formatter.unitsStyle = .positional
    
    return formatter.string(from:interval) ?? ""
    
}
struct SongsForAlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        SongsForAlbumListView(songsViewModel: SongsForAlbumListViewModel.exapmle())
    }
}
