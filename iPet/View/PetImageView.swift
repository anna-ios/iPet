//
//  PetImageView.swift
//  iPet
//
//  Created by Zelinskaya Anna on 22.06.2021.
//

import Foundation
import SwiftUI

struct PetImageView : View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var inputImage: UIImage?
    @State private var showingImagePicker = false
    @State private var image: Image?
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                    }
                    else {
                        Circle()
                            .foregroundColor(Color.secondary)
                    }
                    VStack {
                        Image(systemName: "camera.fill")
                            .font(.largeTitle)
                    }
                }
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: $inputImage)
                }
                .onTapGesture {
                    showingImagePicker = true
                }
            }
            .onAppear() {
                loadImage()
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
    }
}
