//
//  PopupContainerView.swift
//  FBPopupView
//
//  Created by Cyril Garcia on 6/13/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

protocol PopupContainerViewDelegate {
    func selectedIcon(_ index: Int)
}

class PopupContainerView: UIView {
    
    private var iconStackView: UIStackView!
    private var icons = ["0","1","2","3","4"]
    public var delegate: PopupContainerViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        stackViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        layer.cornerRadius = frame.size.height / 2
    }
    
    private func stackViewSetup() {
        iconStackView = UIStackView(frame: frame)
        
        iconStackView.axis = .horizontal
        iconStackView.distribution = .fillEqually
        iconStackView.alignment = .fill
        iconStackView.spacing = 5
        let containerFrame = (frame.size.width / CGFloat(icons.count)) - 10

        icons.forEach { (item) in
            let icon = createIcons(item)
            self.iconStackView.addArrangedSubview(icon)
            
            UIView.animate(withDuration: 0.5, animations: {
                icon.frame.size = CGSize(width: containerFrame, height: containerFrame)
                icon.alpha = 1
            })
        }
        addSubview(iconStackView)
    }
    
    private func createIcons(_ imageNamed: String) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.setImage(UIImage(named: imageNamed)!, for: .normal)
        button.tag = Int(imageNamed)!
        button.addTarget(self, action: #selector(PopupContainerView.selectedIcon(_:)), for: .touchUpInside)
        button.alpha = 0
        return button
    }
    
    @objc
    private func selectedIcon(_ sender: UIButton) {
        delegate.selectedIcon(sender.tag)
    }
    
    public func animateIconsIn() {
        
    }
    
    public func animateIconsOut() {
        
    }

}
