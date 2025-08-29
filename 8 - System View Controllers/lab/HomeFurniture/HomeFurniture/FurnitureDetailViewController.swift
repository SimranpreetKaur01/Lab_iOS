
import UIKit

class FurnitureDetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var furniture: Furniture?
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var choosePhotoButton: UIButton!
    @IBOutlet var furnitureTitleLabel: UILabel!
    @IBOutlet var furnitureDescriptionLabel: UILabel!
    
    init?(coder: NSCoder, furniture: Furniture?) {
        self.furniture = furniture
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    func updateView() {
        guard let furniture = furniture else {return}
        if let imageData = furniture.imageData,
            let image = UIImage(data: imageData) {
            photoImageView.image = image
        } else {
            photoImageView.image = nil
        }
        
        furnitureTitleLabel.text = furniture.name
        furnitureDescriptionLabel.text = furniture.description
    }
    
    @IBAction func choosePhotoButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
                // Cancel Action
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                
                // Photo Library Action
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
                        let imagePicker = UIImagePickerController()
                        imagePicker.delegate = self
                        imagePicker.sourceType = .photoLibrary
                        self.present(imagePicker, animated: true, completion: nil)
                    }
                    alertController.addAction(photoLibraryAction)
                }
                
                // Camera Action
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                        let imagePicker = UIImagePickerController()
                        imagePicker.delegate = self
                        imagePicker.sourceType = .camera
                        self.present(imagePicker, animated: true, completion: nil)
                    }
                    alertController.addAction(cameraAction)
                }
                
                present(alertController, animated: true, completion: nil)
            }
            
            // MARK: - UIImagePickerControllerDelegate
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                dismiss(animated: true, completion: nil)
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if let image = info[.originalImage] as? UIImage,
                   let imageData = image.jpegData(compressionQuality: 0.9) {
                    furniture?.imageData = imageData
                    updateView()
                }
                dismiss(animated: true, completion: nil)
    }

    @IBAction func actionButtonTapped(_ sender: Any) {
        guard let furniture = furniture else { return }
                
                var items: [Any] = []
                
                if let imageData = furniture.imageData,
                   let image = UIImage(data: imageData) {
                    items.append(image)
                }
                
                items.append(furniture.description)
                
                let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
                present(activityVC, animated: true, completion: nil)
            }
    }
