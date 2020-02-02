//
//  songPlayer.swift
//  MusicX
//
//  Created by Atheer on 2020-01-05.
//  Copyright © 2020 Atheer. All rights reserved.
//

// Tried to create and music player in the app, sadly didn't work as planned will maybe revist it later
// for now the will not be a songplayer 

import SwiftUI
import WebKit

struct songPlayer: View {
    var body: some View {
        webView(htmlString: "<iframe width='\(UIScreen.main.nativeBounds.width)' height='\(UIScreen.main.nativeBounds.height)' src='https://www.youtube.com/embed/41qC3w3UUkU?controls=0' frameborder='0' allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe>")
    }
}

struct webView: UIViewRepresentable {
    let htmlString:String
    
    func makeUIView(context: UIViewRepresentableContext<webView>) -> WKWebView {
        let uiView = CustomWKWebView(frame: .zero)
        return uiView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<webView>) {
        uiView.loadHTMLString(htmlString, baseURL: URL(string: "http://www.youtube.com")!)
       
    }
}

class CustomWKWebView: WKWebView {
    let webView: WKWebView
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration = WKWebViewConfiguration()) {
        let prefs = WKPreferences()
        prefs.javaScriptEnabled = true
        let configuration = WKWebViewConfiguration()
        configuration.preferences = prefs
        //configuration.mediaTypesRequiringUserActionForPlayback = []
        configuration.allowsInlineMediaPlayback = true
        
        
        webView = WKWebView(frame: frame, configuration: configuration)
        
        super.init(frame: .zero, configuration: configuration)
     }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct songPlayer_Previews: PreviewProvider {
    static var previews: some View {
        songPlayer()
    }
}
