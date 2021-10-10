//

import Foundation
import UIKit

final class EventCell: UITableViewCell {
    @IBOutlet private weak var titleImageLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var timeDescriptionLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    
    static let identifier = String(describing: EventCell.self)
    
    func fill(with viewModel: EventItemViewModel) {
        titleImageLabel.text = viewModel.imageName
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        timeDescriptionLabel.text = viewModel.timeDescription
        timeLabel.text = viewModel.time
    }
}
