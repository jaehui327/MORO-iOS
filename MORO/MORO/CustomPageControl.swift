//
//  CustomPageControl.swift
//  MORO
//
//  Created by 이재성 on 29/07/2018.
//  Copyright © 2018 김재희. All rights reserved.
//

import UIKit

class CustomPageControl: UIPageControl {
    override var currentPage: Int {
        didSet {
            updateDots(currentPage: currentPage)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        currentPage = 0
        tintColor = .clear
        pageIndicatorTintColor = .clear
        currentPageIndicatorTintColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateDots(currentPage: Int) {
        for (index, subview) in subviews.enumerated() {
            let imageView: UIImageView
            if let existingImageview = getImageView(forSubview: subview) {
                imageView = existingImageview
            } else {
                imageView = UIImageView(image: #imageLiteral(resourceName: "indicatorOff.png"))
                
                imageView.center = subview.center
                subview.addSubview(imageView)
                subview.clipsToBounds = false
            }
            imageView.image = currentPage == index ?  #imageLiteral(resourceName: "indicatorOn.png") : #imageLiteral(resourceName: "indicatorOff.png")
        }
    }
    
    private func getImageView(forSubview view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView {
            return imageView
        } else {
            let view = view.subviews.first { (view) -> Bool in
                return view is UIImageView
                } as? UIImageView
            
            return view
        }
    }
}
