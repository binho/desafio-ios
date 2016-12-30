import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    public func loadImageUsingCacheWithURL(url: NSURL) {
        self.image = nil
        
        let cacheKey = NSString(string: url.absoluteString!)

        if let cachedImage = imageCache.object(forKey: cacheKey) {
            //print("Loading image from cache: \(cacheKey)")
            self.image = cachedImage
            return
        } else {
            URLSession.shared.dataTask(with: url as URL, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    DispatchQueue.main.async(execute: { () -> Void in
                        if let downloadedImage = UIImage(data: data!) {
                            //print("Downloaded image and save on cache: \(cacheKey)")
                            imageCache.setObject(downloadedImage, forKey: cacheKey)
                            self.image = downloadedImage
                        }
                    })
                }
            }).resume()
        }
    }

}
