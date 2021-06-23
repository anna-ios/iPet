//
// DogBreedsAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



open class DogBreedsAPI {
    /**
     Returns a list of dog breeds
     
     - parameter attachBreed: (query)  (optional, default to 0)
     - parameter page: (query)  (optional)
     - parameter limit: (query)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getDogBreedList(attachBreed: Int? = nil, page: Int? = nil, limit: Int? = nil, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue, completion: @escaping ((_ data: [DogBreed]?,_ error: Error?) -> Void)) {
        getDogBreedListWithRequestBuilder(attachBreed: attachBreed, page: page, limit: limit).execute(apiResponseQueue) { result -> Void in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Returns a list of dog breeds
     - GET /breeds
     - responseHeaders: [Pagination-Count(Int), Pagination-Page(Int), Pagination-Limit(Int)]
     - parameter attachBreed: (query)  (optional, default to 0)
     - parameter page: (query)  (optional)
     - parameter limit: (query)  (optional)
     - returns: RequestBuilder<[DogBreed]> 
     */
    open class func getDogBreedListWithRequestBuilder(attachBreed: Int? = nil, page: Int? = nil, limit: Int? = nil) -> RequestBuilder<[DogBreed]> {
        let path = "/breeds"
        let URLString = OpenAPIClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "attach_breed": attachBreed?.encodeToJSON(), 
            "page": page?.encodeToJSON(), 
            "limit": limit?.encodeToJSON()
        ])

        let requestBuilder: RequestBuilder<[DogBreed]>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Array of Breeds which match the q query parameter passed
     
     - parameter q: (query)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getDogBreedSearchList(q: String? = nil, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue, completion: @escaping ((_ data: [DogBreed]?,_ error: Error?) -> Void)) {
        getDogBreedSearchListWithRequestBuilder(q: q).execute(apiResponseQueue) { result -> Void in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Array of Breeds which match the q query parameter passed
     - GET /breeds/search
     - responseHeaders: [Pagination-Count(Int), Pagination-Page(Int), Pagination-Limit(Int)]
     - parameter q: (query)  (optional)
     - returns: RequestBuilder<[DogBreed]> 
     */
    open class func getDogBreedSearchListWithRequestBuilder(q: String? = nil) -> RequestBuilder<[DogBreed]> {
        let path = "/breeds/search"
        let URLString = OpenAPIClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "q": q?.encodeToJSON()
        ])

        let requestBuilder: RequestBuilder<[DogBreed]>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
