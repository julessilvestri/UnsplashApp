import Foundation

struct UnsplashAPI {
    static func unsplashApiBaseUrl(endpointApi endpoint: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = endpoint
        components.queryItems = [
            URLQueryItem(name: "client_id", value: ConfigurationManager.instance.plistDictionnary.clientId)
        ]
        return components
    }
    
    static func feedUrl(endpointApi endpoint: String, orderBy: String = "popular", perPage: Int = 10) -> URL? {
        var components = unsplashApiBaseUrl(endpointApi: endpoint)
        components.queryItems?.append(contentsOf: [
            URLQueryItem(name: "order_by", value: orderBy),
            URLQueryItem(name: "per_page", value: String(perPage))
        ])
        return components.url
    }
}

