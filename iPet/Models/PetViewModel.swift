//
//  PetViewModel.swift
//  iPet
//
//  Created by Zelinskaya Anna on 23.05.2021.
//

import Foundation
import CoreData
import SwiftUI
import Networking

enum PetKind {
    case cat, dog
}

func getPetKind(_ kind: String) -> PetKind? {
    if kind == "Cat" {
        return .cat
    }
    if kind == "Dog" {
        return .dog
    }
    return nil
}

class PetViewModel: ObservableObject {
    
    @Published private(set) var dogs: [DogBreed] = [DogBreed]()
    @Published private(set) var cats: [CatBreed] = [CatBreed]()
        
    let service: PageLoadingService?
    var kind: PetKind?
    
    init() {
        self.service = ServiceLocator.shared.getService()
    }
    
    func getBreeds() -> [String]? {
        return kind == .cat ? self.cats.map { $0.name } : kind == .dog ? self.dogs.map { $0.name } : nil
    }
    
    func loadBreeds() {
        if (cats.count > 0 && dogs.count > 0) {
            return
        }
        
        let queue = OperationQueue()
        queue.addOperation({ self.loadCatBreeds() })
        queue.addOperation({ self.loadDogBreeds() })
    }
    
    func loadCatBreeds() {
        guard let service = self.service,
              service.isBreedsLoading == false else {
            return
        }
        
        service.getCatBreeds { catBreeds in
            if let breeds = catBreeds {
                self.cats.append(contentsOf: breeds)
            }
        }
    }
    
    func loadDogBreeds() {
        guard let service = self.service,
              service.isBreedsLoading == false else {
            return
        }
        
        service.getDogBreeds { dogBreeds in
            if let breeds = dogBreeds {
                self.dogs.append(contentsOf: breeds)
            }
        }
    }
    
    func addPet(name: String, breed: String, kind: String, image:UIImage?, viewContext: NSManagedObjectContext) {
        
        let pet = Pet(context: viewContext)
        pet.id = UUID()
        pet.timestamp = Date()
        
        updatePet(pet: pet, name: name, breed: breed, kind: kind, image: image, viewContext: viewContext)
    }
    
    func updatePet(pet: Pet, name: String, breed: String, kind: String, image:UIImage?, viewContext: NSManagedObjectContext) {
        
        pet.name = name
        pet.kind = kind
        pet.breedName = breed
        let jpegImage = image?.jpegData(compressionQuality: 1.0)
        pet.image = jpegImage
        
        if let dog = dogs.first(where: {$0.name == breed}) {
            pet.origin = dog.origin
            pet.temperament = dog.temperament
            pet.weight = dog.weight?.metric
            pet.wikipediaUrl = dog.wikipediaUrl
        }
        
        if let cat = cats.first(where: {$0.name == breed}) {
            pet.breedDescription = cat.description
            pet.origin = cat.origin
            pet.temperament = cat.temperament
            pet.weight = cat.weight?.metric
            if let adaptability = cat.adaptability {
                pet.adaptability = adaptability
            }
            if let affectionLevel = cat.affectionLevel {
                pet.affectionLevel = affectionLevel
            }
            if let childFriendly = cat.childFriendly {
                pet.childFriendly = childFriendly
            }
            if let dogFriendly = cat.dogFriendly {
                pet.dogFriendly = dogFriendly
            }
            if let energyLevel = cat.energyLevel {
                pet.energyLevel = energyLevel
            }
            if let grooming = cat.grooming {
                pet.grooming = grooming
            }
            if let healthIssues = cat.healthIssues {
                pet.healthIssues = healthIssues
            }
            pet.wikipediaUrl = cat.wikipediaUrl
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func removePet(pet: Pet, viewContext: NSManagedObjectContext) {
        viewContext.delete(pet)
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}
