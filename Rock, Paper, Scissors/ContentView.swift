//
//  ContentView.swift
//  Rock, Paper, Scissors
//
//  Created by Alexandre Talatinian on 03/06/2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    
    var moves = ["✊", "🤚", "✌️"]
    
    @State private var computerChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    
    @State private var score = 0
    @State private var questionCount = 1
    @State private var showingResults = false
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.indigo, .cyan]), startPoint: .leading, endPoint: .trailing)
                .ignoresSafeArea()
//            RadialGradient(colors: [.gray, .indigo], center: .top, startRadius: 1, endRadius: 600)
//                .ignoresSafeArea()
            
            Spacer()
            
            VStack {
                Text("AI has played ..")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(moves[computerChoice])
                    .font(.system(size: 200))
                
                if shouldWin {
                    Text("Try to win the game")
                        .foregroundColor(.green)
                        .font(.title)
                        .fontWeight(.black)
                } else {
                    Text("You must lose this time")
                        .foregroundColor(.red)
                        .font(.title)
                        .fontWeight(.black)
                }
                
                Spacer()
            } //: VSTACK
            
            VStack{
                
                HStack(spacing: 30) {
                    ForEach(0..<3) { number in
                        Button(moves[number]) {
                            play(choice: number)
                    }
                    .font(.system(size: 80))
                }
                } //: HSTACK
                .frame(maxWidth: .infinity)
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                
                
                Text("Score: \(score)")
                    .font(.subheadline)
                
                
                } //: VSTACK
                .alert("Game over", isPresented: $showingResults) {
                    Button("Play again", action: reset)
                } message: {
                    Text("Your score was \(score)")
                }
            } //: ZSTACK
        }
        func play(choice: Int) {
            let winningMoves = [1, 2, 0]
            let didWin: Bool
            
            if shouldWin {
                didWin = choice == winningMoves[computerChoice]
            } else {
                didWin = winningMoves[choice] == computerChoice
            }
            
            if didWin {
                score += 1
            } else {
                score -= 1
            }
            
            if questionCount == 10 {
                showingResults = true
            } else {
                computerChoice = Int.random(in: 0..<3)
                shouldWin.toggle()
                questionCount += 1
            }
        }
    
        func reset() {
            computerChoice = Int.random(in: 0..<3)
            shouldWin = Bool.random()
            questionCount = 0
            score = 0
        }
    }

    // MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
