//
//  ActivityIndicator.swift
//  CurrenciesApp
//
//  Created by luca on 08/04/2020.
//  Copyright © 2020 luca. All rights reserved.
//

import Foundation
import SwiftUI

struct ActivityView: UIViewRepresentable {
    
    @Binding var show: Bool
    
    func makeUIView(context: UIViewRepresentableContext<ActivityView>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityView>) {
        show ? uiView.startAnimating() : uiView.stopAnimating()
    }
    
}


