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
    @State private var image: Image? = nil
    
    @State private var ratio: CGFloat = 0
    
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
                            TextField("Name", text: self.$name, onCommit: self.save)
                        }
                    
                    Section {
                        if self.image != nil {
                            ZStack {
                                
                                Rectangle()
                                    .frame(height: uiImage!.size.height * self.ratio + 35)
                                    .opacity(0)
                                    
                                GeometryReader { geometry in
                                        self.image?
                                            .resizable()
                                            .frame(width: geometry.size.width, height: self.getHeight(frameWidth: geometry.size.width))
                                            .scaledToFit()
                                            .clipShape(Rectangle().inset(by: 5))
                                            .shadow(radius: 5)
                                            .padding(.top)
                                }
                            }
                        } else {
                            Text("Tap to select a picture")
                            .foregroundColor(.blue)
                            .font(.headline)
                        }
                    }
                    .onTapGesture {
                            self.showImagePicker = true
                    }
            }
            .navigationBarTitle("Add new friend", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                    self.save()
                }
            .disabled( image == nil || name.isEmpty ) )
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: bindedImage)
        }
    }
    
    func save() {
        if (self.image != nil && !self.name.isEmpty) {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            let newFriend = person(image: self.uiImage!, name: self.name, date: formatter.string(from: date))
            self.persons.append(newFriend)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func getHeight(frameWidth: CGFloat) -> CGFloat {
        if let uiImage = self.uiImage {
            let ratio = frameWidth / uiImage.size.width
            DispatchQueue.main.async {
                self.ratio = ratio
            }
            return ratio * uiImage.size.height
        } else {
            return frameWidth
        }
    }
    
    func getSizeTuple() -> (CGFloat, CGFloat)
    {
        if let uiImage = self.uiImage {
            return (uiImage.size.width, uiImage.size.height)
        } else {
            return ( 0, 0 )
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
