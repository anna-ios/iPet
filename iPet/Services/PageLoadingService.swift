//
//  PageLoadingService.swift
//  iPet
//
//  Created by Анна  Зелинская on 11.05.2021.
//

import Foundation

import Foundation
import Networking

class PageLoadingService {
    
    @Published private(set) var isBreedsLoading: Bool = false
    
    func getDogBreeds(completion: @escaping (_ breeds: [DogBreed]?) -> Void) {
        isBreedsLoading = true
        
        DogBreedsAPI.getDogBreedList(attachBreed: 0, page: 0, limit: 200) { response, error in
            guard let resp = response else {
                completion(nil)
                return
            }
            
            self.isBreedsLoading = false
            completion(resp)
        }
    }
    
    func getDogBreedSearch(breed: String, completion: @escaping (_ breeds: [DogBreed]?) -> Void) {
        isBreedsLoading = true
        
        DogBreedsAPI.getDogBreedSearchList(q: breed) { response, error in
            guard let resp = response else {
                completion(nil)
                return
            }
            
            self.isBreedsLoading = false
            completion(resp)
        }
    }
    
    func getCatBreeds(completion: @escaping (_ breeds: [CatBreed]?) -> Void) {
        isBreedsLoading = true
        
        CatBreedsAPI.getCatBreedList(attachBreed: 0, page: 0, limit: 100) { response, error in
            guard let resp = response else {
                completion(nil)
                return
            }
            
            self.isBreedsLoading = false
            completion(resp)
        }
    }
}

