//
//  Song.swift
//  indiv
//
//  Created by AIR on 04.01.2024.
//

import Foundation

// MARK: - SongResult
struct SongResult: Codable {
    let resultCount: Int
    let results: [Song]
}

// MARK: - Result
struct Song: Codable, Identifiable {
    let wrapperType: String
    let artistID, collectionID:Int
    let id: Int
    let artistName, collectionName, trackName: String
    let artistViewURL, collectionViewURL, trackViewURL: String
    let previewURL: String
    let artworkUrl30, artworkUrl60, artworkUrl100: String
    let collectionPrice, trackPrice: Double?
    let releaseDate: String
    let trackCount, trackNumber: Int
    let trackTimeMillis: Int
    let country, currency, primaryGenreName: String
    let collectionArtistName: String?
    

    enum CodingKeys: String, CodingKey {
        case wrapperType
        case artistID = "artistId"
        case collectionID = "collectionId"
        case id = "trackId"
        case artistName, collectionName, trackName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate,  trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, collectionArtistName
    }
    
    
    init(wrapperType: String, artistID: Int, collectionID: Int, id: Int, artistName: String, collectionName: String,
            trackName: String, artistViewURL: String, collectionViewURL: String, trackViewURL: String, previewURL: String,
            artworkUrl30: String, artworkUrl60: String, artworkUrl100: String,
            collectionPrice: Double?, trackPrice: Double?, releaseDate: String, trackCount: Int, trackNumber: Int,
            trackTimeMillis: Int, country: String, currency: String, primaryGenreName: String, collectionArtistName: String?) {
           self.wrapperType = wrapperType
           self.id = id
           self.artistID = artistID
           self.collectionID = collectionID
           self.collectionName = collectionName
           self.collectionViewURL = collectionViewURL
           self.collectionArtistName = collectionArtistName
           self.previewURL = previewURL
           
           self.collectionPrice = collectionPrice
           self.trackPrice = trackPrice
           self.currency = currency
           self.country = country
           self.primaryGenreName = primaryGenreName
           
           self.artworkUrl30 = artworkUrl30
           self.artworkUrl60 = artworkUrl60
           self.artworkUrl100 = artworkUrl100
           self.artistViewURL = artistViewURL
           self.artistName = artistName
           
           self.trackName = trackName
           self.trackCount = trackCount
           self.trackNumber = trackNumber
           self.trackTimeMillis = trackTimeMillis
           self.trackViewURL = trackViewURL
           self.releaseDate = releaseDate
       }
       
       init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.wrapperType = try container.decode(String.self, forKey: .wrapperType)
           self.artistID = try container.decode(Int.self, forKey: .artistID)
           self.collectionID = try container.decode(Int.self, forKey: .collectionID)
           self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
           self.artistName = try container.decode(String.self, forKey: .artistName)
           self.collectionName = try container.decode(String.self, forKey: .collectionName)
           self.trackName = try container.decodeIfPresent(String.self, forKey: .trackName) ?? ""
           self.artistViewURL = try container.decodeIfPresent(String.self, forKey: .artistViewURL) ?? ""
           self.collectionViewURL = try container.decode(String.self, forKey: .collectionViewURL)
           self.trackViewURL = try container.decodeIfPresent(String.self, forKey: .trackViewURL) ?? ""
           self.previewURL = try container.decodeIfPresent(String.self, forKey: .previewURL) ?? ""
           self.artworkUrl30 = try container.decodeIfPresent(String.self, forKey: .artworkUrl30) ?? ""
           self.artworkUrl60 = try container.decode(String.self, forKey: .artworkUrl60)
           self.artworkUrl100 = try container.decode(String.self, forKey: .artworkUrl100)
           self.collectionPrice = try container.decodeIfPresent(Double.self, forKey: .collectionPrice)
           self.trackPrice = try container.decodeIfPresent(Double.self, forKey: .trackPrice)
           self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
           self.trackCount = try container.decode(Int.self, forKey: .trackCount)
           self.trackNumber = try container.decodeIfPresent(Int.self, forKey: .trackNumber) ?? 1
           self.trackTimeMillis = try container.decodeIfPresent(Int.self, forKey: .trackTimeMillis) ?? 1
           self.country = try container.decode(String.self, forKey: .country)
           self.currency = try container.decode(String.self, forKey: .currency)
           self.primaryGenreName = try container.decode(String.self, forKey: .primaryGenreName)
           self.collectionArtistName = try container.decodeIfPresent(String.self, forKey: .collectionArtistName)
       }
       
       

static func example() -> Song {
    Song(wrapperType: "Song", artistID: 1, collectionID: 1, id: 1, artistName: "This Bike Is a Pipe Bomb", collectionName: "Three Way Tie for a Fifth", trackName: "Jack Johnson", artistViewURL: "", collectionViewURL: "", trackViewURL: "https://music.apple.com/us/album/upside-down/1469577723?i=1469577741&uo=4", previewURL: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/fd/bb/38/fdbb38d2-073d-4bc7-68c4-348a0be6d560/mzaf_4150435585996894188.plus.aac.p.m4a", artworkUrl30: "https://is1-ssl.mzstatic.com/image/thumb/Music124/v4/f3/ee/b3/f3eeb3ff-ca32-273a-15aa-709bdfa64367/mzi.izwiyqez.jpg/30x30bb.jpg", artworkUrl60: "https://is1-ssl.mzstatic.com/image/thumb/Music124/v4/f3/ee/b3/f3eeb3ff-ca32-273a-15aa-709bdfa64367/mzi.izwiyqez.jpg/60x60bb.jpg", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music124/v4/f3/ee/b3/f3eeb3ff-ca32-273a-15aa-709bdfa64367/mzi.izwiyqez.jpg/100x100bb.jpg", collectionPrice: 9.88, trackPrice: 0.99, releaseDate: "2004-06-15T12:00:00Z", trackCount: 11, trackNumber: 1, trackTimeMillis: 117573, country: "USA", currency: "USD", primaryGenreName: "Alternative", collectionArtistName: nil)
  
}
}
