//
//  InfoView.swift
//  SwiftUINavigation
//
//  Created by Анна  Зелинская on 04.01.2021.
//

import Foundation
import SwiftUI

struct InfoView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @State var pet: Pet
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    if let breed = pet.breedName {
                        Text("\(breed)")
                            .font(.title)
                            .padding(.bottom)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    addOrigin(origin: pet.origin)
                    addTemperament(temperament: pet.temperament)
                    addDescription(description: pet.breedDescription)
                    addWeight(weight: pet.weight)
                    addBreedCharacteristics(pet: pet)
                    addWikipediaUrl(url: pet.wikipediaUrl)
                    Spacer()
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}

private func addOrigin(origin: String?) -> some View {
    Group {
        if let origin = origin {
            Text("Origin")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            Text("\(origin)")
        }
    }
    .padding(.bottom)
}

private func addTemperament(temperament: String?) -> some View {
    Group {
        if let temperament = temperament {
            Text("Temperament")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
                .cornerRadius(15.0)
            Text("\(temperament)")
        }
    }
    .padding(.bottom)
}

private func addDescription(description: String?) -> some View {
    Group {
        if let description = description {
            Text("Description")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            Text("\(description)")
        }
    }
    .padding(.bottom)
}

private func addWeight(weight: String?) -> some View {
    Group {
        if let weight = weight {
            Text("Weight")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            Text("\(weight) kg")
        }
    }
    .padding(.bottom)
}

private func addBreedCharacteristics(pet: Pet) -> some View {
    VStack(alignment: .leading) {
        Group {
            if let adaptability = pet.adaptability, adaptability != 0 {
                Text("Breed Characteristics")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom)
                Text("Adaptability: \(Int(adaptability))/5")
            }
            if let affectionLevel = pet.affectionLevel, affectionLevel != 0 {
                Text("AffectionLevel: \(Int(affectionLevel))/5")
            }
            if let childFriendly = pet.childFriendly, childFriendly != 0 {
                Text("ChildFriendly: \(Int(childFriendly))/5")
            }
            if let dogFriendly = pet.dogFriendly, dogFriendly != 0 {
                Text("DogFriendly: \(Int(dogFriendly))/5")
            }
            if let energyLevel = pet.energyLevel, energyLevel != 0 {
                Text("EnergyLevel: \(Int(energyLevel))/5")
            }
        }
        Group {
            if let grooming = pet.grooming, grooming != 0 {
                Text("Grooming: \(Int(grooming))/5")
            }
            if let healthIssues = pet.healthIssues, healthIssues != 0 {
                Text("HealthIssues: \(Int(healthIssues))/5")
            }
            if let intelligence = pet.intelligence, intelligence != 0 {
                Text("Intelligence: \(Int(intelligence))/5")
            }
            if let sheddingLevel = pet.sheddingLevel, sheddingLevel != 0 {
                Text("SheddingLevel: \(Int(sheddingLevel))/5")
            }
            if let socialNeeds = pet.socialNeeds, socialNeeds != 0 {
                Text("SocialNeeds: \(Int(socialNeeds))/5")
            }
            if let strangerFriendly = pet.strangerFriendly, strangerFriendly != 0 {
                Text("StrangerFriendly: \(Int(strangerFriendly))/5")
            }
        }
    }
    .padding(.bottom)
}

private func addWikipediaUrl(url: String?) -> some View {
    HStack {
        if let url = url {
            Text("For more information, see:")
            Text("Wikipedia")
                .foregroundColor(.blue)
                .underline()
                .onTapGesture {
                    let url = URL.init(string: url)
                    guard let strURL = url, UIApplication.shared.canOpenURL(strURL) else { return }
                    UIApplication.shared.open(strURL)
                }
                .foregroundColor(.gray)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(pet: Pet())
    }
}
