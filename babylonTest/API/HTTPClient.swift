//
//  HTTPClient.swift
//  babylonTest
//
//  Created by Amish Patel on 07/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

protocol HTTPClient {
    func get(url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}
