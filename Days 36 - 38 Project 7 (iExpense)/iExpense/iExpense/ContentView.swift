//
//  ContentView.swift
//  iExpense
//
//  Created by Vlad Vrublevsky on 13.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    private static let itemsKey = "Items"
    
    @Published var items: [ExpenseItem] {
        didSet { // This doesn't work due to a bug in swift 5.2 https://bugs.swift.org/browse/SR-12089
            let encoder = JSONEncoder()

            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: Self.itemsKey)
            }
        }
    }

    init() {
        if let items = UserDefaults.standard.data(forKey: Self.itemsKey) {
            let decoder = JSONDecoder()

            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                        Text("$\(item.amount)")
                            .foregroundColor( Self.getColor(amount: item.amount) )
                    }
                }
            .onDelete(perform: removeItems)
            }
        .navigationBarTitle("iExpense")
        .navigationBarItems(leading: EditButton(), trailing:
            Button(action: {
                self.showingAddExpense = true
            }, label: { Text("Add") }))
           
        }
        .sheet(isPresented: $showingAddExpense, content: { AddView(expenses: self.expenses) })
    }
    
    static func getColor(amount: Int) -> Color
    {
        if (amount > 100) {
            return Color.red
        }
        if amount > 10 {
            return Color.yellow
        }
        return Color.green
    }
    
    func removeItems(at offsests: IndexSet) {
        self.expenses.items.remove(atOffsets: offsests)
        saveItems()
    }
    
    func saveItems() {
        let encoder = JSONEncoder()

        if let encoded = try? encoder.encode( expenses.items) {
            UserDefaults.standard.set(encoded, forKey: "Items")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
