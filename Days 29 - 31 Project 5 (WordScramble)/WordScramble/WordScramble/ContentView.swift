//
//  ContentView.swift
//  WordScramble
//
//  Created by Vlad Vrublevsky on 05.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords =  ["word1", "word2","word3", "word4", "word5", "word6", "word7", "word8", "word9","word10", "word11", "word12", "word", "word6", "word7", "word1", "word2","word3", "word4", "word5", "word6", "word7", "word8", "word9","word10", "word11", "word12", "word", "word6", "word7"] //[String]()
    @State private var rootWord = String()
    @State private var newWord = String()
    @State private var score = 0
    @State private var totalWord = 1
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    func updateScore(word: String) {
        score += totalWord + word.count
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempRootWord = rootWord
        
        for letter in word
        {
            if let pos = tempRootWord.firstIndex(of: letter) {
                tempRootWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func startGame()
    {
        self.usedWords = ["word1", "word2","word3", "word4", "word5", "word6", "word7", "word8", "word9","word10", "word11", "word12", "word", "word6", "word7", "word1", "word2","word3", "word4", "word5", "word6", "word7", "word8", "word9","word10", "word11", "word12", "word", "word6", "word7"]
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: ".txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError()
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        #if !DEBUG
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word.")
            return
        }
        
        guard answer.count > 2 else {
            return
        }

        guard answer != rootWord else {
            wordError(title: "Word incorrect", message: "That start word")
            return
        }
        #endif
        
        updateScore(word: answer)
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    var body: some View {
        NavigationView {
                VStack {
                    TextField("Enter your word", text: self.$newWord, onCommit: self.addNewWord)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                    
                    GeometryReader { fullView in
                        List(self.usedWords, id: \.self) { word in
                            GeometryReader { geo in
                                HStack {
                                    Image(systemName: "\(word.count).circle")
                                    Text("\(word)")
                                    Spacer()
                                }
                                .modifier(OffsetForWord(fullViewY: fullView.frame(in: .global).maxY, minY: geo.frame(in: .global).minY))
                                .onTapGesture {
                                    print("fullViewY: \(fullView.frame(in: .global).maxY)")
                                    print(" Y: \(geo.frame(in: .global).minY)")
                                }
                            }
                        }
                    }
                    Text("Your score: \(self.score)")
                        .font(.headline)
                        .padding()
                }
           // }
            .navigationBarTitle(self.rootWord)
            .navigationBarItems(trailing:
                Button(action: self.startGame, label: {
                    Image(systemName: "arrow.clockwise")
                        .resizable()
                    .scaledToFill()
                })
        )
            .onAppear(perform: self.startGame)
            .alert(isPresented: self.$showingError) {
                Alert(title: Text(self.errorTitle), message: Text(self.errorMessage), dismissButton: .default(Text("OK")))
            }
        
        }
    }
}

struct OffsetForWord: ViewModifier {
    var fullViewY: CGFloat
    var minY: CGFloat
    func body(content: Content) -> some View {
        if (minY > fullViewY / 100 * 80) {
            return content.offset(x: (minY / fullViewY - 0.8 ) * 1400 , y: 0)
        }
        return content.offset(x: 0, y: 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
