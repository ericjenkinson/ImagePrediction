//
//  ContentView.swift
//  ImagePrediction
//
//  Created by Eric Jenkinson on 12/27/23.
//

import SwiftUI
import CoreML

struct ContentView: View {
  @State private var imageIndex = 0
  @State private var predictions: [String: Double] = [: ]
  let images = ["image1", "image2", "image3", "image4", "image5"]
  
  let model = try! MobileNetV2(configuration: MLModelConfiguration())

  private var sortedPredictions: [Dictionary<String, Double>.Element] {
    let predictionsArray = Array(predictions)
    return predictionsArray.sorted { lhs, rhs in
      lhs.value > rhs.value
    }
  }

  var body: some View {
    VStack {
      Image(images[imageIndex])
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 300, height: 300)

      HStack {
        Button("Previous") {
          imageIndex -= 1
          predict()
        }
        .buttonStyle(.bordered)
        .disabled(imageIndex == 0)

        Button("Next") {
          imageIndex += 1
          predict()
        }
        .buttonStyle(.bordered)
        .disabled(imageIndex == images.count - 1)
      }

      ProbabilitiesListView(probabilities: sortedPredictions)
    }
    .onAppear {
      predict()
    }
    .padding()
  }

  private func predict() {
    guard let uiImage = UIImage(named: images[imageIndex]) else { return }
    let resizedImage = uiImage.resize(to: CGSize(width: 224, height: 224))

    guard let buffer = resizedImage.toCVPixelBuffer() else { return }

    do {
      let prediction = try model.prediction(image: buffer)
      predictions = prediction.classLabelProbs
    } catch {
      print(error.localizedDescription)
    }

  }
}

#Preview {
  ContentView()
}
