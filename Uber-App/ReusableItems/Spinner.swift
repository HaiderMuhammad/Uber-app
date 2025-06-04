//
//  Spinner.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/4/25.
//

import SwiftUI

struct Spinner: View {
    
    let rotationTime: Double  = 0.75
    let animationTime: Double = 1.9
    let fullRotation: Angle = .degrees(360)
    
    static let initialDegree: Angle = .degrees(270)
    let lineWidth: CGFloat
    let heigth: CGFloat
    let width: CGFloat
    
    @State var spinnerStart: CGFloat    = 0.0
    @State var spinnerEndS1: CGFloat    = 0.03
    @State var spinnerEndS2S3: CGFloat  = 0.03
    
    @State var rotationDegreeS1 = initialDegree
    @State var rotationDegreeS2 = initialDegree
    @State var rotationDegreeS3 = initialDegree
    
    
    var body: some View {
        ZStack {
            
            ZStack {
                // S3
                SpinnerCircle(start: spinnerStart,
                              end: spinnerEndS2S3,
                              rotation: rotationDegreeS3,
                              color: .blue,
                              lineWidth: lineWidth)
                // S2
                SpinnerCircle(start: spinnerStart,
                              end: spinnerEndS2S3,
                              rotation: rotationDegreeS2,
                              color: .blue,
                              lineWidth: lineWidth)
                // S1
                SpinnerCircle(start: spinnerStart,
                              end: spinnerEndS1,
                              rotation: rotationDegreeS1,
                              color: .black,
                              lineWidth: lineWidth)
            }
            .frame(width: width, height: heigth)
        }
        .onAppear() {
            self.animateSpinner()
            Timer.scheduledTimer(withTimeInterval: animationTime, repeats: true) { (mainTime) in
                self.animateSpinner()
            }
        }
    }
    
    // MARK: - Animation methods
    func animateSpinner(with duration: Double, completion: @escaping (() -> Void)) {
        Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { _ in
            withAnimation(Animation.easeInOut(duration: self.rotationTime)) {
                completion()
            }
        }
    }
    
    func animateSpinner() {
        animateSpinner(with: rotationTime) { self.spinnerEndS1 = 1.0 }
        
        animateSpinner(with: (rotationTime * 2) - 0.025) {
            self.rotationDegreeS1 += fullRotation
            self.spinnerEndS2S3 = 0.8
        }
        
        animateSpinner(with: (rotationTime * 2)) {
            self.spinnerEndS1   = 0.03
            self.spinnerEndS2S3 = 0.03
        }
        
        animateSpinner(with: (rotationTime * 2) + 0.0525) {
            self.rotationDegreeS2 += fullRotation
        }
        
        animateSpinner(with: (rotationTime * 2) + 0.225) {
            self.rotationDegreeS3 += fullRotation
        }
    }
}

struct SpinnerCircle: View {
    var start: CGFloat
    var end: CGFloat
    var rotation: Angle
    var color: Color
    var lineWidth: CGFloat
    
    var body: some View {
        Circle()
            .trim(from: start, to: end)
            .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            .fill(color)
            .rotationEffect(rotation)
    }
}

#Preview {
    ZStack {
        Spinner(lineWidth: 12, heigth: 120, width: 120)
    }
}
