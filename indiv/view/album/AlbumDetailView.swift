//
//  AlbumDetailView.swift
//  indiv
//
//  Created by AIR on 05.01.2024.
//

import SwiftUI

struct AlbumDetailView: View {
    let album: Album
    @StateObject var songsViewModel: SongsForAlbumListViewModel
    
    init(album: Album)
    {
        print("init album detail \(album.id)")
        self.album = album
        self._songsViewModel = StateObject(wrappedValue: SongsForAlbumListViewModel(albumID: album.id))
    }
    var body: some View {
        VStack{
        HStack (alignment: .bottom) {
            
            ImageLoadingView(urlString: album.artworkUrl60, size: 100)
            VStack(alignment: .leading) {
                Text(album.collectionName)
                    .font(.footnote)
                    .foregroundColor(Color(.label))
                
                Text(album.artistName)
                    .padding(.bottom, 5)
                Text(album.primaryGenreName)
                Text("\(album.trackCount) songs")
                Text("Released \(formattedDate(value: album.releaseDate))")
                
            }
            .font(.caption)
            .foregroundColor(.gray)
            .lineLimit(1)
            Spacer(minLength: 20)
            
            BuyButton(urlString: album.collectionViewURL, price: album.collectionPrice, currency: album.currency)
            
        }
        .padding()
        SongsForAlbumListView(songsViewModel: songsViewModel)
    }
        .onAppear(){
            songsViewModel.fetch()
        }
    }
    //  для правильного отображения даты из  json
    func formattedDate(value: String)->String {
        let dateFormatterGetter = DateFormatter()
        dateFormatterGetter.dateFormat = "yyyy-MMMM-dd'T'HH:mm:ss'Z'"
        guard let date = dateFormatterGetter.date(from: value) else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: date)
    }
}

struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailView(album: Album.example())
    }
}
