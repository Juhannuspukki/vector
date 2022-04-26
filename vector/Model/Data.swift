//
//  File.swift
//  vector
//
//  Created by Jere Laine on 24.1.2022.
//

import Foundation
import AppKit

let iconCollections: [Collection] = loadFile("icon-data-thai.json")

func loadFile<T: Decodable>(_ filename: String) -> [T] {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
        fatalError("Cannot find \(filename)")
    }
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Cannot load \(filename):\n\(error)")
    }
    do {
        let decoder = JSONDecoder()
        return try decoder.decode([T].self, from: data)
    } catch {
        fatalError("Cannot parse \(filename): \(T.self):\n\(error)")
    }
}

struct Collection: Decodable, Identifiable, Hashable {
    let name: String
    let id: String
    let icons: [Icon]
}

struct Icon: Decodable, Identifiable, Hashable {
  let id: String
  let name: String
  let tags: [String]
}
