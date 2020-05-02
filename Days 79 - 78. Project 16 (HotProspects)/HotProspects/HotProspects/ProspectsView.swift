//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Vlad Vrublevsky on 02.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    let filter: FilterType
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    @EnvironmentObject var prospects: Prospects
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return self.prospects.people
        case .contacted:
            return self.prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return self.prospects.people.filter { !$0.isContacted }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(trailing: Button(action: {
                let prospect = Prospect()
                prospect.name = "Paul Hudson"
                prospect.emailAddress = "paul@hackingwithswift.com"
                self.prospects.people.append(prospect)
            }, label: {
                Image(systemName: "qrcode.viewfinder")
                Text("Scan")
            }))
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        return ProspectsView(filter: .none).environmentObject(Prospects())
    }
}
