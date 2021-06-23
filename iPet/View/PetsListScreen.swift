//
//  PetsListScreen.swift
//  iPet
//
//  Created by Zelinskaya Anna on 04.06.2021.
//

import Foundation
import SwiftUI

struct PetsListScreen: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Pet.timestamp, ascending: true)],
        animation: .default)
    private var pets: FetchedResults<Pet>
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject private var petViewModel: PetViewModel
    
    @State private var listSelection: Int?
    @State private var showModal: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(Array(pets.enumerated()), id: \.offset) { index, pet in
                        NavigationLink(destination: ProfileView(pet: pet),
                                       tag:index,
                                       selection:$listSelection) {
                            if let name = pet.name, let breed = pet.breedName {
                                PetCell(name: name, breed: breed)
                                    .listRowBackground(Color(.systemGray6))
                            }
                        }
                    }
                    .onDelete(perform: removeRows(at:))
                }
                .listStyle(InsetGroupedListStyle())
            }
            .sheet(isPresented: $showModal) {
                EditPetView(pet: Pet())
                    .environmentObject(self.petViewModel)
                    .environmentObject(Router())
            }
            .navigationTitle("Pets")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showModal = true
                    }
                    label: {
                        return Text("Add")
                    }
                }
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        
        let pet = pets[index]
        petViewModel.removePet(pet: pet, viewContext: viewContext)
    }
}

struct PetCell: View {
    var name: String
    var breed: String
    
    var body: some View {
        VStack(alignment: .leading) {
            if let name = name {
                Text("\(name)")
                    .font(.headline)
            }
            if let breed = breed {
                Text("\(breed)")
                    .font(.subheadline)
            }
            Spacer()
        }
    }
}


struct PetsListScreen_Previews: PreviewProvider {
    static var previews: some View {
        PetsListScreen()
    }
}
