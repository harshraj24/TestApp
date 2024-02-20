//
//  NetworkLayer.swift
//  UpstoxTestApp
//
//  Created by Harsh Raj on 19/02/24.
//

import Foundation


class NetworkLayer {
    static func fetchData(from url: URL, completion: @escaping (Result<UserHoldingsResponse, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Unknown", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let userHoldingsResponse = try JSONDecoder().decode(UserHoldingsResponse.self, from: data)
                completion(.success(userHoldingsResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
