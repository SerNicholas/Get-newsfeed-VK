//
//  WebView.swift
//  Get newsfeed VK
//
//  Created by Nikola on 04/07/2020.
//  Copyright © 2020 Nikola Krstevski. All rights reserved.
//

import UIKit
import Kingfisher

class WebImageView: UIImageView {
    
    func set(imageURL: String?) {
        
        guard let imageUrl = imageURL, let url = URL(string: imageUrl) else { return }
        
        let processor = DownsamplingImageProcessor(size: self.bounds.size) |> RoundCornerImageProcessor(cornerRadius: 0)
        self.kf.indicatorType = .activity
        
        self.kf.setImage(
            with: .network(url),
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage 
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
}
