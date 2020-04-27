//
//  ContentView.swift
//  Instafilter
//
//  Created by Vlad Vrublevsky on 26.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var currentFilterName = "Sepia Tone"
    
    //Filters
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    //Buttons
    @State private var showingFilterSheet = false
    @State private var showImagePicker = false
    
    var body: some View {
        let intensity = Binding<Double> (
            get: { self.filterIntensity },
            set: { self.filterIntensity = $0
                self.applyProcessing() } )
        
        let radius = Binding<Double> (
            get: { self.filterRadius },
            set: { self.filterRadius = $0
                self.applyProcessing() })
        
       return NavigationView {
            VStack {
                Text("Filter Choosen: \(self.currentFilterName)")
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if  image != nil {
                        image?
                            .resizable()
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
            HStack {
                Text("Intensity")
                Slider(value: intensity, in: 0.01...1)
            }
            if self.currentFilterName == "Unsharp Mask" {
                    HStack {
                        Text("Raduis")
                        Slider(value: radius, in: 0.01...1)
                    }.padding(.vertical)
                        .transition(.slide)
                }

            HStack {
                Button("Change Filter") {
                    self.showingFilterSheet = true
                    }

                    Spacer()

                    Button("Save") {
                        guard let processedImage = self.processedImage else { return }

                        let imageSaver = ImageSaver()

                        imageSaver.successHandler = {
                            print("Success!")
                        }

                        imageSaver.errorHandler = {
                            print("Oops: \($0.localizedDescription)")
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                    .disabled(image == nil)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
        }
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
       .actionSheet(isPresented: $showingFilterSheet) {
            ActionSheet(title: Text("Select a filter"), buttons: [
                .default(Text("Crystallize")) {
                    self.setFilter(CIFilter.crystallize())
                    self.currentFilterName = "Crystallize"
                },
                .default(Text("Edges")) {
                    self.setFilter(CIFilter.edges())
                    self.currentFilterName = "Edges"
                },
                .default(Text("Gaussian Blur")) {
                    self.setFilter(CIFilter.gaussianBlur())
                    self.currentFilterName = "Gaussian Blur"
                },
                .default(Text("Pixellate")) {
                    self.setFilter(CIFilter.pixellate())
                    self.currentFilterName = "Pixellate"
                },
                .default(Text("Sepia Tone")) {
                    self.setFilter(CIFilter.sepiaTone())
                    self.currentFilterName = "Sepia Tone"
                },
                .default(Text("Unsharp Mask")) {
                    self.setFilter(CIFilter.unsharpMask())
                    self.currentFilterName = "Unsharp Mask"
                },
                .default(Text("Vignette")) {
                    self.setFilter(CIFilter.vignette())
                    self.currentFilterName = "Vignette"
                },
                .cancel()
            ])
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        
        currentFilter = filter
        loadImage()
    }
    
    func loadImage()
    {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else {
            return
        }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
