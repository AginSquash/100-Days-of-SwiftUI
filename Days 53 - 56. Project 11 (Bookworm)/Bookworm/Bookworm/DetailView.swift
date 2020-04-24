//
//  DetailView.swift
//  Bookworm
//
//  Created by Vlad Vrublevsky on 24.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing)
                {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geometry.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x:-5, y: -5)
                }
                
                Text(self.book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)

                Text(self.book.review ?? "No review")

                HStack {
                    Spacer()
                    Text(self.getParsedTime())
                    .padding()
                }
                
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete book"), message:  Text("Are you sure?"), primaryButton: .destructive(Text("Delete"), action: { self.deleteBook() } ), secondaryButton: .cancel())
        }
        .navigationBarTitle(Text(self.book.title ?? "Unknown Book"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: { self.showingDeleteAlert = true },
                                            label: { Image(systemName: "trash") }
        ) )
    }
    
    func getParsedTime() -> String {
        let formater = DateFormatter()
        formater.dateStyle = .medium
        
        guard self.book.date != nil else {
            fatalError("self.book.date is nil")
        }
        return formater.string(from: self.book.date ?? Date() )
    }
    
    func deleteBook()
    {
        moc.delete(book)
        try? moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
               book.title = "Test book"
               book.author = "Test author"
               book.genre = "Fantasy"
               book.rating = 4
               book.review = "This was a great book; I really enjoyed it."
               book.date = Date()
        
               return NavigationView {
                   DetailView(book: book)
               }
    }
}
