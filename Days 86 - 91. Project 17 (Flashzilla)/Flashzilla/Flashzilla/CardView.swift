//
//  CardView.swift
//  Flashzilla
//
//  Created by Vlad Vrublevsky on 07.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    let card: Card
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    var removal: (()-> Void)? = nil
    @State private var feedback = UINotificationFeedbackGenerator()
    
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(
                        differentiateWithoutColor
                            ? Color.white
                            : Color.white
                                .opacity(1 - Double(abs(offset.width / 50)))
                    )
                    .shadow(radius: 10)
                    .background(
                        differentiateWithoutColor
                            ? nil
                            :  RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(self.offset.width > 0 ? Color.green : Color.red)
                    )
                
                    VStack {
                        if accessibilityEnabled {
                            Text(isShowingAnswer ? card.answer : card.prompt)
                                .font(.largeTitle)
                                .foregroundColor(.black)
                        } else {
                            Text(card.prompt)
                                .font(.largeTitle)
                                .foregroundColor(.black)

                            if isShowingAnswer {
                                Text(card.answer)
                                    .font(.title)
                                    .foregroundColor(.gray)
                            }
                        }
                }
                .padding(20)
                .multilineTextAlignment(.center)
            }
            .rotationEffect(.degrees(Double(offset.width / 5)))
            .offset(x: offset.width * 5, y: 0)
            .opacity(2 - (Double(abs(offset.width) / 50)))
            .accessibility(addTraits: .isButton)
            .gesture(
                DragGesture()
                    .onChanged() { gesture in
                        self.offset = gesture.translation
                        self.feedback.prepare()
                    }
                    .onEnded() { _ in
                        if abs(self.offset.width) > 100 {
                            
                            if self.offset.width < 0 {
                                self.feedback.notificationOccurred(.error)
                            }
                            
                            self.removal?()
                        } else {
                            withAnimation {
                                self.offset = .zero
                            }
                        }
                    }
            )
            .frame(width: 450, height: 250)
            .onTapGesture {
                //withOptionalAnimation {
                    self.isShowingAnswer.toggle()
                //}
            }
            .animation(.spring())
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
            .previewLayout(.fixed(width: 500, height: 300))
    }
}
