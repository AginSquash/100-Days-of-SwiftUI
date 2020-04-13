//
//  AddView.swift
//  iExpense
//
//  Created by Vlad Vrublevsky on 13.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @State private var name = String()
    @State private var type = "Personal"
    @State private var amount = String()
    
    @ObservedObject var expenses: Expenses
    
    @Environment(\.presentationMode) var presentationMode
    @State private var isIncrorrectInput = false
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id:\.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
        .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                  
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode( self.expenses.items) {
                            UserDefaults.standard.set(encoded, forKey: "Items")
                    }
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.isIncrorrectInput = true
                }
            })
        }.alert(isPresented: $isIncrorrectInput) {
            Alert(title: Text("Incorrect input!"), message: Text("Amount cannot be a string"), dismissButton: .default(Text("Ok"), action: { self.amount = "" }))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
