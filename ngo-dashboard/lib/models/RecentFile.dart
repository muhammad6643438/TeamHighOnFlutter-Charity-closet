class RecentFile {
  final String? type, description, donator;
  DonationStatus? status;

  RecentFile({
    this.donator,
    this.type,
    this.description,
    this.status,
  });
}

enum DonationType { Donation, Disposal }

enum DonationStatus { Pending, Picked, Delivered }

List<RecentFile> demoRecentFiles = [
  RecentFile(
    type: DonationType.Donation.name,
    status: DonationStatus.Pending,
    description: "2 Pants, 3 Shirts",
    donator: "Anonymous",
  ),
  RecentFile(
    type: DonationType.Disposal.name,
    status: DonationStatus.Delivered,
    description: "1 Pants, 2 Shirts",
    donator: "Anonymous",
  ),
  RecentFile(
    type: DonationType.Donation.name,
    status: DonationStatus.Picked,
    description: "1 Pants, 2 Shirts",
    donator: "Anonymous",
  ),
  RecentFile(
    type: DonationType.Disposal.name,
    status: DonationStatus.Picked,
    description: "2 Pants, 3 Shirts",
    donator: "Anonymous",
  ),
  RecentFile(
    type: DonationType.Donation.name,
    status: DonationStatus.Pending,
    description: "2 Pants, 3 Shirts",
    donator: "Anonymous",
  ),
  RecentFile(
    type: DonationType.Disposal.name,
    status: DonationStatus.Pending,
    description: "1 Pants, 2 Shirts",
    donator: "Anonymous",
  ),
];
