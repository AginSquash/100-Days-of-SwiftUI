//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Vlad Vrublevsky on 02.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI
import CodeScanner
import UserNotifications

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
        
        var people: [Prospect]
        if sortedByDate {
            people = self.prospects.people.sorted(by: { $0.date < $1.date } )
        } else {
            people = self.prospects.people.sorted()
        }
        
        switch filter {
        case .none:
            return people
        case .contacted:
            return people.filter { $0.isContacted }
        case .uncontacted:
            return people.filter { !$0.isContacted }
        }
    }
    
    @State private var isShowingScanner = false
    @State private var isShowingSortedSheet = false
    @State private var sortedByDate = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(prospect.name)
                                .font(.headline)
                            Image(systemName: prospect.isContacted ? "checkmark.circle" : "questionmark.circle" )
                        }
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                    .contextMenu(menuItems: {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted" ) {
                            self.prospects.toggle(prospect)
                        }
                        
                        if !prospect.isContacted {
                            Button("Remind Me at 9 am") {
                                self.addNotification(for: prospect)
                            }
                        }
                        
                    })
                }
            .onDelete(perform: delete)
            }
            .navigationBarTitle(title)
            .navigationBarItems(leading:
                Button(action: { self.isShowingSortedSheet = true },
                       label: { Text("Sorted by: \(self.sortedByDate ? "Date" : "Name")") })
            ,
                trailing: Button(action: {
                self.isShowingScanner = true
            }, label: {
                Image(systemName: "qrcode.viewfinder")
                Text("Scan")
            }))
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: self.handleScanner)
                    .edgesIgnoringSafeArea(.bottom)
            }
            .actionSheet(isPresented: $isShowingSortedSheet) {
                ActionSheet(title: Text("Choose sorted type"), message: nil, buttons: [
                    .default(Text("By name"), action: { self.sortedByDate = false }),
                    .default(Text("By date"), action: { self.sortedByDate = true })
                ])
            }
        }
    }
    
    func delete(at indexSet: IndexSet) {
        for index in indexSet
        {
            self.prospects.delete(personDelete: self.filteredProspects[index] )
        }
    }
    
    func handleScanner(result: Result<String, CodeScannerView.ScanError> ) {
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            
            guard details.count == 2 else { return }
            
            let newPerson = Prospect()
            newPerson.name = details[0]
            newPerson.emailAddress = details[1]
            newPerson.date = Date()
            
            self.prospects.add(newPerson)
            
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = .default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings() { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Access denied")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        return ProspectsView(filter: .none).environmentObject(Prospects())
    }
}
