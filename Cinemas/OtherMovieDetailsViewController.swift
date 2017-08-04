//
//  OtherMovieDetailsViewController.swift
//  Cinemas
//
//  Created by vamsi krishna reddy kamjula on 7/31/17.
//  Copyright © 2017 kvkr. All rights reserved.
//

import UIKit

class OtherMovieDetailsViewController: UIViewController {
    @IBOutlet weak var wallpaperImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var dateOfreleaseLabel: UILabel!
    @IBOutlet weak var overviewDescriptionLabel: UILabel!
    
    var movieID:Double?
    var posterImage:String?
    var movieOverview:String?
    var wallpaper:String?
    var dateReleased:String?
    var averageRating:Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let posterurl = URL.init(string: posterImage!)
        do {
            let data = try Data.init(contentsOf: posterurl!)
            let image = UIImage.init(data: data)
            posterImageView.image = image
        } catch let error {
            print(error)
        }
        
        let wallpaperurl = URL.init(string: wallpaper!)
        do {
            let data = try Data.init(contentsOf: wallpaperurl!)
            let image = UIImage.init(data: data)
            wallpaperImageView.image = image
        }catch let error {
            print(error)
        }
        
        ratingLabel.text = "Rating: \(averageRating!)"
        dateOfreleaseLabel.text = "Released: \(dateReleased!)"
        overviewDescriptionLabel.text = movieOverview!
        overviewDescriptionLabel.numberOfLines = 0
    }
    
    @IBAction func doneButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
