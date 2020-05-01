//
//  EditView.swift
//  MeetupPeople
//
//  Created by Vlad Vrublevsky on 30.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var persons: [person]
    
    @State private var name = String()
    @State private var showImagePicker = false
    @State private var uiImage: UIImage? = nil
    @State private var image: Image? =  nil //Image("3")
    
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
                GeometryReader { geometry in
                    VStack {
                        TextField("Name", text: self.$name)
                                .padding()
                        ZStack {
                            Rectangle()
                                .fill(Color.secondary)
                            
                            if self.image != nil {
                                self.image?
                                    .resizable()
                                    .frame(width: geometry.size.width, height: self.getHeight(frameWidth: geometry.size.width))
                                    //geometry.size.width / self.uiImage!.size.width * self.uiImage!.size.height
                                    .scaledToFit()
                                
                            } else {
                                    Text("Tap to select a picture")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                        }
                        .onTapGesture {
                            self.showImagePicker = true
                        }
                    }
            }
            .navigationBarTitle("Add new friend", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                    let newFriend = person(image: self.image!, name: self.name)
                    self.persons.append(newFriend)
                    self.presentationMode.wrappedValue.dismiss()
                }
            .disabled( image == nil || name.isEmpty ) )
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: bindedImage)
        }
    }
    
    func getHeight(frameWidth: CGFloat) -> CGFloat {
        if let uiImage = self.uiImage {
            let ratio = frameWidth / uiImage.size.width
            return ratio * uiImage.size.height
        } else {
            return frameWidth
        }
    }
}

struct EditView_Previews: PreviewProvider {
   
    static var previews: some View {
        
        var persons = [person]()
        let personBinding = Binding<[person]>(
            get: { persons },
            set: { persons = $0 })
        
        return EditView(persons: personBinding)
    }
}
