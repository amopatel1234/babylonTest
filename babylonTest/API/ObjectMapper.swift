//
//  ObjectMapper.swift
//  babylonTest
//
//  Created by Amish Patel on 07/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

protocol ObjectMapable {
    func mapData<T: Codable>(data: Data) throws -> [T]
}

extension ObjectMapable {
    func mapData<T: Codable>(data: Data) throws -> [T] {
        do {
            let objects = try JSONDecoder().decode([T].self, from: data)
            return objects
        } catch let error {
            throw error
        }
    }
}

final class ObjectMapper: ObjectMapable{}
