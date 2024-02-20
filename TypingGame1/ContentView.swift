//
//  ContentView.swift
//  TypingGame1
//
//  Created by yukifuruhashi on 2023/09/10.
//

import SwiftUI

struct ContentView: View {

    enum FocusTextFields {
        case input
    }

    @State private var timeRemaining = 30
    @State private var timer: Timer?
    @State private var targetText = "a"
    @State private var inputText = ""
    @State private var score = 0
    @State private var missType = 0
    @State private var gameOver = true
    @FocusState private var focusState: FocusTextFields?
    @State private var newTargetText = "a"


    var body: some View {

        ZStack {

            Color("BG")
                .ignoresSafeArea()

            VStack {

                Text("あるふぁべっとたいぴんぐ")
                    .font(.title)
                    .bold()
                    .font(.system(.title, design: .rounded))

                    .foregroundColor(Color("colorset1"))
                    .padding(.bottom, 30)

                Text("のこりじかん: \(timeRemaining)")
                    .foregroundColor(Color("colorset1"))
                    .bold()
                    .font(.system(.title, design: .rounded))

                if gameOver == true {
                    Text("あーゆーれでぃー？")
                        .padding()
                        .foregroundColor(Color("colorset1"))
                        .bold()
                        .font(.system(.largeTitle, design: .rounded))
                } else {
                    Text("\(targetText)")
                        .font(.system(size: 100, weight: .bold, design: .rounded))

                }

                TextField("ここに入力", text: $inputText)
                    .focused($focusState, equals: .input)
                    .textInputAutocapitalization(.never)

                    .textFieldStyle(.roundedBorder)

                    //.disabled(gameOver == true)
                    .onChange(of: inputText) { newValue in
                        checkText()
                    }


                Text("すこあ: \(score)")
                    .foregroundColor(Color("colorset1"))
                    .font(.headline)
                    .bold()

                Text("みすたいぴんぐ: \(missType)")
                    .foregroundColor(Color("colorset1"))
                    .font(.headline)
                    .bold()


                HStack {
                    Button {
                        focusState = .input
                        startTimer()
                        startGame()
                        gameOver = false

                    } label: {
                        Text("げーむすたーと")
                            .frame(width: 150, height: 80)
                            .font(.headline)
                            .bold()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("BG")))
                            .shadow(color: Color("lightShadow"), radius: 8, x: -8, y: -8)
                            .shadow(color: Color("darkShadow"), radius: 8, x: 8, y: 8)
                            .padding()
                    } //Buttonここまで
                    .disabled(gameOver == false)

                    Button {
                        gameOver = true
                        timer?.invalidate()
                        timeRemaining = 30
                    } label: {
                        Text("げーむ\nしゅうりょう")
                            .frame(width: 150, height: 80)
                            .font(.headline)
                            .bold()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("BG")))
                            .shadow(color: Color("lightShadow"), radius: 8, x: -8, y: -8)
                            .shadow(color: Color("darkShadow"), radius: 8, x: 8, y: 8)
                            .padding()
                    }
                    .disabled(gameOver == true)
                }




            } //Vstackここまで
            .padding()

        } //ZStackここまで


    }



    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                gameOver = true
            }
        }
    }


    func startGame() {
        score = 0
        missType = 0
        timeRemaining = 30

        targetText = generateNewTargetText()

    }



    func checkText() {

        if gameOver == false {
            if inputText == "" {

            } else if inputText == targetText {
                    score += 1
                    inputText = ""
                    targetText = generateNewTargetText()

            } else {
                    missType += 1
                    inputText = ""
            }
        } else {
            inputText = ""
        }
    }



    func generateNewTargetText() -> String {
        //let newTargetTexts: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

        let newTargetTexts: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

        repeat {
            newTargetText = newTargetTexts.randomElement() ?? "a"
        } while newTargetText == targetText

        return newTargetText
    }



}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Claymorphism: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .background(
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color("signUpButton2"), Color("signUpButton1")]), startPoint: .topLeading, endPoint: .bottomTrailing))

                    .overlay(
                        Rectangle()
                            .stroke(Color.white.opacity(0.37), lineWidth: 6)
                            .offset(x: 3.0, y: 2.0)
                            .clipped()
                            .blur(radius: 10)
                    )
                    .overlay(
                        Rectangle()
                            .stroke(Color.black.opacity(0.37), lineWidth: 6)
                            .offset(x: -3.0, y: -3.0)
                            .clipped()
                            .blur(radius: 5)
                    )
                    .cornerRadius(10)
            )
            .shadow(color: Color("shadow"), radius: 10, x: 0, y: 20)
    }
}
