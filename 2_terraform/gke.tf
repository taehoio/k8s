terraform {
  backend "gcs" {
    bucket = "taeho-terraform-state"
    prefix = "gke"
    region = "us-west1"
  }
}

provider "google" {
  version     = "~> 1.20"
  credentials = "${file("./gke-terraform-admin.json")}"
  project     = "taeho-io-220708"
  region      = "us-west1"
}

resource "google_container_cluster" "primary" {
  name                     = "taeho-cluster"
  zone                     = "us-west1-a"
  remove_default_node_pool = true
  min_master_version       = "1.12.6-gke.7"
  initial_node_count       = 3
}

resource "google_container_node_pool" "n1-standard-1-pool-1" {
  name       = "n1-standard-1-pool-1"
  zone       = "${google_container_cluster.primary.zone}"
  cluster    = "${google_container_cluster.primary.name}"
  version    = "1.12.6-gke.7"
  node_count = "3"

  node_config {
    #preemptible  = true
    machine_type = "n1-standard-1"
    disk_size_gb = 30

    metadata {
      disable-legacy-endpoints = "true"
    }

    # To access all GCP services
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  autoscaling {
    min_node_count = 3
    max_node_count = 3
  }

  management {
    auto_repair  = true
    auto_upgrade = false
  }
}
