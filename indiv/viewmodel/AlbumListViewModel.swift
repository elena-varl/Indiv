//
//  AlbumListViewModel.swift
//  indiv
//
//  Created by AIR on 04.01.2024.
//

import Foundation
import Combine

//https://itunes.apple.com/search?term=jack+johnson&entity=album&limit=5&offset=10
//https://itunes.apple.com/search?term=jack+johnson&entity=song&limit=5
//https://itunes.apple.com/search?term=jack+johnson&entity=movie&limit=5

class AlbumListViewModel : ObservableObject
{
    enum State: Comparable {
        case good
        case isLoading
        case loadedAll
        case error(String)
    }
    enum EntityType: String {
        case album
        case song
        case movie
    }
    @Published var searchTerm: String = ""
    @Published var albums: [Album] = [Album]()
    
    @Published var state: State = .good {
        didSet {
            print("state change to: \(state)")
        }
    }
    
    let limit: Int = 20
    var page: Int = 0
    
    var subscriptions = Set<AnyCancellable>()
    init() {
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.state = .good
                self?.albums = []
            self?.fetchAlbums(for: term)
        }.store(in: &subscriptions)

    }
    
    func LoadMore() {
        fetchAlbums(for: searchTerm)
    }
    func fetchAlbums(for searchTerm: String)
    {
        guard !searchTerm.isEmpty else
        {
            return
        }
        
        guard state == State.good else  {
            return
        }
        
        guard let url = createURL(for: searchTerm) else {
            return
        }
        print (url.absoluteString)
        print("start fetching data for \(searchTerm)")
        state = .isLoading
        
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            
            if let error = error {
                print("urlsession error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.state = .error("Could not load data: \(error.localizedDescription)")
                }
                            }
            else if let data = data {
                do {
             let result = try JSONDecoder().decode(AlbumResult.self, from: data)
             DispatchQueue.main.async {
                 for album in result.results{
                     self?.albums.append(album)
                 }
                 
                 self?.page += 1
                 self?.state = (result.results.count == self?.limit) ? .good : .loadedAll
             }
                } catch {
                    print("decoding error \(error)")
                    DispatchQueue.main.async {
                        self?.state = .error("Could not load get data \(error.localizedDescription)")
                    }
                    
                }
                
            }
            
            
        }.resume()
    }
    func fetch<T>(type: T.Type, url: URL?, completion: @escaping (Result<T ,APIError>) -> Void)
    {
        
    }
    func createURL(for searchTerm: String, type: EntityType = .album) -> URL? {
        //https://itunes.apple.com/search?term=jack+johnson&entity=album&limit=5&offset=10
        let baseURL = "https://itunes.apple.com/search"
        let offset = page * limit
        let queryItems = [URLQueryItem(name: "term", value: searchTerm),
                          URLQueryItem(name: "entity", value: type.rawValue),
                          URLQueryItem(name: "limit", value: String(limit)),
                          URLQueryItem(name: "offset", value: String(offset))]
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = queryItems
        return components?.url
    }
}
