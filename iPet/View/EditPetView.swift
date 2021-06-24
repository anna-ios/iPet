//
//  EditPetView.swift
//  iPet
//
//  Created by Zelinskaya Anna on 05.05.2021.
//

import Foundation
import SwiftUI

struct EditPetView : View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var petViewModel: PetViewModel
    
    @StateObject private var pet: Pet = Pet()
    
    @State private var name: String = ""
    @State private var breed: String = ""
    @State private var segments = ["Cat", "Dog"]
    @State private var kind: String = ""
    @State private var image: UIImage?
    @State private var showingAlert = false
    
    private var selectedKind: Binding<String> {
        Binding<String>(
            get: { kind },
            set : {
                kind = $0
                petViewModel.kind = getPetKind(kind)
            })
    }
    
    init(pet: Pet) {
        if pet.managedObjectContext != nil {
            _pet = StateObject(wrappedValue:pet)
            _name = State(initialValue:pet.name)
            _breed = State(initialValue:pet.breedName)
            _kind = State(initialValue:pet.kind)
            if let imgData = pet.image,
               let uiimage = UIImage(data: imgData) {
                _image = State(initialValue:uiimage)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: HeaderView()) {
                    PetImageView(inputImage: $image)
                        .frame(height: 150, alignment: .center)
                }
                .textCase(nil)
                Section {
                    TextField("Pet name", text: $name)
                }
                .listRowBackground(Color(.systemGray6))
                Section {
                    Picker("Pet kind", selection: selectedKind) {
                        ForEach(segments, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("Pet breed", selection: $breed) {
                        if let breeds = petViewModel.getBreeds() {
                            ForEach(breeds, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                }
                .listRowBackground(Color(.systemGray6))
                Section {
                    HStack {
                        Spacer()
                        Button {
                            guard !name.isEmpty, !kind.isEmpty, !breed.isEmpty else {
                                showingAlert = true
                                return
                            }

                            addItem()
                            close()
                            withAnimation {
                                router.currentPage = .home
                            }
                        } label: {
                            return Text("Save")
                                .font(.headline)
                                .frame(width: 220, height: 60, alignment: .center)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(15.0)
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Some fields are empty"),
                                  message: Text("Please enter all pet's data"),
                                  dismissButton: .default(Text("Ok")))
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                    }
                }
            }
            .onAppear() {
                petViewModel.loadBreeds()
                petViewModel.kind = getPetKind(kind)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        close()
                    }) {
                        Text("Cancel")
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(router.currentPage == .first ? true : false)
        }
    }
    
    func addItem() {
        if pet.managedObjectContext != nil {
            petViewModel.updatePet(pet: pet,
                                   name: name,
                                   breed: breed,
                                   kind: kind,
                                   image: image,
                                   viewContext: viewContext)
        }
        else {
            petViewModel.addPet(name: name,
                                breed: breed,
                                kind: kind,
                                image: image,
                                viewContext: viewContext)
        }
    }
    
    func close() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct HeaderView : View {
    var body: some View {
        return Text("Your pet's data")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(Color.black)
            .padding()
    }
}

