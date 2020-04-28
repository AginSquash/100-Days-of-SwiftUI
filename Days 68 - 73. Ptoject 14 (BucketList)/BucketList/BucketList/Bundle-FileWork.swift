//
//  Bundle-FileWork.swift
//  BucketList
//
//  Created by Vlad Vrublevsky on 28.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import Foundation


extension Bundle {
    
    func writeCustomData<T: Codable>(data: T, file: String) {
        let encoder = JSONEncoder()
        guard let encoded: Data = try? encoder.encode(data) else {
            print("Data is not encodable")
            return
        }
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url =  path.appendingPathComponent(file)
        
        do {
            try encoded.write(to: url, options: [.atomic])
        } catch {
            print(error.localizedDescription)
        }
    }

    func readCustomData<T: Codable>(file: String) -> T?
    {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url =  path.appendingPathComponent(file)
        
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
