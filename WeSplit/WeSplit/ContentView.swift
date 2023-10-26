////
////  ContentView.swift
////  WeSplit
////
////  Created by Funnmedia's Mac on 19/10/23.
////
//
//import SwiftUI
//import UIKit
//
//struct ContentView: View {
//
//    @State private var tapCount = 2
//    @State private var tip = 20
//    @FocusState private var amountIsFocused : Bool
//    let tips = [10, 15, 20, 25, 0]
//    @State private var billAmount = 0.0
//    var totalPerPerson : Double {
//        let peopleCount = Double(tapCount + 2)
//        let tipSelection = Double(tip)
//
//        let tipValue = billAmount / 100 * tipSelection
//        let grandTotal = billAmount + tipValue
//        let AmountPerPerson = grandTotal / peopleCount
//        return AmountPerPerson
//    }
//    var totalPerson : Double {
//        let peopleCount = Double(tapCount + 2)
//        let tipSelection = Double(tip)
//
//        let tipValue = billAmount / 100 * tipSelection
//        let grandTotal = billAmount + tipValue
//        let AmountPerPerson = grandTotal / peopleCount
//        return grandTotal
//    }
//
//    var body: some View {
//        NavigationView{
//            Form {
//                Section("Amount of bill"){
//                    TextField("Enter Bill Amount", value: $billAmount, format: .currency(code: "INR"))
//                        .focused($amountIsFocused)
//                }
//
//                Section{
//                    Picker("Number of People", selection : $tapCount){
//                        ForEach(2..<100){
//                            Text("\($0) people's")
//                        }
//                    }
//                    .pickerStyle(.automatic)
//                }
//
//                Section("How much do you want to tip"){
//                    Picker("Tip Percentage", selection: $tip){
////                        ForEach(tips, id: \.self){
////                            Text($0 , format: .percent)
////                        }
//                        ForEach(0..<101){
//                            Text("\($0) %")
//                        }
//                    }
//                    .pickerStyle(.automatic)
//                }
//
//
//
//                Section("total per person with \(tip)% tip"){
//                    Text (totalPerPerson, format: .currency(code:"INR"))
//                }
//                Section("total amount with \(tip)% tip"){
//                    Text (totalPerson, format: .currency(code:"INR"))
//                }
//
//            }
//            .navigationTitle("WeSPLIT")
//            .toolbar{
//                if amountIsFocused{
//                    Button("Done"){
//                        amountIsFocused = false
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//





//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Paul Hudson on 11/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""

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
                    .foregroundStyle(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
//                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
//                .clipShape(.rect(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            score -= 1
        }

        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
