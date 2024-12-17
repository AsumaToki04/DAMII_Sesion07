//
//  CatService.swift
//  Sesion07
//
//  Created by DAMII on 16/12/24.
//

import Foundation
import Alamofire

class CatService {
    static let shared = CatService()
    private let baseUrl = "https://api.thecatapi.com/v1"
    private let token = "live_r6DZLyOOQ3KMGpgbom9thTtuEN5uYmQCHozEsZy14qmbPM1rO5A5e0fzW4vKmrPe"
    
    func fetchCats() async throws -> [Cat] {
        try await withCheckedThrowingContinuation { continuation in
            let headers: HTTPHeaders = [
                "x-api-key": token
            ]
            AF.request("\(baseUrl)/breeds", headers: headers)
                .validate()
                .responseDecodable(of: [Cat].self) { response in
                    switch response.result {
                    case .success(let cats):
                        continuation.resume(returning: cats)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func searchCats(text: String) async throws -> [Cat] {
        try await withCheckedThrowingContinuation { continuation in
            let headers: HTTPHeaders = [
                "x-api-key": token
            ]
            AF.request("\(baseUrl)/breeds/search?q=\(text)", headers: headers)
                .validate()
                .responseDecodable(of: [Cat].self) { response in
                    switch response.result {
                    case .success(let cats):
                        continuation.resume(returning: cats)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
