//
//  Loading.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 27/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit
import SnapKit

class Loading: UIImageView {
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.contentMode = .scaleAspectFit
        self.backgroundColor = .white
        self.animationImages = self.getLoadingImages()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func getLoadingImages() -> [UIImage] {
        var images = [UIImage]()
        for index in 0...29 {
            guard let image = UIImage(named: "loading\(index)") else {
                break
            }
            images.append(image)
        }
        return images
    }
}
