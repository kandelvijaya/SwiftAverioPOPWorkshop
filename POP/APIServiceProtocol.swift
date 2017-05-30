//
//  Copyright © 2017 zalando. All rights reserved.
//

import Foundation

enum NetworkResult<T> {
    case error(Error)
    case success(T)
}

enum ServiceError: Error {
    case unable(Error)
    case badResponse
    case emptyResponse
}


typealias APIResultValueType = [String : Any]

protocol APIServiceProtocol {

    func get(path: String, completion: @escaping (NetworkResult<APIResultValueType>) -> Void)

}

extension APIServiceProtocol {

    var baseURL: URL {
        return URL(string: "https://api.chucknorris.io/jokes")!
    }

    var session: URLSession {
        return URLSession(configuration: .default)
    }

    func get(path: String, completion: @escaping (NetworkResult<APIResultValueType>) -> Void) {
        let fullurl = baseURL.appendingPathComponent(path)
        session.dataTask(with: fullurl) { (data, response, error) in

            if let error = error {
                asyncOnMain { completion(.error(ServiceError.unable(error))) }
                return
            }


            let response = response as! HTTPURLResponse
            guard response.statusCode == 200 else {
                asyncOnMain { completion(.error(ServiceError.badResponse)) }
                return
            }

            guard let data = data else {
                asyncOnMain { completion(.error(ServiceError.emptyResponse)) }
                return
            }

            // Transform data and return
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] ?? [:]
            asyncOnMain { completion(.success(json)) }
        }.resume()

    }
    
}

// couldnt do this 
// let asyncOnMain = DispatchQueue.main.async

func asyncOnMain(_ block: @escaping () -> Void) {
    DispatchQueue.main.async(execute: block)
}
