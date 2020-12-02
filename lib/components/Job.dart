class Job {
  final String jobTitle;
  final String salary;
  final List<String> responsibility;
  final String image;
  final String location;
  final String hiringName;
  Job(
      {this.jobTitle,
      this.salary,
      this.responsibility,
      this.image,
      this.location,
      this.hiringName});
}

List<Job> JobList = [
  Job(
    jobTitle: "Driver",
    salary: "20k-30k",
    image: "driver",
    location: "Bengaluru",
  ),
  Job(
    jobTitle: "Cook",
    salary: "20k-30k",
    image: "cook",
    location: "Bengaluru",
  ),
  Job(
    jobTitle: "Sweeper",
    salary: "20k-30k",
    image: "sweeper",
    location: "Bengaluru",
  ),
  Job(
    jobTitle: "Laundry",
    salary: "20k-30k",
    image: "laundry",
    location: "Bengaluru",
  ),
  Job(
    jobTitle: "Sanitisation",
    salary: "20k-30k",
    image: "sanitisation",
    location: "Bengaluru",
  ),
  Job(
    jobTitle: "Construction",
    salary: "20k-30k",
    image: "construction",
    location: "Bengaluru",
  ),
  Job(
    jobTitle: "Plumber",
    salary: "20k-30k",
    image: "plumber",
    location: "Bengaluru",
  ),
  Job(
    jobTitle: "Electrician",
    salary: "20k-30k",
    image: "driver",
    location: "Bengaluru",
  ),
  Job(
    jobTitle: "Other",
    salary: "20k-30k",
    image: "driver",
    location: "Bengaluru",
  ),
];
