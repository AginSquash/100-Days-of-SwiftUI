//
//  MeView.swift
//  HotProspects
//
//  Created by Vlad Vrublevsky on 02.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    @ObservedObject var meData = MeShared()
    
    //@State private var name = meData.me.name
   //@State private var emailAddress = meData.me.emailAddress //"you@yoursite.com"
    
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Name", text: self.$meData.name, onCommit: { self.meData.save() })
                    .textContentType(.name)
                    .font(.title)
                    .padding(.horizontal)
                    
                TextField("Email address", text: self.$meData.emailAddress, onCommit: { self.meData.save() })
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .font(.title)
                    .padding(.horizontal)

                Button(action: { self.meData.save() } ) {
                    Text("Save")
                        .font(.title)
                        .padding(.bottom)
                }
                
                Image(uiImage: generateQRCode(from: "\(self.meData.name)\n\(self.meData.emailAddress)"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Spacer()
            }
        .navigationBarTitle("Your code")
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
