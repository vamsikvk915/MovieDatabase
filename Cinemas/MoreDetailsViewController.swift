//
//  MoreDetailsViewController.swift
//  Cinemas
//
//  Created by vamsi krishna reddy kamjula on 7/31/17.
//  Copyright © 2017 kvkr. All rights reserved.
//

import UIKit

class MoreDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var wallpaperImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var dateOfReleaseLabel: UILabel!
    @IBOutlet weak var overviewDescriptionLabel: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var movieID:Double?
    var posterImage:String?
    var movieOverview:String?
    var wallpaper:String?
    var dateReleased:String?
    var averageRating:Double?
    
    
    var movieTitle = [String]()
    var posterImages = [String]()
    var overviewOfMovie = [String]()
    var backdropPoster = [String]()
    var releaseDate = [String]()
    var averageVote = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let urlSting = "https://api.themoviedb.org/3/movie/\(String(describing: movieID!))/similar?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        let baseURLForImage = "http://image.tmdb.org/t/p/w780/"
        
        let url = URL.init(string: urlSting)
        do {
            let data = try Data.init(contentsOf: url!)
            let response = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            let results = response["results"] as! [[String:Any]]
            for temp in results {
                let movieName = temp["title"] as! String
                movieTitle.append(movieName)
                let poster = temp["poster_path"] as! String
                let posterURL = baseURLForImage + poster
                posterImages.append(posterURL)
                let overview = temp["overview"] as! String
                overviewOfMovie.append(overview)
                let wallposter = temp["backdrop_path"] as! String
                let backdropURL = baseURLForImage + wallposter
                backdropPoster.append(backdropURL)
                let release = temp["release_date"] as! String
                releaseDate.append(release)
                let average = temp["vote_average"] as! Double
                averageVote.append(average)
            }
            
        }catch let error {
            print(error)
        }
        
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
        dateOfReleaseLabel.text = "Released: \(dateReleased!)"
        overviewDescriptionLabel.text = movieOverview!
        overviewDescriptionLabel.numberOfLines = 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "otherMovies", for: indexPath)
        let imageView = cell.viewWithTag(1) as! UIImageView
        
        let posterurl = URL.init(string: posterImages[indexPath.row])
        do {
            let data = try Data.init(contentsOf: posterurl!)
            let image = UIImage.init(data: data)
            imageView.image = image
        } catch let error {
            print(error)
        }
        
        let titleLabel = cell.viewWithTag(2) as! UILabel
        titleLabel.text = movieTitle[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "otherMovieDetails" {
            let destinationVC = segue.destination as! OtherMovieDetailsViewController
            let cell = sender as? UICollectionViewCell
            let indexPath = self.myCollectionView.indexPath(for: cell!)
            
            destinationVC.title = movieTitle[indexPath!.row]
            destinationVC.posterImage = posterImages[indexPath!.row]
            destinationVC.wallpaper = backdropPoster[indexPath!.row]
            destinationVC.movieOverview = overviewOfMovie[indexPath!.row]
            destinationVC.averageRating = averageVote[indexPath!.row]
            destinationVC.dateReleased = releaseDate[indexPath!.row]
        }
    }
}
