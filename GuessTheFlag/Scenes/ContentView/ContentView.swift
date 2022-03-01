//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Gabriel Pereira on 23/02/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Property Wrappers
    @State private var showingScore: Bool = false
    @State private var scoreTitle: String = ""
    @State private var scoreMessage: String = ""
    @State private var gameScore: Int = 0
    @State private var countries: [Countries] = Countries.allCases.shuffled()
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    @State private var userGameTries: Int = 0
    @State private var showEndingGame: Bool = false
    
    // MARK: - Properties
    private let maxUserTries: Int = 8
    
    // MARK: - UI Components
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
    
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        
                        Text(countries[correctAnswer].rawValue)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number].rawValue)
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                VStack {
                    Text("Score: \(gameScore)")
                        .foregroundColor(.white)
                        .font(.title.bold())
                }
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
        .alert("The game has ended", isPresented: $showEndingGame) {
            Button("Reset game", role: .cancel, action: reset)
        } message: {
            Text("Congratulations! You're final score is \(gameScore). Reset the game to play again.")
        }
    }
    
    // MARK: - Methods
    func flagTapped(_ number: Int) {
        updateGameScore(number)
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func updateGameScore(_ number: Int) {
        if number == correctAnswer {
            gameScore += 1
            scoreTitle = "Correct"
            scoreMessage = "Your score is \(gameScore)"
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "Wrong! That's the flag of \(countries[number])."
        }
        
        shouldEndGame()
    }
    
    func shouldEndGame() {
        userGameTries += 1
        
        if userGameTries == maxUserTries {
            showEndingGame = true
        } else {
            showingScore = true
        }
    }
    
    func reset() {
        userGameTries = 0
        gameScore = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
