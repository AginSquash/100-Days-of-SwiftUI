//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Vlad Vrublevsky on 15.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct ResortView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    @EnvironmentObject var favorites: Favorites
    
    let resort: Resort
    @State private var selectedFacility: String?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                HStack {
                    Spacer()
                    Text("© " + resort.imageCredit)
                        .foregroundColor(.secondary)
                    Spacer()
                }

                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                   HStack {
                        if sizeClass == .compact {
                            Spacer()
                            VStack { ResortDetailsView(resort: resort) }
                            VStack { SkiDetailsView(resort: resort) }
                            Spacer()
                        } else {
                            ResortDetailsView(resort: resort)
                            Spacer().frame(height: 0)
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text("Facilities")
                        .font(.headline)

                    HStack {
                        ForEach(resort.facilities, id: \.self) { facility in
                            Facility.icon(for: facility)
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                    
                }
                .padding(.horizontal)
                
                Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                    if self.favorites.contains(self.resort) {
                        self.favorites.remove(self.resort)
                    } else {
                        self.favorites.add(self.resort)
                    }
                }
                .padding()
            }
            
        }
        .alert(item: $selectedFacility) { facility in
                Facility.alert(for: facility)
            }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        let favorites = Favorites()
        return ResortView(resort: Resort.example).environmentObject(favorites)
    }
}
