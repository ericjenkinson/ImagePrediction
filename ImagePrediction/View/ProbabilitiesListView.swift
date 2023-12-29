//
//  ProbabilitiesListView.swift
//  ImagePrediction
//
//  Created by Eric Jenkinson on 12/28/23.
//

import SwiftUI

struct ProbabilitiesListView: View {
  let probabilities: [Dictionary<String, Double>.Element]

  var body: some View {
    List {
      Section("Predictions") {
        ForEach(probabilities, id: \.key) { (key, value) in
          HStack {
            Text(key)
            Spacer()
            Text(value.roundTo(decimalPlaces: 2))
          }
        }
      }
    }
    .listStyle(.plain)
  }
}

#Preview {
    ContentView()
}
