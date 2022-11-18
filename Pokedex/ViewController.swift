//
//  ViewController.swift
//  Pokedex
//
//  Created by Jacob Wise on 11/18/22.
//

import UIKit
import HTMLKit
import WebKit

class ViewController: UIViewController {
    let url = "https://pokemondb.net/pokedex/game/scarlet-violet"

    private let webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let prefs = WKPreferences()
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.addSubview(webView)
        self.webView.frame = self.view.bounds
        self.webView.navigationDelegate = self
        guard let url = URL(string: self.url) else { return }
        self.webView.load(URLRequest(url: url))
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        parseimages()
    }
    func parseimages()
    {
        webView.evaluateJavaScript("documents.body.innerHTML") { result, error in
            guard let html = result as? String, error == nil else {
                return
            }
            let document = HTMLDocument(string: html)
            let images: [String] = document.querySelectorAll("img").compactMap({element in
                guard let src = element .attributes["src"] as? String else {
                    return nil
                }
                return src
            })
            print(images.count)
            for src in images {
                print(src+"\n")
            }
            //<img src="..." />
            
        }
    }
}


