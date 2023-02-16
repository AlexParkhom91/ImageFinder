import Foundation
import UIKit

class DetailViewController: UIViewController {
  

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    let indicator = UIActivityIndicatorView()
    
    // MARK: - Varibles
    var currentImage: ImagesSeachResult!
    var imagesResults: [ImagesSeachResult]!
    var position: Int!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorLoad()
        updateImageView()
    }
    
    func updateImageView() {
        let url = URL(string: currentImage.original)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let imageData = data {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData)
                    self.indicator.stopAnimating()
                    self.indicator.hidesWhenStopped = true
                }
              
            }
        }
        task.resume()
        
        /// hide button(prev/next) if image first/last
        position == 0 ? (prevButton.alpha = 0) : (prevButton.alpha = 1)
        position == imagesResults.count - 1 ? (nextButton.alpha = 0) : (nextButton.alpha = 1)
    }
//MARK: - Buttons
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if position < imagesResults.count - 1 {
            position += 1
            currentImage = imagesResults[position]
            updateImageView()
        }
    }

    @IBAction func prevButtonTapped(_ sender: UIButton) {
        if position > 0 {
            position -= 1
            currentImage = imagesResults[position]
            updateImageView()
        }
    }

    @IBAction func sourceButtonTapped(_ sender: UIButton) {
        let webVC = storyboard?.instantiateViewController(withIdentifier: "WebPageViewController") as! WebPageViewController
            webVC.url = URL(string: currentImage.link)!
            present(webVC, animated: true, completion: nil)
    }
    
    // MARK: - Activity load indicator
    private func indicatorLoad() {

        indicator.color = UIColor.red
        indicator.frame = CGRectMake(0.0, 0.0, 20.0, 20.0)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.bringSubviewToFront(view)
        indicator.startAnimating()
    }
}

