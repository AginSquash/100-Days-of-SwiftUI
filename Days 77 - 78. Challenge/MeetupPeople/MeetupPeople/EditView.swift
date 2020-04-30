//
//  EditView.swift
//  MeetupPeople
//
//  Created by Vlad Vrublevsky on 30.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct EditView: View {
    @ObservedObject var persons: personsClass
    
    @State private var name = String()
    @State private var showImagePicker = false
    @State private var uiImage: UIImage? = nil
    @State private var image: Image? = nil
    
    var body: some View {
        let bindedImage = Binding<UIImage?>(
            get: { self.uiImage },
            set: {  self.uiImage = $0
                    if self.uiImage != nil {
                        self.image = Image(uiImage: self.uiImage!)
                    }
                })
        
        return
            NavigationView {
                Form {
                    Section {
                        TextField("Name", text: $name)
                    }
                    
                    Section {
                        if self.image == nil {
                            Button("Import photo") {
                                self.showImagePicker = true
                            }
                        } else {
                            image!
                                .resizable()
                                .scaledToFit()
                                .onTapGesture {
                                    self.showImagePicker = true
                            }
                        }
                    }
            }
                .navigationBarTitle("Add new friend", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                    // Save
            } )
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: bindedImage)
        }
    }
}

struct EditView_Previews: PreviewProvider {
   
    static var previews: some View {
        EditView(persons: personsClass())
    }
}
