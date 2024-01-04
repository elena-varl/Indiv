//
//  FetchState.swift
//  indiv
//
//  Created by AIR on 04.01.2024.
//

import Foundation
enum FetchState: Comparable {
    case good
    case isLoading
    case loadedAll
    case error(String)
}
