//
//  EventDetailsViewController.swift
//  AirHolland
//
//  Created by Atul Ghorpade on 12/10/21.
//

import UIKit

final class EventDetailsViewController: UIViewController, StoryboardInstantiable, Alertable {
    private var viewModel: EventDetailsViewModel!
    
    @IBOutlet private weak var flightNameDetailLabel: UILabel!
    @IBOutlet private weak var dateDetailLabel: UILabel!
    @IBOutlet private weak var aircraftTypeDetailLabel: UILabel!
    @IBOutlet private weak var tailDetailLabel: UILabel!
    @IBOutlet private weak var departureDetailLabel: UILabel!
    @IBOutlet private weak var destinationDetailLabel: UILabel!
    @IBOutlet private weak var departTimeDetailLabel: UILabel!
    @IBOutlet private weak var arriveTimeDetailLabel: UILabel!
    @IBOutlet private weak var dutyDetailLabel: UILabel!
    @IBOutlet private weak var captainDetailLabel: UILabel!
    @IBOutlet private weak var firstOfficerDetailLabel: UILabel!
    @IBOutlet private weak var flightAttendentDetailLabel: UILabel!
    
    static func create(with viewModel: EventDetailsViewModel) -> EventDetailsViewController {
        let view = EventDetailsViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
    }
    
    private func setupViews() {
        title = viewModel.screenTitle
    }
    
    private func bind(to viewModel: EventDetailsViewModel) {
        viewModel.flightName.observe(on: self) { [weak self] flightName in
            self?.flightNameDetailLabel.text = flightName
        }
        viewModel.dateDisplayString.observe(on: self) { [weak self] dateDisplayString in
            self?.dateDetailLabel.text = dateDisplayString
        }
        viewModel.aircraftType.observe(on: self) { [weak self] aircraftType in
            self?.aircraftTypeDetailLabel.text = aircraftType
        }
        viewModel.tail.observe(on: self) { [weak self] tail in
            self?.tailDetailLabel.text = tail
        }
        viewModel.departure.observe(on: self) { [weak self] departure in
            self?.departureDetailLabel.text = departure
        }
        viewModel.destination.observe(on: self) { [weak self] destination in
            self?.destinationDetailLabel.text = destination
        }
        viewModel.arriveTime.observe(on: self) { [weak self] arriveTime in
            self?.arriveTimeDetailLabel.text = arriveTime
        }
        viewModel.departTime.observe(on: self) { [weak self] departTime in
            self?.departTimeDetailLabel.text = departTime
        }
        viewModel.duty.observe(on: self) { [weak self] duty in
            self?.dutyDetailLabel.text = duty
        }
        viewModel.captain.observe(on: self) { [weak self] captain in
            self?.captainDetailLabel.text = captain
        }
        viewModel.firstOfficer.observe(on: self) { [weak self] firstOfficer in
            self?.firstOfficerDetailLabel.text = firstOfficer
        }
        viewModel.flightAttendant.observe(on: self) { [weak self] flightAttendant in
            self?.flightAttendentDetailLabel.text = flightAttendant
        }
    }
}
