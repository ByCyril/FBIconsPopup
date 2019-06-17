//
//  ViewController.swift
//  FBPopupView
//
//  Created by Cyril Garcia on 6/13/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PopupContainerViewDelegate {
    
    private var iconsContainerView: PopupContainerView!

    private let thumbsDownButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 300, y: 300, width: 50, height: 50))
        button.setImage(UIImage(named: "dislike"), for: .normal)
        button.tag = -1
        button.addTarget(self, action: #selector(ViewController.showPopupcontainer(_:)), for: .touchUpInside)
        return button
    }()
    
    private let thumbsUpButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 25, y: 300, width: 50, height: 50))
        button.setImage(UIImage(named: "like"), for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(ViewController.showPopupcontainer(_:)), for: .touchUpInside)
        return button
    }()
    
    private var iconsAreShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(thumbsDownButton)
        view.addSubview(thumbsUpButton)
        
    }
    
    @objc
    private func showPopupcontainer(_ sender: UIButton) {
        if !iconsAreShowing {
            iconsContainerView = PopupContainerView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
            iconsContainerView.delegate = self
            
            var padding: CGFloat!
            if sender.tag == -1 {
                padding = view.frame.size.width - (iconsContainerView.frame.size.width / 2) - 10
            } else {
                padding = (iconsContainerView.frame.size.width / 2) + 10
            }
            
            self.iconsContainerView.center = CGPoint(x: padding, y: sender.center.y)
            
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
                self.iconsContainerView.alpha = 1
                self.iconsContainerView.center.y = sender.center.y - sender.frame.size.height - 15
                self.view.addSubview(self.iconsContainerView)
            })
            iconsAreShowing = true
        }
        
    }
    
    private func dismissIconContainer() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.iconsContainerView.alpha = 0
        }) { (_) in
            self.iconsContainerView.removeFromSuperview()
            self.iconsAreShowing = false
        }
    }
    
    func selectedIcon(_ index: Int) {
        dismissIconContainer()
        print("Selected",index)
    }
    
}

