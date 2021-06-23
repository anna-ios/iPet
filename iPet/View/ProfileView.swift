//
//  ProfileView.swift
//  iPet
//
//  Created by Zelinskaya Anna on 06.06.2021.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var petViewModel: PetViewModel
    
    @State private var editShowModal: Bool = false
    @State private var infoShowModal: Bool = false
    @StateObject var pet: Pet
    
    var body: some View {
        VStack(alignment: .leading) {
            if pet.managedObjectContext != nil,
               let imageData = pet.image,
               let newImage = UIImage(data: imageData),
               let image = Image(uiImage: newImage) {
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            if let name = pet.name {
                Text("\(name)")
                    .font(.largeTitle)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            if let breed = pet.breedName {
                Text("\(breed)")
                    .font(.title)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            Spacer()
        }
        .padding()
        .background(EmptyView().sheet(isPresented: $editShowModal) {
            EditPetView(pet: pet)
                .environmentObject(self.petViewModel)
                .environmentObject(Router())
        }
        .background(EmptyView().sheet(isPresented: $infoShowModal) {
            InfoView(pet: pet)
        }))
        .navigationBarTitle("", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    infoShowModal = true
                }) {
                    Image(systemName: "info.circle")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    editShowModal = true
                }) {
                    Image(systemName: "pencil")
                }
            }
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(pet: Pet())
    }
}
