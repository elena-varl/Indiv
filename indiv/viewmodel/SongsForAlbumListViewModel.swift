//
//  SongsForAlbumListViewModel.swift
//  indiv
//
//  Created by AIR on 05.01.2024.
//

import Foundation
// поиск всех песен в альбоме по id  альбома - поиск по всем песням

class SongsForAlbumListViewModel: ObservableObject {
    
    let albumID: Int
    private let service = APIService()
    
    @Published var songs = [Song]()
    @Published var state: FetchState = .good
    
    init(albumID: Int) {
        
        self.albumID = albumID
        
        
        print("init for songs for album \(albumID)")
        
        
    }
    func fetch ()
    {
        fetchSongs(for: albumID)
    }
    private func fetchSongs (for albumID: Int) {
        service.fetchSongs(for: albumID){
            [weak self ] result in
               DispatchQueue.main.async {
               
                 switch result {
                 case .success(let results):
                     
                     var songs = results.results
                     //tckи нашли хоть 1 песню в альбоме
                     if results.resultCount > 0 {
                         _ = songs.removeFirst()
                         
                     }
                     
                     self?.songs = songs
                  
                     self?.state =  .good
                     print("fetched \(results.resultCount) songs for albumID  \(albumID) ")
                     
                 case .failure(let error):
                    print("Could not load: \(error)")
                     self?.state = .error(error.localizedDescription)
                 }
               
               }
            
        }
    }
    static func exapmle() -> SongsForAlbumListViewModel {
        let vm = SongsForAlbumListViewModel(albumID: 1)
        vm.songs = [Song.example()]
        return vm
    }
}
