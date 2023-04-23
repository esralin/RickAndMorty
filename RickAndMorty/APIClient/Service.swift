//
//  Service.swift
//  RickAndMorty
//
//  Created by Esra Alın on 5.04.2023.
//

import Foundation


/// API Service object to get Rick and Morty data
final class Service{
    
    /// Shared singleton instance
    static let shared = Service()
    
    private init(){}
    
    enum ServiceError: Error {
            case failedToCreateRequest
            case failedToGetData
        }
    
    
    /// Send API Call
    public func execute<T: Codable>(_ request: Request,expecting type: T.Type,completion: @escaping (Result<T,Error>) -> Void){

                guard let urlRequest = self.request(from: request) else {
                    completion(.failure(ServiceError.failedToCreateRequest))
                    return
                }

                let task = URLSession.shared.dataTask(with: urlRequest) {data, _, error in
                    guard let data = data, error == nil else {
                        completion(.failure(error ?? ServiceError.failedToGetData))
                        return
                    }

                    do {
                        let result = try JSONDecoder().decode(type.self, from: data)
                    
                        completion(.success(result))
                    }
                    catch {
                        completion(.failure(error))
                    }
                }
                task.resume()
    }
    
    /// Perform request
    private func request(from newRequest: Request) -> URLRequest? {
            guard let url = newRequest.url else {
                return nil
            }
            var request = URLRequest(url: url)
            request.httpMethod = newRequest.httpMethod
            return request
        }
    
}
