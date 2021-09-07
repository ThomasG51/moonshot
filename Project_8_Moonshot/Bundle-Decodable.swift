//
//  Bundle-Decodable.swift
//  Project_8_Moonshot
//
//  Created by Thomas George on 31/08/2021.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(file: String) -> T {
        // on verifie si le fichier existe
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        // on verifie que le cfichier contiens des donnees
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        // on verifie que les donnees du fichier correspondent a la struture
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
